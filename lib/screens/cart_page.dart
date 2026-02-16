import 'package:flutter/material.dart';
import '../models/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Ürünü sepetten silen fonksiyon
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
    
    // Kullanıcıya bilgi ver
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item removed from cart"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        // Geri dönüş butonu AppBar'da otomatik gelir ama isteğe bağlı eklenebilir
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text("Your cart is empty", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // Go Back işlevi 
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text("Go Back", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.network(item.image, width: 50, fit: BoxFit.cover),
                        title: Text(item.name),
                        subtitle: Text(item.price),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => removeItem(index), // Güvenli silme işlemi
                        ),
                      );
                    },
                  ),
                ),
                // Ödeme (Checkout) Butonu - Rapor Sayfa 4 [cite: 97, 98]
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Simülasyon gereği burada işlem biter
                      print("Proceeding to checkout...");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
    );
  }
}