import 'package:flutter/material.dart';
import 'increment_control.dart';

class Step1InputHeader extends StatelessWidget {
  final int numPeople;
  final double totalAmount;
  final void Function(int) onNumChanged;
  final void Function(double) onAmountChanged;
  final VoidCallback onNext;

  const Step1InputHeader({
    required this.numPeople,
    required this.totalAmount,
    required this.onNumChanged,
    required this.onAmountChanged,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Enter total amount and number of people", style: TextStyle(fontSize: 18)),
        const SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Total Amount'),
          onChanged: (val) => onAmountChanged(double.tryParse(val) ?? 0),
        ),
        const SizedBox(height: 20),
        IncrementControl(
          label: "Number of People",
          value: numPeople,
          onChanged: onNumChanged,
        ),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: onNext, child: const Text("Next")),
      ],
    );
  }
}
