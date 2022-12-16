import 'package:flutter/material.dart';


class CountryAutocomplete extends StatefulWidget {
  String? autocompleteSelection;
  final Function onCountrySelected;
  late List<String> options;
  CountryAutocomplete({super.key, required this.onCountrySelected, options}){
    if (options != null) {
      this.options = options;
    } else {
      this.options = <String>[];
    }
  }

  @override
  State<CountryAutocomplete> createState() => _CountryAutocompleteState();
}

class _CountryAutocompleteState extends State<CountryAutocomplete> {

  @override
  Widget build(BuildContext context) {
    var autocompleteSelection = widget.autocompleteSelection;
    
    print("auto complete selection on build $autocompleteSelection");
    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return widget.options.where((String option) {
          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        setState(() {
          autocompleteSelection = selection;
          widget.onCountrySelected(autocompleteSelection);
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
            hintText: 'Selecione um país',
          ),
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
          validator: (String? value) {
            if (widget.options.contains(value)) {
              return 'Nada selecionado.';
            }
            return null;
          },
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
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
    );
  }
}
