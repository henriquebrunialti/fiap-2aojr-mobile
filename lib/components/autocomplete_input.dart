
import 'package:custo_de_vida/models/category.dart';
import 'package:flutter/material.dart';

class AutocompleteInput extends StatelessWidget {

  late List<Category> options = [];
  final Function onOptionSelected;
  final String labelText;
  String hintText;

  AutocompleteInput({super.key, required this.options, required this.onOptionSelected, required this.labelText, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Autocomplete<Category>(
        optionsBuilder: _buildOptions,
        fieldViewBuilder: _buildField,
        onSelected: (Category value) => onOptionSelected(value.title),
        displayStringForOption: (Category option) => option.title,
      ),
    );
  }

  Iterable<Category> _buildOptions(TextEditingValue textEditingValue) {
    return options.where((Category option) {
      return option.title.toLowerCase().contains(textEditingValue.text.toLowerCase());
    });
  }

  Widget _buildField(
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted) {
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
