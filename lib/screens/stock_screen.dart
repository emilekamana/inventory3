import 'package:flutter/material.dart';
import 'package:stock_management/widgets/default_scaffold.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StockScreenState();
  }
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      floatingButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      title: "View Stock",
      body: Container(
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
    );
  }
}
