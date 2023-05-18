import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_management/models/sale_model.dart';

class SalesTable extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> sales;
  const SalesTable({super.key, required this.sales});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: sales,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasData == false) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
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
              children: const <Widget>[Center(child: Text("No sale records"))],
            );
          }

          if (snapshot.hasData) {
            return Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2)
                },
                children: [
                  const TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Name',
                          style: TextStyle(
                            color: Color.fromARGB(255, 137, 137, 137),
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          'Products',
                          style: TextStyle(
                            color: Color.fromARGB(255, 137, 137, 137),
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          'Total',
                          style: TextStyle(
                            color: Color.fromARGB(255, 137, 137, 137),
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          'Date',
                          style: TextStyle(
                            color: Color.fromARGB(255, 137, 137, 137),
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(snapshot.data!.docs.length, (index) {
                    Sale sale = Sale.fromSnapshot(snapshot.data!.docs[index]);
                    return TableRow(children: [
                      TableCell(
                        child: Text(
                          sale.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      TableCell(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: sale.products
                            .map(
                              (prod) => Text(
                                prod.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            )
                            .toList(),
                      )),
                      TableCell(
                        child: Text(
                          sale.total,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          sale.dateTimeAdded.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ]);
                  })
                ]);
          }
          return const Center(child: Text('Something went wrong!!'));
        });
  }
}
