import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/controllers/sale_controller.dart';
import 'package:stock_management/models/sale_model.dart';
import 'package:stock_management/widgets/default_scaffold.dart';

SaleController _saleController = SaleController();

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SalesScreenState();
  }
}

class _SalesScreenState extends State<SalesScreen> {
  final CollectionReference<Map<String, dynamic>> _sales =
      _saleController.salesCollection;
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      floatingButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      title: "Sales",
      body: StreamBuilder(
          stream: _sales.snapshots(),
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
                      label: Text('Products'),
                    ),
                    DataColumn(
                      label: Text('Total'),
                    ),
                    DataColumn(
                      label: Text('Date'),
                    ),
                  ],
                  rows: snapshot.data!.docs.map((doc) {
                    Sale sale = Sale.fromSnapshot(doc);
                    return DataRow(cells: <DataCell>[
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Text(
                            sale.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.3,
                          ),
                          child: Text(
                            sale.products.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Text(
                            sale.total,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          sale.dateTimeAdded.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              );
            }
            return const Center(child: Text('Something went wrong!!'));
          }),
    );
  }
}
