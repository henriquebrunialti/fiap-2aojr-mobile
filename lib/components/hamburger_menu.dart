import 'package:custo_de_vida/screens/favorite.dart';
import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  HamburgerMenu({
    Key? key,
  }) : super(key: key);

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
            child: ListTile(
              title: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {
                Navigator.pushNamed(context, "/favorites");
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Buscar'),
            onTap: () {
              Navigator.pushNamed(context, "/search");
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
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
