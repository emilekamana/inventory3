import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_management/models/form_product_model.dart';

class NewProductForm extends StatelessWidget {
  final FormProductModel productControllers;

  const NewProductForm({super.key, required this.productControllers});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New product',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          ...formFields(),
        ],
      ),
    );
  }

  formFields() {
    return [TextFormField(
            controller: productControllers.nameController,
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(
              hintStyle: TextStyle(fontSize: 14),
              labelStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
          TextFormField(
            controller: productControllers.qtyController,
            inputFormatters: [
              FilteringTextInputFormatter.allow((RegExp("[.0-9]")))
            ],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintStyle: TextStyle(fontSize: 14),
              labelStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              hintText: 'Item count or in Kgs',
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
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow((RegExp("[.0-9]")))
            ],
            keyboardType: TextInputType.number,
            controller: productControllers.priceController,
            decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 14),
                labelStyle: TextStyle(fontSize: 14),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Price',
                hintText: 'Price in integer format'),
            validator: (value) {
              if (value is String) {
                double? input = double.tryParse(value);
                if (input == null) {
                  return 'Please enter a valid number';
                }
              }
              return null;
            },
          ),];
  }
}
