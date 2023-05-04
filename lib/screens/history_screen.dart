import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoryScreenState();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'History Page',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('History Page'),
            backgroundColor: const Color(0xFF4796BD),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Sales'),
                Tab(text: 'Inventory'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Product')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Revenue')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Product 1')),
                      DataCell(Text('10')),
                      DataCell(Text('\$50')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Product 2')),
                      DataCell(Text('20')),
                      DataCell(Text('\$100')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Product 3')),
                      DataCell(Text('5')),
                      DataCell(Text('\$25')),
                    ]),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Product')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Price')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Product 4')),
                      DataCell(Text('15')),
                      DataCell(Text('\$75')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Product 5')),
                      DataCell(Text('25')),
                      DataCell(Text('\$125')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Product 6')),
                      DataCell(Text('8')),
                      DataCell(Text('\$40')),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _selectDate(context);
            },
            child: const Icon(Icons.calendar_today),
          ),
         
              
        ),
      ),
    );
  }
}
