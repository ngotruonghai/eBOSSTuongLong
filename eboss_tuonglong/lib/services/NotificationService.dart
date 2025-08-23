import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// QUAN TRỌNG: Hàm này phải là một top-level function (nằm ngoài bất kỳ class nào)
// và được đánh dấu bằng @pragma('vm:entry-point').
// Nó xử lý các tin nhắn nhận được khi ứng dụng đang ở trạng thái background hoặc terminated.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Nếu bạn cần khởi tạo các dịch vụ khác ở đây (như authentication, analytics),
  // hãy chắc chắn gọi `Firebase.initializeApp()` trước khi sử dụng chúng.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  // Tại đây, bạn có thể thực hiện các tác vụ nền như cập nhật dữ liệu,
  // lưu trữ thông báo vào local storage, v.v.
}

class NotificationService {
  // Singleton pattern để đảm bảo chỉ có một instance của service
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  static String FCMToken = "";

  NotificationService._internal();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Kênh thông báo cho Android.
  /// Bắt buộc phải có từ Android 8.0 trở lên.
  static final AndroidNotificationChannel _androidChannel =
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'Kênh này dùng cho các thông báo quan trọng.', // description
        importance: Importance.max,
      );

  /// Hàm khởi tạo chính, cần được gọi trong main.dart
  static Future<void> init() async {
    // 1. Yêu cầu quyền nhận thông báo trên iOS và các nền tảng Apple khác
    await _requestPermissions();

    // 2. Khởi tạo plugin local notifications
    await _initLocalNotifications();

    // 3. Lắng nghe và xử lý các sự kiện từ Firebase Messaging
    await _setupFirebaseListeners();
  }

  /// Lấy FCM token của thiết bị
  static Future<String?> getFCMToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');
      return token;
    } catch (e) {
      print('Không thể lấy FCM token: $e');
      return null;
    }
  }

  /// Yêu cầu quyền trên các thiết bị của Apple (iOS, macOS)
  static Future<void> _requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Người dùng đã cấp quyền');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('Người dùng đã cấp quyền tạm thời');
    } else {
      print('Người dùng từ chối hoặc chưa cấp quyền');
    }
  }

  /// Khởi tạo FlutterLocalNotificationsPlugin
  static Future<void> _initLocalNotifications() async {
    // Cài đặt cho Android
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Cài đặt cho iOS
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      // Xử lý khi người dùng nhấn vào thông báo (khi app đang chạy)
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Local notification tapped with payload: ${response.payload}');
        // Điều hướng hoặc xử lý logic tại đây
      },
    );

    // Tạo kênh thông báo cho Android
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);
  }

  /// Cài đặt các trình lắng nghe sự kiện của Firebase Messaging
  static Future<void> _setupFirebaseListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification}');

      String? title = message.notification?.title ?? message.data['title'];
      String? body = message.notification?.body ?? message.data['body'];

      if (title != null && body != null) {
        _localNotificationsPlugin.show(
          message.hashCode,
          title,
          body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
        );
      } else {
        print("⚠️ Không có title/body để hiển thị");
      }
    });
  }

  /// Hàm để kiểm tra và xử lý thông báo đã mở ứng dụng từ trạng thái terminated
  static Future<void> checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      print('App opened from terminated state by a notification!');
      print('Initial message data: ${initialMessage.data}');
      // Xử lý logic điều hướng tại đây
    }
  }
}

// CÁCH SỬ DỤNG TRONG main.dart
/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Khởi tạo notification service
  final notificationService = NotificationService();
  await notificationService.init();

  // Lấy token để gửi lên server của bạn
  await notificationService.getFCMToken();

  // Kiểm tra nếu app được mở từ một thông báo khi đã bị tắt
  await notificationService.checkForInitialMessage();

  runApp(const MyApp());
}
*/
