import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_management/models/sale_model.dart';
// import 'package:get/get.dart';

class SaleController {
  CollectionReference<Map<String, dynamic>> get salesCollection =>
      FirebaseFirestore.instance.collection('sales');

  Future createsale(Sale saleModel) async {
    await salesCollection.add(saleModel.toMap());
  }

  Future updatesale(Sale sale) async {
    await salesCollection.doc(sale.id).update(sale.toMap());
  }
}
