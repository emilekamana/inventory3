// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_management/models/product_model.dart';

class SaleProductForm extends StatelessWidget {
  late SingleValueDropDownController? productContoller =
      SingleValueDropDownController();
  late TextEditingController qtyController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  late Map<String, dynamic> _items;

  static List<SaleProductForm> allForms = [];
  SaleProductForm({
    Key? key,
    required this.snapshot,
  }) : super(key: key) {
    allForms.add(this);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Flexible(flex: 2, child: productTextField()),
      const SizedBox(
        width: 5.0,
      ),
      Flexible(
        child: TextFormField(
          controller: qtyController,
          inputFormatters: [
            FilteringTextInputFormatter.allow((RegExp("[.0-9]")))
          ],
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintStyle: TextStyle(fontSize: 14),
            labelStyle: TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: 'Quantity',
          ),
          validator: (value) {
            if (value is String) {
              double? input = double.tryParse(value);
              if (input == null) {
                return 'Please enter a valid number';
              }
            }
            return null;
          },
        ),
      ),
      const SizedBox(
        width: 5.0,
      ),
      Flexible(
        child: TextFormField(
          controller: priceController,
          inputFormatters: [
            FilteringTextInputFormatter.allow((RegExp("[.0-9]")))
          ],
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintStyle: TextStyle(fontSize: 14),
            labelStyle: TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: 'Price',
          ),
          validator: (value) {
            if (value is String) {
              double? input = double.tryParse(value);
              if (input == null) {
                return 'Please enter a valid number';
              }
            }
            return null;
          },
        ),
      ),
    ]);
  }

  productTextField() {
    if (snapshot.hasData) {
      return DropDownTextField(
        // initialValue: "name4",
        controller: productContoller,
        clearOption: false,
        readOnly: true,
        enableSearch: true,
        // dropdownColor: Colors.green,
        // isEnabled: false,
        textFieldDecoration: const InputDecoration(
            hintStyle: TextStyle(fontSize: 14),
            labelStyle: TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: 'Choose product'),
        searchDecoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: "Search"),
        validator: (value) {
          if (value is String) {
            if (value.isEmpty) {
              return 'Choose product';
            }
          }
          return null;
        },
        dropDownItemCount: snapshot.data!.docs.length,

        dropDownList: List.generate(snapshot.data!.docs.length, (index) {
          Product product = Product.fromSnapshot(snapshot.data!.docs[index]);
          return DropDownValueModel(name: product.name, value: product);
        }).toList(),
        onChanged: (val) {},
      );
    } else {
      return const Text('No products');
    }
  }
}
