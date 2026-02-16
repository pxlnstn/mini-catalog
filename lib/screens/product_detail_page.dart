import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  
  // Navigator ile veri taşıma (Route Arguments mantığı)
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ürün Görseli
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ürün Adı ve Fiyatı
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        product.price,
                        style: const TextStyle(fontSize: 22, color: Colors.blueAccent, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Ürün Açıklaması
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Alt Kısımda Sabit Buton (Rapor Sayfa 4)
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: // product_detail_page.dart içindeki buton kısmı
ElevatedButton(
  onPressed: () {
  cartItems.add(product); // Ürünü listeye ekler [cite: 64]
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${product.name} added to cart!'),
      backgroundColor: Colors.green,
    ),
  );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    minimumSize: const Size(double.infinity, 55),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  ),
  child: const Text(
    "Add to Cart",
    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
  ),
),
      ),
    );
  }
}