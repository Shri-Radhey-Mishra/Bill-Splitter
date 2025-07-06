import 'package:flutter/material.dart';

class IncrementControl extends StatefulWidget {
  final String label;
  final void Function(int) onNext;

  const IncrementControl({
    required this.label,
    required this.onNext,
    super.key,
  });

  @override
  State<IncrementControl> createState() => _IncrementControlState();
}

class _IncrementControlState extends State<IncrementControl> {
  int value = 0;
  final TextEditingController _controller = TextEditingController();

  void _updateValue(String input) {
    final parsed = int.tryParse(input);
    if (parsed != null && parsed >= 0) {
      setState(() {
        value = parsed;
      });
    } else {
      setState(() {
        value = 0;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isValid = value > 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE5D5FF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                color: const Color(0xFF9B5DE5),
                onPressed: value > 0
                    ? () {
                  setState(() {
                    value = value - 1;
                    _controller.text = value.toString();
                  });
                }
                    : null,
              ),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: _updateValue,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: const Color(0xFF9B5DE5),
                onPressed: () {
                  setState(() {
                    value = value + 1;
                    _controller.text = value.toString();
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isValid ? const Color(0xFF9B5DE5) : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: isValid ? () => widget.onNext(value) : null,
          child: const Text('Next'),
        ),
      ],
    );
  }
}