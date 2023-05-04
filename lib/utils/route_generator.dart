import 'package:flutter/material.dart';
import 'package:stock_management/screens/add_stock_screen.dart';
import 'package:stock_management/screens/history_screen.dart';
import 'package:stock_management/screens/home_screen.dart';
import 'package:stock_management/screens/notes_screen.dart';
import 'package:stock_management/screens/add_sales_screen.dart';
import 'package:stock_management/screens/sales_screen.dart';
import 'package:stock_management/screens/signup_screen.dart';
import 'package:stock_management/screens/splash_screen.dart';
import 'package:stock_management/screens/login_screen.dart';
import 'package:stock_management/screens/stock_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/splash':
        return MaterialPageRoute(builder: (_) => const Splash());
      case '/add_Stock':
        return MaterialPageRoute(builder: (_) => const AddStockScreen());
      case '/add_sale':
        return MaterialPageRoute(builder: (_) => AddSaleScreen());
      case '/stock':
        return MaterialPageRoute(builder: (_) => const StockScreen());
      case '/sales':
        return MaterialPageRoute(builder: (_) => const SalesScreen());
      case '/notes':
        return MaterialPageRoute(builder: (_) => const NotesScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LogInScreen());
      case '/history':
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
