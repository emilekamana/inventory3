import 'package:flutter/material.dart';
import 'package:stock_management/widgets/default_scaffold.dart';

class SalesForm extends StatefulWidget {
  const SalesForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SalesFormState();
  }
}

class _SalesFormState extends State<SalesForm> {
  final _formKey = GlobalKey<FormState>();

// List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'Add Sold Item',
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            DropdownButtonFormField(
                hint: const Text('Choose item item'),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? value){}),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     hintText: 'Enter the product name',
            //     labelText: 'Name',
            //   ),
            //   validator: (value) {
            //     if (value is String) {
            //       if (value.isEmpty) {
            //         return 'Please enter some text';
            //       }
            //     }
            //     return null;
            //   },
            // ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Number of items or qunatity',
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
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the price',
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
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: const Text('Add to inventory'),
                  onPressed: () {
                    // It returns true if the form is valid, otherwise returns false
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a Snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data is in processing.')));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
