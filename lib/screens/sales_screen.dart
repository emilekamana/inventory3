import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/sale_controller.dart';
import 'package:stock_management/models/sale_model.dart';
import 'package:stock_management/widgets/default_scaffold.dart';
import 'package:stock_management/widgets/sales_table.dart';

SaleController _saleController = SaleController();

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SalesScreenState();
  }
}

class _SalesScreenState extends State<SalesScreen> {
  final CollectionReference<Map<String, dynamic>> _sales =
      _saleController.salesCollection;
  getData() {
    _sales.snapshots().where((event) => false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      floatingButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/add_sale'),
      ),
      title: "Sales",
      body: SalesTable(
        sales: _sales.snapshots(),
      ),
    );
  }
}
