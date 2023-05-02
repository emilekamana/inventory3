import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/product_controller.dart';
import 'package:stock_management/models/form_product_model.dart';
import 'package:stock_management/models/product_model.dart';
import 'package:stock_management/widgets/default_scaffold.dart';
import 'package:stock_management/widgets/new_product_form.dart';

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

  late bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      floatingButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/add_Stock');
        },
      ),
      title: "View Stock",
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
                      DataColumn(
                        label: Text('Actions'),
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
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () =>
                                      showEditDialog(context, product),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF4796BD),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () =>
                                      showDeleteDialog(context, product),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }).toList()),
              );
            }
            return const Center(child: Text('Something went wrong!!'));
          }),
    );
  }

  void showEditDialog(BuildContext context, Product product) {
    NewProductForm productForm =
        NewProductForm(productControllers: FormProductModel());

    productForm.productControllers.nameController.text = product.name;
    productForm.productControllers.qtyController.text = product.qty;
    productForm.productControllers.priceController.text = product.price;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    emptyControllers() {
      productForm.productControllers.nameController.text = '';
      productForm.productControllers.qtyController.text = '';
      productForm.productControllers.priceController.text = '';
    }

    // set up the buttons
    Widget cancelButton = TextButton(
      onPressed: _isLoading
          ? null
          : () {
              emptyControllers();
              if (context.mounted) Navigator.of(context).pop();
            },
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.red),
      ),
    );
    Widget updateButton = TextButton(
      onPressed: _isLoading
          ? null
          : () async {
              if (formKey.currentState!.validate()) {
                // If the form is valid, display a Snackbar.
                setState(() {
                  _isLoading = true;
                });
                product.name =
                    productForm.productControllers.nameController.text;
                product.qty = productForm.productControllers.qtyController.text;
                product.price =
                    productForm.productControllers.priceController.text;
                await _productController.updateProduct(product);

                emptyControllers();
                setState(() {
                  _isLoading = false;
                });
                if (context.mounted) Navigator.of(context).pop();
              }
            },
      child: const Text("Update"),
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text("Update item"),
      titleTextStyle: const TextStyle(
          color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 24),
      actions: [cancelButton, updateButton],
      content: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: productForm.formFields(),
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }

  void showDeleteDialog(BuildContext context, Product product) {
    // set up the buttons
    Widget cancelButton = TextButton(
      onPressed: _isLoading
          ? null
          : () {
              if (context.mounted) Navigator.of(context).pop();
            },
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.blue),
      ),
    );
    Widget deleteButton = TextButton(
      onPressed: _isLoading
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await _products.doc(product.id).delete();
              setState(() {
                _isLoading = false;
              });
              if (context.mounted) Navigator.of(context).pop();
            },
      child: const Text(
        "Delete",
        style: TextStyle(color: Colors.red),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text(
        "Delete item",
      ),
      titleTextStyle: const TextStyle(
          color: Colors.red, fontWeight: FontWeight.w500, fontSize: 24),
      actions: [cancelButton, deleteButton],
      content: const Text('Are you sure you want to delete the record?'),
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
