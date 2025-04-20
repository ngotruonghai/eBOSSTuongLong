import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:eboss_tuonglong/widgets/GiaoHangMau/chitietphieugiaohang_weidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/PhieuMuaHang/danhsachphieumuahangmodel.dart';
import 'package:table_calendar/table_calendar.dart';

class DanhSachPhieuGiaoHangMauWidgets extends StatefulWidget {
  final int Type;
  const DanhSachPhieuGiaoHangMauWidgets({super.key, required this.Type});

  @override
  State<DanhSachPhieuGiaoHangMauWidgets> createState() =>
      _DanhSachPhieuGiaoHangMauWidgetsState();
}

class _DanhSachPhieuGiaoHangMauWidgetsState
    extends State<DanhSachPhieuGiaoHangMauWidgets> {
  late List<Data> lsDanhSachPhieuMuaHang = [];
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectFormDate = DateTime.now();
  DateTime _selectToDate = DateTime.now();
  final TextEditingController _masanpham = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Future<int> API_LoadDanhSachPhieuMuaHang(BuildContext context) async {
    Map<String, dynamic> request = {
      "tuNgay": _dateFormat.format(_selectFormDate),
      "denNgay": _dateFormat.format(_selectToDate),
      "type": widget.Type,
      "deliveryID": _masanpham.text,
    };

    final response = await NetWorkRequest.PostDefault(
      "/api/PhieuGiaoHang/DanhSachPhieuMuaHang",
      request,
      context,
    );

    final parsed = DanhSachPhieuMuaHangModel.fromJson(response);
    lsDanhSachPhieuMuaHang = parsed.data ?? [];

    return 1;
  }

  Future<bool> loadData(BuildContext context) async {
    try {
      await API_LoadDanhSachPhieuMuaHang(context);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _refreshData() async {
    lsDanhSachPhieuMuaHang = [];
    await loadData(context);
    setState(() {
      API_LoadDanhSachPhieuMuaHang(context);
    });
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime? initialDate,
    Function(DateTime) onDateSelected,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('vi'),
    );
    if (picked != null) onDateSelected(picked);
  }
@override
void initState() {
  super.initState();
  _selectFormDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  _selectToDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F615C),
        title: Text(
          widget.Type == 0
              ? "Phiếu giao hàng mẫu"
              : widget.Type == 1
              ? "Phiếu giao đến hạn"
              : "Phiếu giao quá hạn",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<bool>(
          future: loadData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF1F615C)),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children:
                        lsDanhSachPhieuMuaHang.map((item) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ChiTietPhieuGiaoHangWidget(
                                        id: item.deliveryAID.toString(),
                                        deliveryAID: item.maPhieu.toString(),
                                      ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.maPhieu.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        if (item.statusID == "02")
                                          const Icon(
                                            Icons.restart_alt_outlined,
                                            color: Colors.blue,
                                          ),
                                        if (item.statusID == "01")
                                          const Icon(
                                            Icons.star_border_purple500,
                                            color: Colors.blue,
                                          ),
                                        if (item.statusID == "03")
                                          const Icon(
                                            Icons.check_outlined,
                                            color: Colors.green,
                                          ),
                                        if (item.statusID == "99")
                                          const Icon(
                                            Icons.highlight_off,
                                            color: Colors.red,
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Ngày ghi nhận: ${item.recordDate}",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Dự kiến trả lời: ${item.responseDate ?? "_"}",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Nhân viên kinh doanh: ${item.nhanVienKinhDoanh ?? "_"}",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Nhân viên xử lý: ${item.nhanVienXuLy ?? "_"}",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.loaiPhieu.toString(),
                                      style: TextStyle(
                                        color:
                                            item.statusID == "03"
                                                ? Colors.green
                                                : item.statusID == "99"
                                                ? Colors.red
                                                : Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    if (item.stattustSoNgayDaQua == 3)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellowAccent,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        height: 5,
                                      ),
                                    if (item.stattustSoNgayDaQua == 2)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        height: 5,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ),
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Mã số sản phẩm"),
              TextField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: _masanpham,
              ),
              const SizedBox(height: 20),
              const Text("Từ ngày"),
              InkWell(
                onTap: () {
                  _showCalendarFormDatePopup(context);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _selectFormDate != null
                        ? _dateFormat.format(_selectFormDate!)
                        : "Chọn ngày",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Đến ngày"),
              InkWell(
                onTap: () {
                  _showCalendarToDatePopup(context);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _selectToDate != null
                        ? _dateFormat.format(_selectToDate!)
                        : "Chọn ngày",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // đóng Drawer
                  _refreshData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F615C),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Tìm kiếm"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCalendarFormDatePopup(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.6,
              child: TableCalendar(
                focusedDay: _selectFormDate,
                rowHeight: 32,
                locale: "vi_VN",
                //headerVisible: false,
                //headerVisible: false,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false, // Ẩn nút chuyển đổi định dạng
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                  ), // Màu chữ của tiêu đề
                  decoration: BoxDecoration(
                    color: Colors.blue, // Màu nền của header
                  ),
                ),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue, // Màu sắc khi ngày được chọn
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ), // Ẩn các ngày ngoài phạm vi của tháng hiện tại
                ),
                calendarFormat: _calendarFormat,
                availableCalendarFormats: {
                  CalendarFormat.week:
                      'Tuần', // Chỉ có định dạng "Week" (1 tuần)
                  CalendarFormat.month: 'Tháng', // Định dạng "Month" (tháng)
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectFormDate = selectedDay;
                  });
                  Navigator.pop(context); // Đóng popup sau khi chọn ngày
                  // Thêm bất kỳ xử lý nào bạn muốn sau khi chọn ngày ở đây
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectFormDate, day);
                },
              ),
            ),
          ),
    );
  }

  void _showCalendarToDatePopup(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width * 1.5,
              height: MediaQuery.of(context).size.height * 0.6,
              child: TableCalendar(
                rowHeight: 32,
                locale: "vi_VN",
                focusedDay: _selectToDate,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                calendarFormat: _calendarFormat,
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue, // Màu sắc khi ngày được chọn
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ), // Ẩn các ngày ngoài phạm vi của tháng hiện tại
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false, // Ẩn nút chuyển đổi định dạng
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                  ), // Màu chữ của tiêu đề
                  decoration: BoxDecoration(
                    color: Colors.blue, // Màu nền của header
                  ),
                ),
                availableCalendarFormats: {
                  CalendarFormat.week:
                      'Tuần', // Chỉ có định dạng "Week" (1 tuần)
                  CalendarFormat.month: 'Tháng', // Định dạng "Month" (tháng)
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectToDate = selectedDay;
                  });
                  Navigator.pop(context); // Đóng popup sau khi chọn ngày
                  // Thêm bất kỳ xử lý nào bạn muốn sau khi chọn ngày ở đây
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectToDate, day);
                },
              ),
            ),
          ),
    );
  }
}
