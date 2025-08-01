import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogMessage_Error {
  static Future<void> showMyDialog(BuildContext context, String Message) async {
    String languagename = "VN";
    if (SharedPreferencesService.containsKey(KeyServices.Language) == true) {
      languagename =
          SharedPreferencesService.getString(KeyServices.Language) ?? 'VI';
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Set border radius here
            side: BorderSide(
              color: Colors.white, // Set border color here
              width: 2.0, // Set border width here
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languagename == "EN"? "Notification": "Thông báo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Image(
              //   image: AssetImage("assets/lego_eboss.png"),
              //   width: 30,
              //   height: 30,
              // ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  Message,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: "Roboto",
                  ),
                ),
                //Text('Vui lòng kiểm tra lại hoặc liên hệ với nhân sự!.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(languagename == "EN"? "Confirm": "Xác nhận"),
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
