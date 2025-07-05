import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/step1_setup.dart';
import '../widgets/step2_people_input.dart';
import '../widgets/step2_5_select_people.dart';
import '../widgets/step3_result.dart';
import '../app_colors.dart'; // Make sure you import this for purple100

class HomeFlow extends StatefulWidget {
  const HomeFlow({super.key});

  @override
  State<HomeFlow> createState() => _HomeFlowState();
}

class _HomeFlowState extends State<HomeFlow> {
  int currentStep = 0;
  int numPeople = 1;
  double totalAmount = 0.0;

  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> amountControllers = [];

  List<String> get names => nameControllers.map((c) => c.text.trim()).toList();
  List<double> get amounts => amountControllers.map((c) => double.tryParse(c.text.trim()) ?? 0).toList();

  Set<int> selectedPeople = {};
  List<(String, String, double)> results = [];

  void calculateResult() {
    final selectedNames = selectedPeople.map((i) => names[i]).toList();
    final selectedAmounts = selectedPeople.map((i) => amounts[i]).toList();

    final equalShare = selectedAmounts.reduce((a, b) => a + b) / selectedNames.length;
    final balances = selectedAmounts.map((amt) => amt - equalShare).toList();

    final creditors = <(int, double)>[];
    final debtors = <(int, double)>[];

    for (var i = 0; i < balances.length; i++) {
      if (balances[i] > 0) creditors.add((i, balances[i]));
      if (balances[i] < 0) debtors.add((i, -balances[i]));
    }

    final transactions = <(String, String, double)>[];
    int di = 0, ci = 0;
    while (di < debtors.length && ci < creditors.length) {
      final (dIdx, debtAmt) = debtors[di];
      final (cIdx, credAmt) = creditors[ci];
      final payment = debtAmt < credAmt ? debtAmt : credAmt;

      transactions.add((selectedNames[dIdx], selectedNames[cIdx], double.parse(payment.toStringAsFixed(2))));

      debtors[di] = (dIdx, debtAmt - payment);
      creditors[ci] = (cIdx, credAmt - payment);

      if (debtors[di].$2 == 0) di++;
      if (creditors[ci].$2 == 0) ci++;
    }

    results = transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Bill Splitter',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: purple100,
          ),
        ),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: switch (currentStep) {
            0 => Step1Setup(
              key: const ValueKey(0),
              numPeople: numPeople,
              totalAmount: totalAmount,
              onNumPeopleChanged: (val) => setState(() => numPeople = val),
              onTotalAmountChanged: (val) => setState(() => totalAmount = val),
              onNext: () {
                nameControllers.clear();
                amountControllers.clear();
                for (var i = 0; i < numPeople; i++) {
                  nameControllers.add(TextEditingController());
                  amountControllers.add(TextEditingController());
                }
                setState(() => currentStep = 1);
              },
            ),
            1 => Step2PeopleInput(
              key: const ValueKey(1),
              numPeople: numPeople,
              nameControllers: nameControllers,
              amountControllers: amountControllers,
              onBack: () => setState(() => currentStep = 0),
              onSubmit: () {
                selectedPeople = {for (var i = 0; i < numPeople; i++) i};
                setState(() => currentStep = 2);
              },
            ),
            2 => Step2_5SelectPeople(
              key: const ValueKey(2),
              names: names,
              selectedIndices: selectedPeople,
              onToggle: (i) {
                setState(() {
                  if (selectedPeople.contains(i)) {
                    selectedPeople.remove(i);
                  } else {
                    selectedPeople.add(i);
                  }
                });
              },
              onBack: () => setState(() => currentStep = 1),
              onNext: () async {
                calculateResult();
                await ApiService.saveSplit({
                  'people': names,
                  'amounts': amounts,
                  'selectedIndices': selectedPeople.toList(),
                  'transactions': results.map((t) => {
                    'from': t.$1,
                    'to': t.$2,
                    'amount': t.$3,
                  }).toList(),
                });
                setState(() => currentStep = 3);
              },
            ),
            3 => Step3Result(
              key: const ValueKey(3),
              transactions: results,
              onBack: () => setState(() => currentStep = 2),
              onStartOver: () => setState(() => currentStep = 0),
            ),
            _ => const SizedBox(),
          },
        ),
      ),
    );
  }
}
