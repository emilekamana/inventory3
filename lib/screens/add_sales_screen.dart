import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/product_controller.dart';
import 'package:stock_management/controllers/sale_controller.dart';
import 'package:stock_management/models/product_model.dart';
import 'package:stock_management/models/sale_model.dart';
import 'package:stock_management/models/sold_product_model.dart';
import 'package:stock_management/utils/notifications_service.dart';
import 'package:stock_management/widgets/default_scaffold.dart';
import 'package:stock_management/widgets/leading_scaffold.dart';
import 'package:stock_management/widgets/sale_product_form.dart';

ProductController _productController = ProductController();

class AddSaleScreen extends StatefulWidget {
  AddSaleScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddSaleScreenState();
  }
}

SaleController _saleController = SaleController();

class _AddSaleScreenState extends State<AddSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final CollectionReference<Map<String, dynamic>> _products =
      _productController.productsCollection;

  late TextEditingController _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<String> chosenProductsIds = SaleProductForm.allForms
      .map((e) => e.productContoller!.dropDownValue.toString())
      .toList();

  Future<void> createNewSale() async {
    List<SoldProductModel> soldProducts = [];
    double total = 0;
    Map<String, double?> totalQty = {};
    for (var sale in SaleProductForm.allForms) {
      Product product =
          (sale.productContoller!.dropDownValue!.value as Product);
      String productId = product.id;
      if (totalQty[productId] == null) {
        totalQty[productId] = double.parse(product.qty);
      }
      totalQty[productId] =
          (totalQty[productId]! - double.parse(sale.qtyController.text));
      if (totalQty[productId]! < 0) {
        throw Exception('Available quantity exceeded for ${product.name}');
      }
      soldProducts.add(SoldProductModel(
          id: product.id,
          name: product.name,
          qty: sale.qtyController.text,
          price: sale.priceController.text));
      total = total + double.parse(sale.priceController.text);
    }
    totalQty.forEach((key, value) {
      _products.doc(key).update({'qty': value!.toString()});
      if (value < 5) {
        NotificationsService().sendNotification(
            0, "Stock limit", "Product $value is running out. Remember to restock");
      }
      totalQty[key] = null;
    });

    totalQty = {};

    Sale newSale = Sale(
        name: _nameController.text,
        products: soldProducts,
        total: total.toString(),
        dateTimeAdded: DateTime.now());
    await _saleController.createsale(newSale);
  }

  void addProduct(snapshot) {
    setState(() {
      SaleProductForm(
        snapshot: snapshot,
      );
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
    //       duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    // });
  }

  void removeProduct(element) {
    if (SaleProductForm.allForms.length > 1) {
      setState(() {
        SaleProductForm.allForms.remove(element);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LeadingScaffold(
      title: 'Add Sold Item',
      body: StreamBuilder(
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
                  Center(
                      child: Text(
                          "Unable to find any products! First add new products."))
                ],
              );
            }
            if (snapshot.hasData) {
              snapshot.data!.docs.removeWhere(
                  (element) => chosenProductsIds.contains(element.id));
              if (SaleProductForm.allForms.isEmpty) {
                SaleProductForm(
                  snapshot: snapshot,
                );
              }
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 14),
                        labelStyle: TextStyle(fontSize: 14),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value is String) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildForms(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RawMaterialButton(
                          onPressed: () => addProduct(snapshot),
                          elevation: 2.0,
                          fillColor: const Color(0xFF4796BD),
                          padding: const EdgeInsets.all(15.0),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.add,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                            // height: 50,
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.7, 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          child: const Text('Add Sale Entry'),
                          onPressed: () async {
                            // It returns true if the form is valid, otherwise returns false
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a Snackbar.

                              showLoadingSnackbar();
                              await createNewSale().then((value) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                }

                                showDoneSnackbar();

                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }).catchError((error) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                }
                                showErrorSnackbar(error);
                              });
                            }
                          },
                        )),
                      ],
                    ),
                  ],
                ),
              );
            }

            return const Text('No products yet!!');
          }),
    );
  }

  buildForms() {
    return Expanded(
      child: ListView.builder(
          physics: const ScrollPhysics(),
          controller: _scrollController,
          itemCount: SaleProductForm.allForms.length,
          // shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(child: SaleProductForm.allForms[index]),
                    IconButton(
                      onPressed: () =>
                          removeProduct(SaleProductForm.allForms[index]),
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      iconSize: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          }),
    );
  }

  void showLoadingSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color(0xFF4796BD),
        duration: Duration(days: 365),
        content: Text('Data is in processing.')));
  }

  void showDoneSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        content: Text('Done.')));
  }

  void showErrorSnackbar(error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        content: Text('Error: $error')));
  }
}
