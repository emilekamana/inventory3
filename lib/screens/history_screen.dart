import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/product_controller.dart';
import 'package:stock_management/controllers/sale_controller.dart';
import 'package:stock_management/models/product_model.dart';
import 'package:stock_management/models/sale_model.dart';
import 'package:stock_management/widgets/default_scaffold.dart';
import 'package:stock_management/widgets/sales_table.dart';
import 'package:stock_management/widgets/stock_table.dart';

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
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
                maxHeight: MediaQuery.of(context).size.height * 0.8),
            child: child,
          ),
        ],
      ),
    );
    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDateRange = null;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: DefaultScaffold(
        scrollable: false,
        floatingButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            selectedDateRange == null
                ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                : TextButton(
                    onPressed: () {
                      setState(() {
                        selectedDateRange = null;
                      });
                    },
                    child: const Text(
                      'Clear dates',
                      style: TextStyle(color: Colors.red),
                    )),
            FloatingActionButton(
              onPressed: () {
                _selectDate(context);
              },
              child: const Icon(Icons.calendar_today),
            ),
          ],
        ),
        title: 'History',
        bottom: const TabBar(
          tabs: [
            Tab(text: 'Sales'),
            Tab(text: 'Inventory'),
          ],
        ),
        body: TabBarView(
          children: selectedDateRange != null
              ? [
                  SalesTable(
                      sales: _sales
                          .where('dateTimeAdded',
                              isGreaterThanOrEqualTo: selectedDateRange!
                                  .start.millisecondsSinceEpoch)
                          .where('dateTimeAdded',
                              isLessThanOrEqualTo:
                                  selectedDateRange!.end.millisecondsSinceEpoch)
                          .snapshots()),
                  StockTable(
                      products: _products
                          .where('dateTimeAdded',
                              isGreaterThanOrEqualTo: selectedDateRange!
                                  .start.millisecondsSinceEpoch)
                          .where('dateTimeAdded',
                              isLessThanOrEqualTo:
                                  selectedDateRange!.end.millisecondsSinceEpoch)
                          .snapshots()),
                ]
              : [
                  SalesTable(sales: _sales.snapshots()),
                  StockTable(products: _products.snapshots()),
                ],
        ),
      ),
    );
  }
}
