import 'package:data_table_2/data_table_2.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';
import 'package:eboss_tuonglong/provider/giaohangmauprovider.dart';
import 'package:eboss_tuonglong/widgets/thongke/chitietsanphammau_srceen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:eboss_tuonglong/component/phieugiaohang/NhapYKien_srceen.dart';

class ThongKeGiaoHangMauSrceen extends StatefulWidget {
  const ThongKeGiaoHangMauSrceen({super.key});

  @override
  State<ThongKeGiaoHangMauSrceen> createState() =>
      _ThongKeGiaoHangMauSrceenState();
}

class _ThongKeGiaoHangMauSrceenState extends State<ThongKeGiaoHangMauSrceen> {
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
        final provider = GiaoHangMauProvider();
        provider.LoadDataDanhSachPhanQuyenPhieuGiaoHanh(
          context,
          "",
          "",
          "",
          "",
          _dateFormat.format(_selectFormDate),
          _dateFormat.format(_selectToDate),
        );
        return provider;
      },
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: LanguageText(
              nameId: "theodoitiengiaohangmau",
              defaultValue: "Theo dõi phiếu giao hàng mẫu",
            ),
            backgroundColor: const Color(0xFF225F59),
          ),
          body: Consumer<GiaoHangMauProvider>(
            builder: (context, giaoHangProvider, _) {
              if (giaoHangProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (giaoHangProvider.items.isEmpty) {
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
                        giaoHangProvider.LoadDataDanhSachPhanQuyenPhieuGiaoHanh(
                          context,
                          "",
                          "",
                          "",
                          "",
                          _dateFormat.format(_selectFormDate),
                          _dateFormat.format(_selectToDate),
                        ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: SizedBox(
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
                              child: Text('${giaoHangProvider.items.length}'),
                            ),
                            fixedWidth: 50, // hoặc ColumnSize.S nếu muốn dùng size mặc định                            
                          ),
                          const DataColumn2(
                            label: LanguageText(
                              nameId: "39",
                              defaultValue: "Số phiếu giao",
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
                            label: LanguageText(nameId: "12", defaultValue: "Ngày dự kiến trả lời"),
                            size: ColumnSize.L,
                          ),
                           const DataColumn2(
                            label: LanguageText(nameId: "36", defaultValue: "Ý kiến khách hàng"),
                            size: ColumnSize.L,
                          ),
                           const DataColumn2(
                            label: LanguageText(nameId: "", defaultValue: "..."),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "37", defaultValue: "Ý kiến ban lãnh đạo"),
                            size: ColumnSize.L,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "", defaultValue: "..."),
                            size: ColumnSize.S,
                          ),
                          const DataColumn2(
                            label: LanguageText(nameId: "ResponseDay", defaultValue: "Số ngày KH phản hồi"),
                            size: ColumnSize.S,
                          ),
                        ],
                        rows:
                            giaoHangProvider.items.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                              Color? getColorByStatus(int? status) {
                                if (status == 1) return Colors.red;
                                if (status == 0) return Colors.black;
                                return null;
                              }

                              return DataRow(
                                onSelectChanged: (selected) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              ChiTietPhieuGiaoHangMauSrceen(
                                                deliveryAID:
                                                    item.deliveryAID ?? '',
                                                id: "",
                                              ),
                                    ),
                                  );
                                },
                                cells: [
                                  DataCell(Center(child: Text('${index + 1}'))), // STT
                                  DataCell(
                                    Text(
                                      item.deliveryID ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.stattustSoNgayDaQua,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.tenKhachHang.toString().trim() ?? '',
                                        style: TextStyle(
                                          color: getColorByStatus(
                                            item.stattustSoNgayDaQua,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),                                   
                                  DataCell(
                                    Text(
                                      item.nhanVienKinhDoanh??"".toString().trim() ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.stattustSoNgayDaQua,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.responseDate ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.stattustSoNgayDaQua,
                                        ),
                                      ),
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
                                                  nameId: "36",
                                                  defaultValue:
                                                      "Ý kiến khách hàng",
                                                ),
                                                content: SingleChildScrollView(
                                                  // Dùng SingleChildScrollView nếu nội dung rất dài
                                                  child: Text(
                                                    item.YKienKhachHang
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
                                          item.YKienKhachHang?.toString() ?? '',
                                          // <<< SỬA Ở ĐÂY
                                          maxLines:
                                              2, // Chỉ hiển thị tối đa 2 dòng
                                          overflow:
                                              TextOverflow
                                                  .ellipsis, // Hiển thị "..." nếu dài hơn
                                          style: TextStyle(
                                            color: getColorByStatus(
                                              item.stattustSoNgayDaQua,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    GestureDetector(
                                      onTap: () {
                                        final currentItem = item;
                                        showDialog(
                                          context: context,
                                          builder: (context) => NhapykienSrceen(
                                            ItemAID: "${currentItem.deliveryAID}",
                                            ItemID: "${currentItem.deliveryID}",
                                            Type: "01",
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit_note_outlined,
                                          color: getColorByStatus(item.stattustSoNgayDaQua),
                                          size: 30,                                     
                                      ),
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
                                                  nameId: "37",
                                                  defaultValue:
                                                      "Ý kiến ban lãnh đạo",
                                                ),
                                                content: SingleChildScrollView(
                                                  // Dùng SingleChildScrollView nếu nội dung rất dài
                                                  child: Text(
                                                    item.YKienLanhDao
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
                                          item.YKienLanhDao?.toString() ?? '',
                                          // <<< SỬA Ở ĐÂY
                                          maxLines:
                                              2, // Chỉ hiển thị tối đa 2 dòng
                                          overflow:
                                              TextOverflow
                                                  .ellipsis, // Hiển thị "..." nếu dài hơn
                                          style: TextStyle(
                                            color: getColorByStatus(
                                              item.stattustSoNgayDaQua,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    GestureDetector(
                                      onTap: () {
                                        final currentItem = item;
                                        showDialog(
                                          context: context,
                                          builder: (context) => NhapykienSrceen(
                                            ItemAID: "${currentItem.deliveryAID}",
                                            ItemID: "${currentItem.deliveryID}",
                                            Type: "02",
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.edit_note_outlined,
                                          color: getColorByStatus(item.stattustSoNgayDaQua),
                                          size: 30,                                     
                                      ),
                                    ),
                                  ),
                                   DataCell(
                                    Text(
                                      item.responseDay ?? '',
                                      style: TextStyle(
                                        color: getColorByStatus(
                                          item.stattustSoNgayDaQua,
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
                      nameId: "39",
                      defaultValue: "Số phiếu giao",
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: _masanpham,
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
                            .read<GiaoHangMauProvider>()
                            .LoadDataDanhSachPhanQuyenPhieuGiaoHanh(
                              context,
                              "",
                              _masanpham.text,
                              _tenkhachhang.text,
                              _nhanvienkinhoanh.text,
                              _dateFormat.format(_selectFormDate),
                              _dateFormat.format(_selectToDate),
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
