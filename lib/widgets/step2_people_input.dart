import 'package:flutter/material.dart';
import '../app_colors.dart';

class Step2PeopleInput extends StatelessWidget {
  final int numPeople;
  final List<TextEditingController> nameControllers;
  final List<TextEditingController> amountControllers;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const Step2PeopleInput({
    super.key,
    required this.numPeople,
    required this.nameControllers,
    required this.amountControllers,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: Card(
        elevation: 8,
        color: light100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: purple100, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter Contributions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: purple100)),
              const SizedBox(height: 16),
              ...List.generate(numPeople, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: nameControllers[i],
                          decoration: InputDecoration(
                            hintText: 'Name ${i + 1}',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: purple100, width: 2), borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: amountControllers[i],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: purple100, width: 2), borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: onBack, child: const Text('Back')),
                  ElevatedButton(onPressed: onSubmit, child: const Text('Next')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
