import 'package:flower_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/colors.dart';
import '../widgets/custom_action_appbar.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text('Check Out'),
        actions: const [CustomActionBar()],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.countProducts,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage(cart.getImage(index)),
                  ),
                  title: Text(cart.getnameOFProduct(index)),
                  subtitle: Text(
                      '${cart.currentPrice(index)} - ${cart.getnameOFShop(index)}'),
                  trailing: IconButton(
                    onPressed: () {
                      cart.removeProduct(cart.getItem(index));
                    },
                    iconSize: 32,
                    icon: const Icon(Icons.remove),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(btnPink),
              padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
            child: Text(
              'Pay \$${cart.totalPrice}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
