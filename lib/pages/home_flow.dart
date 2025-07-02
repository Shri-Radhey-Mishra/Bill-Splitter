import 'package:flutter/material.dart';
import '../widgets/step1_input_header.dart';
import '../widgets/step2_people_input.dart';
import '../widgets/step2_5_selection_filter.dart';
import '../widgets/step3_result_display.dart';

class HomeFlow extends StatefulWidget {
  const HomeFlow({super.key});

  @override
  State<HomeFlow> createState() => _HomeFlowState();
}

class _HomeFlowState extends State<HomeFlow> {
  int step = 1;
  int numPeople = 1;
  double totalAmount = 0;

  final List<TextEditingController> _nameControllers = [];
  final List<TextEditingController> _amountControllers = [];
  List<String> transactions = [];
  Set<int> selectedSplitIndices = {};

  void goToStep2() {
    _nameControllers.clear();
    _amountControllers.clear();
    for (int i = 0; i < numPeople; i++) {
      _nameControllers.add(TextEditingController());
      _amountControllers.add(TextEditingController());
    }
    setState(() => step = 2);
  }

  void goToStep2_5() {
    selectedSplitIndices = {for (var i = 0; i < numPeople; i++) i}; // All selected
    setState(() => step = 25);
  }

  void calculateAndGoToStep3() {
    final names = _nameControllers.map((c) => c.text).toList();
    final contributions = _amountControllers.map((c) => double.tryParse(c.text) ?? 0.0).toList();

    final includedIndices = selectedSplitIndices.toList();
    final equalShare = totalAmount / includedIndices.length;

    final balances = List.generate(names.length, (i) => 0.0);
    for (int i = 0; i < names.length; i++) {
      balances[i] = contributions[i] - (includedIndices.contains(i) ? equalShare : 0);
    }

    final creditors = <Map<String, dynamic>>[];
    final debtors = <Map<String, dynamic>>[];

    for (int i = 0; i < balances.length; i++) {
      if (balances[i] > 0) {
        creditors.add({'index': i, 'amount': balances[i]});
      } else if (balances[i] < 0) {
        debtors.add({'index': i, 'amount': -balances[i]});
      }
    }

    int i = 0, j = 0;
    final result = <String>[];

    while (i < debtors.length && j < creditors.length) {
      var debtor = debtors[i];
      var creditor = creditors[j];
      double payment = debtor['amount'] < creditor['amount'] ? debtor['amount'] : creditor['amount'];

      result.add("${names[debtor['index']]} pays ${names[creditor['index']]}: ₹${payment.toStringAsFixed(2)}");

      debtor['amount'] -= payment;
      creditor['amount'] -= payment;

      if (debtor['amount'] == 0) i++;
      if (creditor['amount'] == 0) j++;
    }

    setState(() {
      transactions = result;
      step = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Splitter")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: step == 1
            ? Step1InputHeader(
          numPeople: numPeople,
          totalAmount: totalAmount,
          onNumChanged: (val) => setState(() => numPeople = val),
          onAmountChanged: (val) => setState(() => totalAmount = val),
          onNext: goToStep2,
        )
            : step == 2
            ? Step2PeopleInput(
          numPeople: numPeople,
          nameControllers: _nameControllers,
          amountControllers: _amountControllers,
          onSubmit: goToStep2_5,
        )
            : step == 25
            ? SplitSelectorStep(
          names: _nameControllers.map((c) => c.text).toList(),
          selectedIndices: selectedSplitIndices,
          onToggle: (index) {
            setState(() {
              if (selectedSplitIndices.contains(index)) {
                selectedSplitIndices.remove(index);
              } else {
                selectedSplitIndices.add(index);
              }
            });
          },
          onContinue: calculateAndGoToStep3,
        )
            : Step3ResultDisplay(transactions: transactions),
      ),
    );
  }
}
