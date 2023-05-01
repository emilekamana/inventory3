import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_management/models/product_model.dart';
// import 'package:get/get.dart';

class ProductController {
  final _productsCollection = FirebaseFirestore.instance.collection('products');
  
  Future createProduct(Product productModel) async {
    await _productsCollection.add(productModel.toMap());
  }
}
