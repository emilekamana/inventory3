import 'package:flutter/material.dart';
import 'package:stock_management/screens/home_screen.dart';
import 'package:stock_management/widgets/default_scaffold.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HistoryScreenState();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'History',
      body: Column(
        children: [
          SfDateRangePicker(
            headerStyle:
                DateRangePickerHeaderStyle(textAlign: TextAlign.center),
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3))),
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
              headingRowHeight: 80,
              dataRowHeight: 80,
              headingRowColor: MaterialStateColor.resolveWith(
                (states) {
                  return Colors.blue.shade400;
                },
              ),
              columns: const [
                DataColumn(
                  label: Text('Product name'),
                ),
                DataColumn(
                  label: Text('Quantity'),
                ),
                DataColumn(
                  label: Text('Price'),
                ),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('coco')),
                  DataCell(Text('100')),
                  DataCell(Text('2000')),
                ]),
                DataRow(cells: [
                  DataCell(Text('banana')),
                  DataCell(Text('30')),
                  DataCell(Text('400')),
                ]),
                DataRow(cells: [
                  DataCell(Text('onion')),
                  DataCell(Text('70')),
                  DataCell(Text('700')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Rice')),
                  DataCell(Text('20')),
                  DataCell(Text('1000')),
                ]),
                DataRow(cells: [
                  DataCell(Text('beans')),
                  DataCell(Text('30')),
                  DataCell(Text('100')),
                ]),
                DataRow(cells: [
                  DataCell(Text('potato')),
                  DataCell(Text('50')),
                  DataCell(Text('500')),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
