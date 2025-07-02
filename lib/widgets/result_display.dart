import 'package:flutter/material.dart';
import '../app_colors.dart';

class ResultDisplay extends StatelessWidget {
  final List<String> transactions;

  const ResultDisplay({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: purple20,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: transactions
            .map((t) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(t, style: TextStyle(color: dark100, fontSize: 16)),
        ))
            .toList(),
      ),
    );
  }
}
