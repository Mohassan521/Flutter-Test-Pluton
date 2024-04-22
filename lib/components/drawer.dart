import 'package:flutter/material.dart';
import 'package:fluttertest/screens/favourites.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.favorite_sharp),
            title: const Text(
              'Favourites',
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FavouritesScreen()));
            },
          ),
        ],
      ),
    ));
  }
}
