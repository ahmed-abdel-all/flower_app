import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/model/item.dart';
import 'package:flower_app/pages/details_screen.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flower_app/widgets/custom_action_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/test.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              accountName: Text(user.displayName!),
              accountEmail: Text(user.email!),
            ),
            Column(
              children: [
                ListTile(
                  title: const Text("Home"),
                  leading: const Icon(Icons.home),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("My products"),
                  leading: const Icon(Icons.add_shopping_cart),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("About"),
                  leading: const Icon(Icons.help_center),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Logout"),
                  leading: const Icon(Icons.exit_to_app),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            const Text('Developed by Ahmed Abdel All © 2023'),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text('Home'),
        actions: const [CustomActionBar()],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(item: items[index]),
                    ));
              },
              child: GridTile(
                footer: GridTileBar(
                  leading: Text('\$${items[index].price}'),
                  title: const Text(''),
                  trailing: Consumer<CartProvider>(
                    builder: (context, obj, child) => IconButton(
                      onPressed: () {
                        obj.addProduct(items[index]);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -3,
                      bottom: -9,
                      right: 0,
                      left: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(55.0),
                        child: Image.asset(
                          items[index].imagePath,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
