import 'package:flutter/material.dart';
import '../app_colors.dart';

class Step2_5SelectPeople extends StatelessWidget {
  final List<String> names;
  final Set<int> selectedIndices;
  final void Function(int index) onToggle;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const Step2_5SelectPeople({
    super.key,
    required this.names,
    required this.selectedIndices,
    required this.onToggle,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: Container(
        width: 360,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: light100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: purple100, width: 2), // Added visible border
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Whom to Split With',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: purple100,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: List.generate(names.length, (index) {
                final isSelected = selectedIndices.contains(index);
                return RawChip(
                  label: Text(
                    names[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : dark100,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: purple100,
                  backgroundColor: light40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: isSelected ? purple100 : light40,
                      width: 1.5,
                    ),
                  ),
                  checkmarkColor: Colors.transparent, // Hides tick mark
                  onSelected: (_) => onToggle(index),
                );
              }),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple100,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
