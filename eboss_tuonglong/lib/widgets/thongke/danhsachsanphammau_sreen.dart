import 'package:eboss_tuonglong/provider/danhsachsanphamprovider.dart';
import 'package:eboss_tuonglong/widgets/GiaoHangMau/chitietphieugiaohang_weidget.dart';
import 'package:eboss_tuonglong/widgets/thongke/chitietdanhsachsachsanpham_sreecn.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DanhSachSanPhamMauSreen extends StatefulWidget {
  const DanhSachSanPhamMauSreen({super.key});

  @override
  State<DanhSachSanPhamMauSreen> createState() =>
      _DanhSachSanPhamMauSreenStateState();
}

class _DanhSachSanPhamMauSreenStateState extends State<DanhSachSanPhamMauSreen>
    with SingleTickerProviderStateMixin {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectFormDate = DateTime.now();
  DateTime _selectToDate = DateTime.now();
  final TextEditingController _masanpham = TextEditingController();
  final TextEditingController _tenkhachhang = TextEditingController();
  final TextEditingController _nhanvienkinhoanh = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectFormDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    _selectToDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = Danhsachsanphamprovider();
        provider.LoadData(
          context,
          "",
          _dateFormat.format(_selectFormDate),
          _dateFormat.format(_selectToDate),
        );
        return provider;
      },
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tiến độ sản xuất'),
            backgroundColor: const Color(0xFF225F59),
          ),
          // ...existing code...
          body: Consumer<Danhsachsanphamprovider>(
            builder: (context, sanphamprovider, _) {
              if (sanphamprovider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (sanphamprovider.items.isEmpty) {
                return const Center(
                  child: Text(
                    "Không có dữ liệu",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh:
                    () => sanphamprovider.LoadData(
                      context,
                      "",
                      _dateFormat.format(_selectFormDate),
                      _dateFormat.format(_selectToDate),
                    ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: SizedBox(
                      width: 1150,
                      child: DataTable2(
                        showCheckboxColumn: false,
                        fixedTopRows: 1,
                        headingRowColor: MaterialStateProperty.all(
                          const Color(0xFF225F59),
                        ),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        columns: [
                          DataColumn2(
                            label: Text(
                              '${sanphamprovider.items.length}',
                            ), // Hiển thị tổng số lượng data
                            fixedWidth: 60,
                          ),
                          const DataColumn2(
                            label: Text('Phiếu yêu cầu'),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: Text('Ngày ghi nhận'),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: Text('Tên \nkhách hàng'),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: Text('Mã hàng'),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: Text('NV kinh doanh'),
                            size: ColumnSize.S,
                          ),
                            const DataColumn2(
                            label: Text('Ngày \ndự kiến \ncó hàng'),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: Text('Ngày KH \nphản hồi'),
                            size: ColumnSize.S,
                          ),
                            const DataColumn2(
                            label: Text('Ý kiến KH'),
                            size: ColumnSize.S,
                          ),
                            const DataColumn2(
                            label: Text('Ý kiến \nlãnh đạo'),
                            size: ColumnSize.S,
                          ),
                        
                        ],
                         rows:
                            sanphamprovider.items.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                                Color? getColorByStatus(bool? status) {
                                if (status == true) return Colors.green;
                                return null;
                              }

                              return DataRow(
                                onSelectChanged: (selected) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              ChiTietDanhsachSanphamSreecn(
                                                sampleID: item.sampleAID ?? '',
                                              ),
                                    ),
                                  );
                                },
                                cells: [
                                  DataCell(Text('${index + 1}')), // STT
                                  DataCell(
                                    Text(
                                      item.sampleID ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: getColorByStatus(
                                          item.isFinish,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.recordDate.toString().trim() ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.isFinish,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      (item.tenKhachHang??"").toString().trim() ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.isFinish,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.refOrderID ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.isFinish,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.nhanVienKinhDoanh ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.isFinish,
                                        ),
                                      ),
                                    ),
                                  ),
                                   DataCell(
                                    Text(
                                      item.finishProduceDate ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.isFinish,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.responseDate ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.isFinish,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.yKkienDanhGia?.toString() ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.isFinish,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.yKienKhachHang?.toString()??"",
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.isFinish,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // ...existing code...
          endDrawer: Drawer(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        context.read<Danhsachsanphamprovider>().LoadData(
                          context,
                          _masanpham.text,
                          _dateFormat.format(_selectFormDate),
                          _dateFormat.format(_selectToDate),
                        );
                        Navigator.pop(context);
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
          ),
        );
      },
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
