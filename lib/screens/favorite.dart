import 'package:custo_de_vida/components/FavoriteMenuItem.dart';
import 'package:flutter/material.dart';
import '../components/hamburger_menu.dart';
import '../database/database.dart';
import '../models/drink_card.dart';

class Favorite extends StatefulWidget {
  @override
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<DrinkCard> drinks = [];

  @override
  initState() {
    super.initState();
    getFavorites();
  }

  getFavorites() async {
    var db = await _getDatabaseInstance('drinks.db');
    var retorno = await db.drinkDao.findFavorites();

    setState(() {
      drinks = retorno;
    });
  }

  Future<AppDatabase> _getDatabaseInstance(String dbName) async =>
      await $FloorAppDatabase.databaseBuilder(dbName).build();

  final title = const Text("Favoritos");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: HamburgerMenu(),
        appBar: AppBar(title: title),
        body: ListView.separated(
            itemBuilder: (((context, index) => _buildItem(index))),
            separatorBuilder: ((context, index) => divisorList()),
            itemCount: drinks.length));
  }

  Widget _buildItem(int index) {
    DrinkCard favoriteDrink = drinks[index];
    return Padding(
        padding: EdgeInsets.zero,
        child: FavoriteMenuItem(
            title: favoriteDrink.name,
            subtitle: favoriteDrink.category,
            route: "route"));
  }

  Widget divisorList() => const Divider(
        height: 2,
        color: Colors.black12,
      );
}
