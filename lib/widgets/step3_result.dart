import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../services/pdf_service.dart';

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
        elevation: 6,
        color: purple20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
                  color: dark100,
                ),
              ),
              const SizedBox(height: 20),

              // Transaction list
              ...transactions.map((t) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16),
                      children: [
                        TextSpan(
                          text: t.$1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: red100,
                          ),
                        ),
                        const TextSpan(
                          text: ' owes ',
                          style: TextStyle(color: Colors.black87),
                        ),
                        TextSpan(
                          text: t.$2,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: purple100,
                          ),
                        ),
                        TextSpan(
                          text: ' ₹${t.$3.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: onBack,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: light40,
                      foregroundColor: dark100,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Back"),
                  ),

                  ElevatedButton(
                    onPressed: () => PdfService.generateAndOpenPdf(transactions),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purple100,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("View PDF"),
                  ),

                  ElevatedButton(
                    onPressed: onStartOver,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red100,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
