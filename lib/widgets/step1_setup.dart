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
                'Create Group',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: dark100,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Number of People:',
                    style: TextStyle(fontSize: 18, color: dark100),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: numPeople > 2 ? () => onNumPeopleChanged(numPeople - 1) : null,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: purple100,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                        ),
                        child: const Icon(Icons.remove, size: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('$numPeople', style: const TextStyle(fontSize: 18, color: dark100)),
                      ),
                      ElevatedButton(
                        onPressed: () => onNumPeopleChanged(numPeople + 1),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: purple100,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                        ),
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
                  hintStyle: TextStyle(color: dark100.withOpacity(0.5)),
                  fillColor: light100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: purple100, width: 2),
                  ),
                ),
                onChanged: (v) => onTotalAmountChanged(double.tryParse(v) ?? 0),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple100,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
