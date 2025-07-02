import 'package:flutter/material.dart';

class Step2PeopleInput extends StatelessWidget {
  final int numPeople;
  final List<TextEditingController> nameControllers;
  final List<TextEditingController> amountControllers;
  final VoidCallback onSubmit;

  const Step2PeopleInput({
    required this.numPeople,
    required this.nameControllers,
    required this.amountControllers,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Enter name and amount paid by each", style: TextStyle(fontSize: 18)),
        const SizedBox(height: 20),
        ...List.generate(numPeople, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: nameControllers[index],
                    decoration: InputDecoration(labelText: "Name ${index + 1}"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: amountControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Amount"),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: onSubmit, child: const Text("Next")),
      ],
    );
  }
}
