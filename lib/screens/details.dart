import 'package:custo_de_vida/API/categories_http_request.dart';
import 'package:custo_de_vida/API/drinks_http_request.dart';
import 'package:custo_de_vida/components/hamburger_menu.dart';
import 'package:custo_de_vida/components/loading.dart';
import 'package:custo_de_vida/constants/text.dart';
import 'package:custo_de_vida/models/drink_card.dart';
import 'package:flutter/material.dart';
import 'package:custo_de_vida/models/drink.dart';

class Details extends StatefulWidget {
  final String drinkId;
  late Drink _drink;
  bool loading = true;

  Details({super.key, required this.drinkId});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    _loadDrink(widget.drinkId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HamburgerMenu(),
      appBar: AppBar(
        title: const Text('Cocktail Details'),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: widget.loading
          ? const Loading()
          : Column(
              children: [
                Center(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.network(widget._drink.thumb, fit: BoxFit.fill),
                )),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(widget._drink.name, style: headingStyle),
                        )),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () {
                          // print(widget._drink);
                          _addToFavorites(widget._drink);
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget._drink.alcoholic,
                            style: subheadingStyle))),
                Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ingredients', style: headingStyle),
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        children: _countIngredients(widget._drink),
                      ),
                    )
                  ],
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: Text('Instructions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(widget._drink.instructions),
                    ))
              ],
            ),
    );
  }

  _loadDrink(String id) async {
    var drinkDetails = await DrinksHttpRequest.getDetails(id);
    setState(() {
      widget._drink = drinkDetails;
      widget.loading = false;
    });
  }

  List<Text> _countIngredients(Drink drink) {
    List<Text> texts = [];

    if (drink.ingredient1 != null) {
      texts.add(Text(drink.ingredient1!));
    }

    if (drink.ingredient2 != null) {
      texts.add(Text(drink.ingredient2!));
    }

    if (drink.ingredient3 != null) {
      texts.add(Text(drink.ingredient3!));
    }

    if (drink.ingredient4 != null) {
      texts.add(Text(drink.ingredient4!));
    }

    if (drink.ingredient5 != null) {
      texts.add(Text(drink.ingredient5!));
    }

    return texts;
  }

  _addToFavorites(Drink drink) {
    print('IMPLEMENTAR ADD TO FAVORITES');
    DrinkCard.fromDrink(drink);
  }
}
