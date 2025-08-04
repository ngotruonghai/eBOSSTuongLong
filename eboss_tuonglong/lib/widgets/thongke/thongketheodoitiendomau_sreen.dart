import 'package:data_table_2/data_table_2.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/provider/theodoitiendomauprovider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ThongketheodoitiendomauSreen extends StatefulWidget {
  const ThongketheodoitiendomauSreen({super.key});

  @override
  State<ThongketheodoitiendomauSreen> createState() =>
      _ThongketheodoitiendomauSreenState();
}

class _ThongketheodoitiendomauSreenState
    extends State<ThongketheodoitiendomauSreen>
    with SingleTickerProviderStateMixin {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  DateTime _selectFormDate = DateTime.now();
  DateTime _selectToDate = DateTime.now();
  final TextEditingController _refOrderID = TextEditingController();
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = TheoDoiTienDoMauProvider();
        provider.LoadDanhSachTheoDoiTienDo(context, 
          _dateFormat.format(_selectFormDate),
          _dateFormat.format(_selectToDate), 
          '', '', '');
        return provider;
      },
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: LanguageText(
              nameId: "theodoitiendomau",
              defaultValue: "Theo dõi tiến độ mẫu",
            ),
            backgroundColor: const Color(0xFF225F59),
          ),
          body: Consumer<TheoDoiTienDoMauProvider>(
            builder: (context, theodoitiendomauprovider, _)  {
              if (theodoitiendomauprovider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (theodoitiendomauprovider.items.isEmpty) {
                return const Center(
                  child: Text(
                    "Không có dữ liệu",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return RefreshIndicator(
                 onRefresh:
                    () =>
                        theodoitiendomauprovider.LoadDanhSachTheoDoiTienDo(
                          context,
                          _dateFormat.format(_selectFormDate),
                          _dateFormat.format(_selectToDate),
                          "",
                          "",""
                        ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(padding: const EdgeInsets.only(bottom: 24),
                  child:  SizedBox(
                     width: 1400,
                     child: DataTable2(
                        showCheckboxColumn:
                            false, // Thêm dòng này để ẩn checkbox
                        fixedTopRows: 1,
                        headingRowColor: MaterialStateProperty.all(
                          const Color(0xFF225F59),
                        ),
                        columnSpacing: 8,
                        horizontalMargin: 8,
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        columns: [
                          DataColumn2(
                            label: Center(
                              child: Text('${theodoitiendomauprovider.items.length}'),
                            ),                            
                            fixedWidth:
                                50, // hoặc ColumnSize.S nếu muốn dùng size mặc định
                          ),
                          const DataColumn2(
                            label: LanguageText(
                              nameId: "madonhang",
                              defaultValue: "Mã đơn hàng",
                            ),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "tenkhachhang", defaultValue: "Tên khách hàng"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "16", defaultValue: "Nhân viên kinh doanh"),
                            size: ColumnSize.L,
                          ),
                           const DataColumn2(
                            label: LanguageText(nameId: "YarnDate", defaultValue: "Ngày có sợi"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "GreigeFabicDate", defaultValue: "Ngày có vải mộc"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "NgayCoVaiThanhPham", defaultValue: "Ngày có vải thành phẩm"),
                            size: ColumnSize.L,
                          ),
                           const DataColumn2(
                            label: LanguageText(nameId: "NgayCoKetQuaTest", defaultValue: "Ngày có kết quả test"),
                            size: ColumnSize.L,
                          ),
                           const DataColumn2(
                            label: LanguageText(nameId: "NgayCoHanger", defaultValue: "Ngày có hanger"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "NhanXetHangNhapKho", defaultValue: "Nhận xét hàng nhập kho"),
                            size: ColumnSize.L,
                          ),
                        ],
                        rows:
                            theodoitiendomauprovider.items.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                              Color? getColorByStatus(int? status) {
                                if (status == 1) return Colors.red;
                                if (status == 0) return Colors.black;
                                return null;
                              }

                              return DataRow(
                                
                                cells: [
                                  DataCell(Center(child: Text('${index + 1}'))), // STT
                                  DataCell(
                                    Text(
                                      item.maDonHang ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.tenKhachHang.toString().trim() ?? '',
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.nhanVienKinhDoanh??"".toString().trim() ?? '',
                                     
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.ngayCoSoi ?? '',
                                     
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.ngayCoVaiMoc ?? '',
                                     
                                    ),
                                  ),
                                   DataCell(
                                    Text(
                                      item.ngayCoVaiThanhPhan ?? '',
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.ngayCoKetQuaTest ?? '',
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.ngayCoHanger ?? '',
                                    ),
                                  ),
                                  DataCell(
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => AlertDialog(
                                                title: const LanguageText(
                                                  nameId: "NhanXetHangNhapKho",
                                                  defaultValue:
                                                      "Nhận xét hàng nhập kho",
                                                ),
                                                content: SingleChildScrollView(
                                                  child: Text(
                                                    item.nhanXetHangNhapKho
                                                            ?.toString() ??
                                                        '',
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed:
                                                        () => Navigator.pop(
                                                          context,
                                                        ),
                                                    child: LanguageText(nameId: "dong", defaultValue: "Đóng",
                                                    style: TextStyle(fontSize: 13, color: Colors.black),),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          item.nhanXetHangNhapKho?.toString() ?? '',
                                          // <<< SỬA Ở ĐÂY
                                          maxLines:
                                              2, // Chỉ hiển thị tối đa 2 dòng
                                          overflow:
                                              TextOverflow
                                                  .ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                  )),
                )
              );
            },
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: _tenkhachhang,
                    ),
                    SizedBox(height: 20),
                    const  LanguageText(
                nameId: "16",
                defaultValue: "Nhân viên kinh doanh",
                style: const TextStyle(fontSize: 13, color: Colors.black),
              ),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: _nhanvienkinhoanh,
                    ),
                    SizedBox(height: 20),
                    const LanguageText(
                      nameId: "refOrderID",
                      defaultValue: "Mã đơn hàng",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: _refOrderID,
                    ),
                    const SizedBox(height: 20),
                    const LanguageText(
                      nameId: "34",
                      defaultValue: "Từ ngày",
                      style: TextStyle(fontSize: 13, color: Colors.black),
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
                    const LanguageText(
                      nameId: "7",
                      defaultValue: "Đến ngày",
                      style: TextStyle(fontSize: 13, color: Colors.black),
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
                        context
                            .read<TheoDoiTienDoMauProvider>()
                            .LoadDanhSachTheoDoiTienDo(
                              context,
                              _dateFormat.format(_selectFormDate),
                              _dateFormat.format(_selectToDate),
                              _refOrderID.text,
                              _tenkhachhang.text,
                              _nhanvienkinhoanh.text,
                            );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F615C),
                        foregroundColor: Colors.white,
                      ),
                      child: LanguageText(defaultValue: "Tìm kiếm", nameId: "32",),
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