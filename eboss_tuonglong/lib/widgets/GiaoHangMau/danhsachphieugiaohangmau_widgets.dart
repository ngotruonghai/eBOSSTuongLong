import 'package:eboss_tuonglong/common/LanguageText.dart';
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
  final TextEditingController _tenkhachhang = TextEditingController();
  final TextEditingController _nhanvienkinhoanh = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Future<int> API_LoadDanhSachPhieuMuaHang(BuildContext context) async {
    Map<String, dynamic> request = {
      "tuNgay": _dateFormat.format(_selectFormDate),
      "denNgay": _dateFormat.format(_selectToDate),
      "type": widget.Type,
      "deliveryID": _masanpham.text,
      "tenKhachHang": _tenkhachhang.text,
      "nhanVienKinhDoanh": _nhanvienkinhoanh.text,
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
        title: LanguageText(nameId: widget.Type == 0
              ? "21"
              : widget.Type == 1
                  ? "19"
                  : "22", defaultValue: widget.Type == 0
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
                        lsDanhSachPhieuMuaHang.isEmpty
                            ? [
                              const Center(
                                child:LanguageText(nameId: "nodata", defaultValue: "Không có dữ liệu", style: TextStyle(fontSize: 16, color: Colors.grey))
                              ),
                            ]
                            : lsDanhSachPhieuMuaHang.map((item) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              ChiTietPhieuGiaoHangWidget(
                                                id: item.deliveryAID.toString(),
                                                deliveryAID:
                                                    item.maPhieu.toString(),
                                                salesManName:
                                                    item.nhanVienKinhDoanh ?.toString() ??"",
                                                    maPhieu: "${item.maPhieu.toString().trim()}",
                                                deliveryID: item.deliveryID?.toString().trim() ?? "",
                                                customerName: item.tenKhachHang?.toString().trim() ?? "",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item.maPhieu.toString().trim(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            // if (item.statusID == "02")
                                            //   const Icon(
                                            //     Icons.restart_alt_outlined,
                                            //     color: Colors.blue,
                                            //   ),
                                            // if (item.statusID == "01")
                                            //   const Icon(
                                            //     Icons.star_border_purple500,
                                            //     color: Colors.blue,
                                            //   ),
                                            // if (item.statusID == "03")
                                            //   const Icon(
                                            //     Icons.check_outlined,
                                            //     color: Colors.green,
                                            //   ),
                                            // if (item.statusID == "99")
                                            //   const Icon(
                                            //     Icons.highlight_off,
                                            //     color: Colors.red,
                                            //   ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        LanguageText2(nameId: "13",defaultValue: "Ngày ghi nhận",textstring: ": " + item.recordDate.toString(), style: const TextStyle(fontSize: 13)),
                                        const SizedBox(height: 4),
                                        LanguageText2(
                                          nameId: "12",
                                          defaultValue: "Dự kiến trả lời",
                                          textstring: ": " + item.responseDate.toString(),
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        const SizedBox(height: 4),
                                         LanguageText2(
                                          nameId: "16",
                                          defaultValue: "Nhân viên kinh doanh",
                                          textstring: ": " + item.responseDate.toString(),
                                          style: const TextStyle(fontSize: 13),
                                        )
                                        ,
                                        const SizedBox(height: 4),
                                         LanguageText2(
                                          nameId: "36",
                                          defaultValue: "Ý kiến khách hàng",
                                          textstring: ": " + item.responseDate.toString(),
                                          style: const TextStyle(fontSize: 13),
                                        )
                                        ,
                                        const SizedBox(height: 4),
                                        Text(
                                          item.loaiPhieu.toString(),
                                          // style: TextStyle(
                                          //   color:
                                          //       item.statusID == "03"
                                          //           ? Colors.green
                                          //           : item.statusID == "99"
                                          //           ? Colors.red
                                          //           : Colors.blue,
                                          //   fontWeight: FontWeight.bold,
                                          // ),
                                        ),
                                        const SizedBox(height: 4),
                                        if (item.stattustSoNgayDaQua == 1)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            height: 5,
                                          ),
                                        if (item.stattustSoNgayDaQua == 0)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
        child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LanguageText(
                nameId: "tenkhachhang",
                defaultValue: "Tên khách hàng",
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
              TextField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: _tenkhachhang,
              ),
              SizedBox(height: 20),
               LanguageText(
                nameId: "16",
                defaultValue: "Nhân viên kinh doanh",
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
              TextField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: _nhanvienkinhoanh,
              ),
              SizedBox(height: 20),
              LanguageText(
                nameId: "39",
                defaultValue: "Số phiếu giao",
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
              TextField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                controller: _masanpham,
              ),
              const SizedBox(height: 20),
              LanguageText(
                nameId: "34",
                defaultValue: "Từ ngày",
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
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
               LanguageText(
                nameId: "7",
                defaultValue: "Đến ngày",
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
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
                child:LanguageText(
                nameId: "32",
                defaultValue: "TÌm kiếm",
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
              ),
            ],
          ),
        ),
        )),
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
