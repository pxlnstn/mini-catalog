import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // 4. Gün: Veri Yapıları ve Listeleme kapsamında API'den veri çekme [cite: 37, 59]
  Future<List<Product>> fetchProducts() async {
    // Raporun 4. sayfasında önerilen Fake Store API kullanılıyor [cite: 72]
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      
      // JSON mantığı ve model sınıfı eşleştirmesi [cite: 38, 39]
      return data.map((item) => Product(
        id: item['id'],
        name: item['title'], // API'den gelen 'title' alanını 'name'e eşliyoruz
        price: "\$${item['price']}",
        image: item['image'],
        description: item['description'],
      )).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'), // Rapor Sayfa 4 Tasarımı [cite: 75]
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {
              // 5. Gün: Sepet butonu ile geçiş [cite: 48, 64]
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Görseli: Rapor Sayfa 3 ve 4 [cite: 68, 76]
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'https://wantapi.com/assets/banner.png',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Our Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // ListView.builder veya GridView ile dinamik liste [cite: 40, 46, 61]
            FutureBuilder<List<Product>>(
              future: fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error loading products"));
                } else {
                  final products = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Yan yana iki ürün kartı [cite: 46, 105]
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}