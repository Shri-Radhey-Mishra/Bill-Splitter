import 'package:flutter/material.dart';
import '../app_colors.dart';

class Step3Result extends StatelessWidget {
  final List<(String, String, double)> transactions;
  final VoidCallback onBack;
  final VoidCallback onStartOver;

  const Step3Result({
    super.key,
    required this.transactions,
    required this.onBack,
    required this.onStartOver,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: purple100, width: 2),
        ),
        color: light100,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Settlement Summary',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: purple100,
                ),
              ),
              const SizedBox(height: 20),
              ...transactions.map((t) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Debtor button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: red20,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          t.$1,
                          style: const TextStyle(
                            color: red100,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // ← ₹Amount →
                      Row(
                        children: [
                          const Icon(Icons.arrow_forward, color: purple100),
                          const SizedBox(width: 6),
                          Text(
                            t.$3.toStringAsFixed(2),
                            style: const TextStyle(
                              color: dark100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward, color: purple100),
                        ],
                      ),
                      const SizedBox(width: 12),
                      // Creditor button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: purple20,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          t.$2,
                          style: const TextStyle(
                            color: purple100,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  ElevatedButton(
                    onPressed: onBack,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: light40,
                      foregroundColor: dark100,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Back"),
                  ),
                  // Go to Start button
                  ElevatedButton(
                    onPressed: onStartOver,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red100,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Go to Start"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
