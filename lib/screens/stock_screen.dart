import 'package:flutter/material.dart';
import 'package:stock_management/models/product_model.dart';
import 'package:stock_management/widgets/default_scaffold.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StockScreenState();
  }
}

class _StockScreenState extends State<StockScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      floatingButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      title: "View Stock",
      body: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
          rows: List<DataRow>.generate(
            Product.staticProducts.length,
            (int index) => DataRow(
              cells: <DataCell>[
                DataCell(
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.25,
                    ),
                    child: Text(
                      Product.staticProducts[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ),
                DataCell(Text(Product.staticProducts[index].qty)),
                DataCell(Text(Product.staticProducts[index].price)),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xFF4796BD),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
