import 'package:custo_de_vida/components/hamburger_menu.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HamburgerMenu(),
      appBar: AppBar(
        title: const Text('Cocktail Details'),
      ),
      body: Column(
        children: [
          Center(
            child:
                SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/3,
          child:
          Image.network('https://www.thecocktaildb.com/images/media/drink/u6jrdf1487603173.jpg', fit: BoxFit.fill),
      )
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 0),
                  child:
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Drinking Chocolate', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  )
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    //TODO: Favorite Function
                  },
                ),
              )
            ],
          ),

          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Non Alcoholic', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
              )
          ),

          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child:
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child:
                Row(
                  children: [
                    Text('Type'),
                    Spacer(),
                    Text('Quantity')
                  ],
                ),
              )
            ],
          ),

          Align (
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text('Instructions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      )
              ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding (
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text('Preparing...'),
            )
          )
        ],
      ),
    );
  }
}
