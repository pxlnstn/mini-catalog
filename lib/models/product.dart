class Product {
  final int id;
  final String name;
  final String price;
  final String image;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  // JSON verisini Product nesnesine dönüştüren fabrika metodu [cite: 39]
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      description: json['description'],
    );
  }
}

// Global cart list 
List<Product> cartItems = [];