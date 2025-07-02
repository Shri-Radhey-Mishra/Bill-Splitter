import 'package:flutter/material.dart';

class PeopleInputForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> peopleControllers;
  final List<TextEditingController> amountControllers;

  const PeopleInputForm({
    required this.formKey,
    required this.peopleControllers,
    required this.amountControllers,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: List.generate(peopleControllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: peopleControllers[index],
                    decoration: InputDecoration(labelText: 'Name ${index + 1}'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: amountControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
