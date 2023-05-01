import 'package:flutter/material.dart';
import 'package:stock_management/models/form_product_model.dart';
import 'package:stock_management/widgets/leading_scaffold.dart';
import 'package:stock_management/widgets/new_product_form.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddStockScreenState();
  }
}

class _AddStockScreenState extends State<AddStockScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FormProductModel initialController = FormProductModel();
  late List<NewProductForm> productForms = [];
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    productForms.add(NewProductForm(productControllers: initialController));
  }

  void addProduct() {
    setState(() {
      productForms.add(NewProductForm(productControllers: FormProductModel()));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    });
  }

  void removeProduct(element) {
    if (productForms.length > 1) {
      setState(() {
        productForms.remove(element);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LeadingScaffold(
      title: 'New stock entry',
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: productForms.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(children: [
                        NewProductForm(
                          productControllers: initialController,
                        ),
                        PositionedDirectional(
                          top: 0,
                          end: 0,
                          child: IconButton(
                            onPressed: () => removeProduct(productForms[index]),
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            iconSize: 30,
                          ),
                        ),
                      ]),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RawMaterialButton(
                  onPressed: () => addProduct(),
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
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.7, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text('Add to Stock'),
                  onPressed: () {
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a Snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Data is in processing.')));
                    }
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
