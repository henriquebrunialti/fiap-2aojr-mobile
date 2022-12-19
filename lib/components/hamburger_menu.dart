import 'package:custo_de_vida/screens/favorite.dart';
import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  HamburgerMenu({
    Key? key,
  }) : super(key: key);

  final addRoute = Favorite();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            title: Text('Favoritos'),
            onTap: () {
              Navigator.pushNamed(context, "/favorites");
            },
          ),
        ],
      ),
    );
  }
}
