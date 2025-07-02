import 'package:flutter/material.dart';
import '../app_colors.dart';

class Step1Setup extends StatelessWidget {
  final int numPeople;
  final double totalAmount;
  final ValueChanged<int> onNumPeopleChanged;
  final ValueChanged<double> onTotalAmountChanged;
  final VoidCallback onNext;

  const Step1Setup({
    super.key,
    required this.numPeople,
    required this.totalAmount,
    required this.onNumPeopleChanged,
    required this.onTotalAmountChanged,
    required this.onNext,
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
              Text(
                'Create Group',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: purple100),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Number of People:', style: TextStyle(fontSize: 18)),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: numPeople > 1 ? () => onNumPeopleChanged(numPeople - 1) : null,
                        style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(8)),
                        child: const Icon(Icons.remove, size: 20),
                      ),
                      Text('$numPeople', style: const TextStyle(fontSize: 18)),
                      ElevatedButton(
                        onPressed: () => onNumPeopleChanged(numPeople + 1),
                        style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(8)),
                        child: const Icon(Icons.add, size: 20),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Total Amount',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: purple100, width: 2), borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (v) => onTotalAmountChanged(double.tryParse(v) ?? 0),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: onNext, child: const Text('Next')),
            ],
          ),
        ),
      ),
    );
  }
}
