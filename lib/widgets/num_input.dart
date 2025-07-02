import 'package:flutter/material.dart';

class NumInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const NumInput({required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Enter number of people'),
      onSubmitted: onSubmitted,
    );
  }
}
