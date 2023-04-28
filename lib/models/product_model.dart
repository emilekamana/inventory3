// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  String id;
  String name;
  String qty;
  String price;
  Product({
    required this.id,
    required this.name,
    required this.qty,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? name,
    String? qty,
    String? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      qty: qty ?? this.qty,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'qty': qty,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      qty: map['qty'] as String,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, qty: $qty, price: $price)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.qty == qty &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ qty.hashCode ^ price.hashCode;
  }

  static final List<Product> staticProducts = [
    Product(id: "1", name: "coco", qty: "100", price: "2000"),
    Product(
        id: "1",
        name: "bananabananabananabananabananabananabananabanana",
        qty: "30",
        price: "400"),
    Product(id: "1", name: "onion", qty: "70", price: "700"),
    Product(id: "1", name: "Rice", qty: "20", price: "1000"),
    Product(id: "1", name: "beans", qty: "30", price: "100"),
    Product(id: "1", name: "potato", qty: "50", price: "500"),
    Product(id: "1", name: "coco", qty: "100", price: "2000"),
    Product(id: "1", name: "banana", qty: "30", price: "400"),
    Product(id: "1", name: "onion", qty: "70", price: "700"),
    Product(id: "1", name: "Rice", qty: "20", price: "1000"),
    Product(id: "1", name: "beans", qty: "30", price: "100"),
    Product(id: "1", name: "potato", qty: "50", price: "500"),
  ];
}
