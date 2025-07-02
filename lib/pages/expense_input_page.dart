import 'package:flutter/material.dart';
import '../widgets/num_input.dart';
import '../widgets/people_input_form.dart';
import '../widgets/result_display.dart';
import '../widgets/primary_button.dart';

class ExpenseInputPage extends StatefulWidget {
  @override
  _ExpenseInputPageState createState() => _ExpenseInputPageState();
}

class _ExpenseInputPageState extends State<ExpenseInputPage> {
  final _formKey = GlobalKey<FormState>();
  int numPeople = 0;
  final _numController = TextEditingController();
  List<TextEditingController> _peopleControllers = [];
  List<TextEditingController> _amountControllers = [];
  List<String> transactions = [];

  void generateFields() {
    _peopleControllers = List.generate(numPeople, (_) => TextEditingController());
    _amountControllers = List.generate(numPeople, (_) => TextEditingController());
  }

  void calculateTransactions() {
    final names = _peopleControllers.map((c) => c.text).toList();
    final contributions = _amountControllers.map((c) => double.tryParse(c.text) ?? 0.0).toList();

    final totalAmount = contributions.reduce((a, b) => a + b);
    final equalShare = totalAmount / names.length;
    final balances = contributions.map((amt) => amt - equalShare).toList();

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
    });
  }

  @override
  void dispose() {
    _numController.dispose();
    _peopleControllers.forEach((c) => c.dispose());
    _amountControllers.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Splitter')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            NumInput(
              controller: _numController,
              onSubmitted: (value) {
                setState(() {
                  numPeople = int.tryParse(value) ?? 0;
                  generateFields();
                });
              },
            ),
            SizedBox(height: 20),
            if (numPeople > 0)
              PeopleInputForm(
                formKey: _formKey,
                peopleControllers: _peopleControllers,
                amountControllers: _amountControllers,
              ),
            SizedBox(height: 20),
            if (numPeople > 0)
              PrimaryButton(
                label: 'Calculate',
                onPressed: calculateTransactions,
              ),
            SizedBox(height: 30),
            if (transactions.isNotEmpty)
              ResultDisplay(transactions: transactions),
          ],
        ),
      ),
    );
  }
}
