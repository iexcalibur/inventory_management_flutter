class Product {
  final String id;
  final String name;
  final String sku;
  final double price;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.quantity,
  });

  Product copyWith({
    String? id,
    String? name,
    String? sku,
    double? price,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      sku: map['sku'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
} 