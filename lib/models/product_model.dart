// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String id;
  String name;
  String qty;
  String price;
  DateTime dateTimeAdded;
  DateTime dateTimeUpdated;
  Product({
    required this.name,
    required this.qty,
    required this.price,
    required this.dateTimeAdded,
    required this.dateTimeUpdated,
  });

  Product copyWith({
    String? name,
    String? qty,
    String? price,
    DateTime? dateTimeAdded,
    DateTime? dateTimeUpdated,
  }) {
    return Product(
      name: name ?? this.name,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      dateTimeAdded: dateTimeAdded ?? this.dateTimeAdded,
      dateTimeUpdated: dateTimeUpdated ?? this.dateTimeUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'qty': qty,
      'price': price,
      'dateTimeAdded': dateTimeAdded.millisecondsSinceEpoch,
      'dateTimeUpdated': dateTimeUpdated.millisecondsSinceEpoch,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      qty: map['qty'] as String,
      price: map['price'] as String,
      dateTimeAdded:
          DateTime.fromMillisecondsSinceEpoch(map['dateTimeAdded'] as int),
      dateTimeUpdated:
          DateTime.fromMillisecondsSinceEpoch(map['dateTimeUpdated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, qty: $qty, price: $price, dateTimeAdded: $dateTimeAdded, dateTimeUpdated: $dateTimeUpdated)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.qty == qty &&
        other.price == price &&
        other.dateTimeAdded == dateTimeAdded &&
        other.dateTimeUpdated == dateTimeUpdated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        qty.hashCode ^
        price.hashCode ^
        dateTimeAdded.hashCode ^
        dateTimeUpdated.hashCode;
  }

  factory Product.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    Product product = Product(
      name: data['name'] ?? 'nan',
      qty: data['qty'] ?? 'nan',
      price: data["price"] ?? 'nan',
      dateTimeAdded:
          DateTime.fromMillisecondsSinceEpoch(data['dateTimeAdded'] ?? 0),
      dateTimeUpdated:
          DateTime.fromMillisecondsSinceEpoch(data['dateTimeAdded'] ?? 0),
    );

    product.id = document.id;

    return product;
  }
  factory Product.fromSnapshot2(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    Product product = Product(
      name: data['name'] ?? 'nan',
      qty: data['qty'] ?? 'nan',
      price: data["price"] ?? 'nan',
      dateTimeAdded:
          DateTime.fromMillisecondsSinceEpoch(data['dateTimeAdded'] ?? 0),
      dateTimeUpdated:
          DateTime.fromMillisecondsSinceEpoch(data['dateTimeAdded'] ?? 0),
    );

    product.id = document.id;

    return product;
  }
}
