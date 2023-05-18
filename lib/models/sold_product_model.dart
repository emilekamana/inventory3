import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SoldProductModel {
  String id;
  String name;
  String qty;
  String price;
  SoldProductModel({
    required this.id,
    required this.name,
    required this.qty,
    required this.price,
  });

  SoldProductModel copyWith({
    String? id,
    String? name,
    String? qty,
    String? price,
  }) {
    return SoldProductModel(
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

  factory SoldProductModel.fromMap(Map<String, dynamic> map) {
    return SoldProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      qty: map['qty'] as String,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SoldProductModel.fromJson(String source) => SoldProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '$name, qty: $qty, price: $price';
  }

  @override
  bool operator ==(covariant SoldProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.qty == qty &&
      other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      qty.hashCode ^
      price.hashCode;
  }
}
