
import 'package:flutter/material.dart';

class AutocompleteInput extends StatelessWidget {

  late List<String> options = ['Chocolate'];
  final Function onOptionSelected;
  final String labelText;
  String hintText;

  AutocompleteInput({super.key, required this.options, required this.onOptionSelected, required this.labelText, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Autocomplete<String>(
        optionsBuilder: _buildOptions,
        fieldViewBuilder: _buildField,
        onSelected: (String value) => onOptionSelected(value),
        displayStringForOption: (String option) => option,
      ),
    );
  }

  Iterable<String> _buildOptions(TextEditingValue textEditingValue) {
    return options.where((String option) {
      return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
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
