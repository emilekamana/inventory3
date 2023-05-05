import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/product_controller.dart';
import 'package:stock_management/models/form_product_model.dart';
import 'package:stock_management/models/product_model.dart';
import 'package:stock_management/widgets/default_scaffold.dart';
import 'package:stock_management/widgets/new_product_form.dart';
import 'package:stock_management/widgets/stock_table.dart';

ProductController _productController = ProductController();

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StockScreenState();
  }
}

class _StockScreenState extends State<StockScreen> {
  final CollectionReference<Map<String, dynamic>> _products =
      _productController.productsCollection;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      floatingButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/add_Stock');
        },
      ),
      title: "Stock",
      body: StockTable(
        products: _products.snapshots(),
      ),
    );
  }
}
