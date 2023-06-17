import 'package:flower_app/pages/checkout_screen.dart';
import 'package:flower_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomActionBar extends StatelessWidget {
  const CustomActionBar({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Positioned(
              // right: 10,
              left: 0,
              right: 30,
              bottom: 27,
              top: -1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  shape: BoxShape.circle,
                ),
                child: Consumer<CartProvider>(
                  builder: (context, value, child) => Text(
                    '${value.countProducts}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckOutScreen()),
                );
              },
              iconSize: 23,
              icon: const Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
        Consumer<CartProvider>(
          builder: (context, value, child) => Text(
            '\$${value.totalPrice}',
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
