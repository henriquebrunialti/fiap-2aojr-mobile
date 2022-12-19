import 'package:custo_de_vida/components/FavoriteMenuItem.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final title = const Text("Favoritos");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: title),
        body: Padding(
          padding: EdgeInsets.zero,
          child: ListTile(
            leading: const Icon(Icons.remove_red_eye_outlined),
            title: Text("title"),
            subtitle: Text("subtitle"),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.pushNamed(context, "route");
            },
          ),
        ));
  }
}
