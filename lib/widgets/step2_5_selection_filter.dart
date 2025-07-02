import 'package:flutter/material.dart';
import '../app_colors.dart';

class SplitSelectorStep extends StatelessWidget {
  final List<String> names;
  final Set<int> selectedIndices;
  final void Function(int index) onToggle;
  final VoidCallback onContinue;

  const SplitSelectorStep({
    required this.names,
    required this.selectedIndices,
    required this.onToggle,
    required this.onContinue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select people to include in the split", style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(names.length, (index) {
            final isSelected = selectedIndices.contains(index);
            return FilterChip(
              label: Text(names[index]),
              selected: isSelected,
              selectedColor: purple60,
              checkmarkColor: Colors.white,
              onSelected: (_) => onToggle(index),
            );
          }),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: onContinue,
          child: const Text("Calculate"),
        )
      ],
    );
  }
}
