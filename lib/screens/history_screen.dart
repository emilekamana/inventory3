import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/product_controller.dart';
import 'package:stock_management/controllers/sale_controller.dart';
import 'package:stock_management/models/product_model.dart';
import 'package:stock_management/models/sale_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoryScreenState();
  }
}

SaleController _saleController = SaleController();
ProductController _productController = ProductController();

class _HistoryScreenState extends State<HistoryScreen> {
  final CollectionReference<Map<String, dynamic>> _sales =
      _saleController.salesCollection;
  final CollectionReference<Map<String, dynamic>> _products =
      _productController.productsCollection;
  DateTimeRange? selectedDateRange;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange ??
          DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 3)),
              end: DateTime.now().add(const Duration(days: 3))),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = selectedDateRange;
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
                child: StreamBuilder(
          stream: _sales.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasData == false) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF4796BD))),
                    // Loader Animation Widget
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                  ],
                ),
              );
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Column(
                children: const <Widget>[
                  Center(child: Text("Unable to find any records"))
                ],
              );
            }

            if (snapshot.hasData) {
              return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: DataTable(
                  dividerThickness: 0.0,
                  headingTextStyle: const TextStyle(
                    color: Color.fromARGB(255, 137, 137, 137),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  headingRowHeight: 60,
                  dataRowHeight: 60,
                  dataTextStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  columnSpacing: 20.0,
                  columns: const [
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('Products'),
                    ),
                    DataColumn(
                      label: Text('Total'),
                    ),
                    DataColumn(
                      label: Text('Date'),
                    ),
                  ],
                  rows: snapshot.data!.docs.map((doc) {
                    Sale sale = Sale.fromSnapshot(doc);
                    return DataRow(cells: <DataCell>[
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Text(
                            sale.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.3,
                          ),
                          child: Text(
                            sale.products.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Text(
                            sale.total,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          sale.dateTimeAdded.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              );
            }
            return const Center(child: Text('Something went wrong!!'));
          }),
              ),
              SingleChildScrollView(
                child: StreamBuilder(
          stream: _products.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasData == false) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF4796BD))),
                    // Loader Animation Widget
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                  ],
                ),
              );
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Column(
                children: const <Widget>[
                  Center(child: Text("Unable to find any records"))
                ],
              );
            }

            if (snapshot.hasData) {
              return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: DataTable(
                    dividerThickness: 0.0,
                    headingTextStyle: const TextStyle(
                      color: Color.fromARGB(255, 137, 137, 137),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    headingRowHeight: 60,
                    dataRowHeight: 60,
                    dataTextStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    columnSpacing: 20.0,
                    columns: const [
                      DataColumn(
                        label: Text('Name'),
                      ),
                      DataColumn(
                        label: Text('Quantity'),
                      ),
                      DataColumn(
                        label: Text('Price'),
                      ),
                    ],
                    rows: snapshot.data!.docs.map((doc) {
                      Product product = Product.fromSnapshot(doc);
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.25,
                              ),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ),
                          DataCell(Text(product.qty)),
                          DataCell(Text(product.price)),
                          
                        ],
                      );
                    }).toList()),
              );
            }
            return const Center(child: Text('Something went wrong!!'));
          }),
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
