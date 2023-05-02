import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_management/models/product_model.dart';
// import 'package:get/get.dart';

class ProductController {
  CollectionReference<Map<String, dynamic>> get productsCollection =>
      FirebaseFirestore.instance.collection('products');

  Future createProduct(Product productModel) async {
    await productsCollection.add(productModel.toMap());
  }

  Future updateProduct(Product product) async {
    await productsCollection.doc(product.id).update(product.toMap());
  }
}
