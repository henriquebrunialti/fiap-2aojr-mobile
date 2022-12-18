import 'package:flutter/material.dart';

class CitiesAutocomplete extends StatefulWidget {
  CitiesAutocomplete({super.key, cities}) {
    if (cities != null) {
      this.cities = cities;
    }
  }

  List<String> cities = <String>[];

  void setCities(List<String> c) {
    cities = c;
  }

  @override
  State<CitiesAutocomplete> createState() => _CitiesAutocompleteState();
}

class _CitiesAutocompleteState extends State<CitiesAutocomplete> {
  String? _autocompleteSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: RawAutocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return widget.cities.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          setState(() {
            _autocompleteSelection = selection;
          });
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Drinks',
              hintText: 'Selecione um drink',
            ),
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
            validator: (String? value) {
              if (!widget.cities.contains(value)) {
                return 'Nothing selected.';
              }
              return null;
            },
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
