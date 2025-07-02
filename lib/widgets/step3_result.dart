import 'package:flutter/material.dart';
import '../app_colors.dart';

class Step3Result extends StatelessWidget {
  final List<(String, String, double)> transactions;
  final VoidCallback onBack;

  const Step3Result({
    super.key,
    required this.transactions,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: light100, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Settlement Summary', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: purple100)),
            const SizedBox(height: 16),
            ...transactions.map((t) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text('${t.$1} pays ${t.$2}: ₹${t.$3.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
              );
            }),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: onBack, child: const Text('Back')),
          ],
        ),
      ),
    );
  }
}
