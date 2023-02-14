import 'package:flutter/material.dart';
import 'package:stock_management/main.dart';
import 'package:stock_management/screens/add_inventory_form.dart';
import 'package:stock_management/screens/sales_form.dart';
import 'package:stock_management/screens/splash.dart';
import 'package:stock_management/screens/view_stock.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case '/splash':
        return MaterialPageRoute(builder: (_) => const Splash());
      case '/add_inventory':
        return MaterialPageRoute(builder: (_) => const AddInventoryForm());
      case '/sales_form':
        return MaterialPageRoute(builder: (_) => const SalesForm());
      case '/view_stock':
        return MaterialPageRoute(builder: (_) => const ViewStock());
      default:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
    }
  }
}
