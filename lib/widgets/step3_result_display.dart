import 'package:flutter/material.dart';
import '../app_colors.dart';

class Step3ResultDisplay extends StatelessWidget {
  final List<String> transactions;

  const Step3ResultDisplay({required this.transactions, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Settlement Summary", style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: purple20,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: transactions
                .map((t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(t, style: const TextStyle(fontSize: 16)),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
