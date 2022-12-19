import 'package:custo_de_vida/API/CategoriesHttpRequest.dart';
import 'package:custo_de_vida/components/hamburger_menu.dart';
import 'package:custo_de_vida/models/drink_card.dart';
import 'package:flutter/material.dart';
import 'package:custo_de_vida/models/drink.dart';

class Details extends StatefulWidget {
  final String drinkID;
  late Drink _drink;

  Details({super.key, required this.drinkID});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    _loadDrink();
    return Scaffold(
      drawer: const HamburgerMenu(),
      appBar: AppBar(
        title: const Text('Cocktail Details'),
      ),
      body: Column(
        children: [
          Center(
              child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: Image.network(
                widget._drink.thumb,
                fit: BoxFit.fill),
          )),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._drink.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  )),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    _addToFavorites(widget._drink);
                  },
                ),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget._drink.alcoholic,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)))),
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Ingredients',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  )),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children:
                    _countIngredients(widget._drink)
                  ,
                ),
              )
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 20),
                child: Text('Instructions',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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

  _loadDrink() async {
    var drinkDetails = await CategoriesHttpRequest.getDetails(widget.drinkID);
    setState(() {
      widget._drink = drinkDetails;
    });
  }

  List<Text> _countIngredients(Drink drink) {
    List<String> ings = [];
    if (drink.strIngredient1.isNotEmpty || drink.strIngredient1 != null) {
      ings.add(drink.strIngredient1);
    }
    if (drink.strIngredient2.isNotEmpty || drink.strIngredient2 != null) {
      ings.add(drink.strIngredient2);
    }
    if (drink.strIngredient3.isNotEmpty || drink.strIngredient3 != null) {
      ings.add(drink.strIngredient3);
    }
    if (drink.strIngredient4.isNotEmpty || drink.strIngredient4 != null) {
      ings.add(drink.strIngredient4);
    }
    if (drink.strIngredient5.isNotEmpty || drink.strIngredient5 != null) {
      ings.add(drink.strIngredient5);
    }

    List<Text> texts = [];
    ings.forEach((element) {
      texts.add(Text(element));
    });

    return texts;
  }

  _addToFavorites(Drink drink) {
    DrinkCard.fromDrink(drink);
  }

}
