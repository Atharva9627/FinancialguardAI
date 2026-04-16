import 'package:flutter/material.dart';
import 'result_screen.dart';

class FinancialWizardScreen extends StatefulWidget {
  const FinancialWizardScreen({super.key});

  @override
  State<FinancialWizardScreen> createState() => _FinancialWizardScreenState();
}

class _FinancialWizardScreenState extends State<FinancialWizardScreen> {

  int step = 0;

  final age = TextEditingController();
  String occupation = "Salaried";
  String marital = "Single";
  final dependents = TextEditingController();

  final salary = TextEditingController();
  final otherIncome = TextEditingController();
  final passiveIncome = TextEditingController();

  final rent = TextEditingController();
  final groceries = TextEditingController();
  final electricity = TextEditingController();
  final transport = TextEditingController();
  final insurance = TextEditingController();
  final entertainment = TextEditingController();
  final subscriptions = TextEditingController();

  final sip = TextEditingController();
  final stocks = TextEditingController();
  final crypto = TextEditingController();
  final mutualFunds = TextEditingController();
  final gold = TextEditingController();

  final homeLoan = TextEditingController();
  final carLoan = TextEditingController();
  final personalLoan = TextEditingController();
  final creditCard = TextEditingController();

  String risk = "Moderate";
  final emergencyFund = TextEditingController();
  final experience = TextEditingController();

  final years = TextEditingController();

  Widget field(String label, TextEditingController c) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),


    child: TextField(
    controller: c,
        keyboardType: TextInputType.number,

        style: const TextStyle(color: Colors.white),

    decoration: InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Colors.white70),

    filled: true,
    fillColor: const Color(0xFF061428),

    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    ),

    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.white24),
    ),

    focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF00B4D8)),
    ),
    ),
    ),
    );


  }

  List<Step> steps() => [


  Step(
  title: const Text("Personal"),
  content: Column(children: [

  field("Age", age),

  DropdownButtonFormField(
  value: occupation,
  dropdownColor: const Color(0xFF0F2540),

  items: ["Salaried","Business","Freelancer","Student"]
      .map((e)=>DropdownMenuItem(value:e,child:Text(e)))
      .toList(),

  onChanged:(v)=>setState(()=>occupation=v!),

  decoration: const InputDecoration(
  labelText: "Occupation",
  ),
  ),

  DropdownButtonFormField(
  value: marital,
  dropdownColor: const Color(0xFF0F2540),

  items: ["Single","Married"]
      .map((e)=>DropdownMenuItem(value:e,child:Text(e)))
      .toList(),

  onChanged:(v)=>setState(()=>marital=v!),

  decoration: const InputDecoration(
  labelText: "Marital Status",
  ),
  ),

  field("Dependents", dependents),

  ]),
  ),

  Step(
  title: const Text("Income"),
  content: Column(children: [

  field("Monthly Salary", salary),
  field("Other Income", otherIncome),
  field("Passive Income", passiveIncome),

  ]),
  ),

  Step(
  title: const Text("Expenses"),
  content: Column(children: [

  field("Rent / EMI", rent),
  field("Groceries", groceries),
  field("Electricity", electricity),
  field("Transport", transport),
  field("Insurance", insurance),
  field("Entertainment", entertainment),
  field("Subscriptions", subscriptions),

  ]),
  ),

  Step(
  title: const Text("Investments"),
  content: Column(children: [

  field("Monthly SIP", sip),
  field("Stocks", stocks),
  field("Crypto", crypto),
  field("Mutual Funds", mutualFunds),
  field("Gold", gold),

  ]),
  ),

  Step(
  title: const Text("Loans"),
  content: Column(children: [

  field("Home Loan", homeLoan),
  field("Car Loan", carLoan),
  field("Personal Loan", personalLoan),
  field("Credit Card Due", creditCard),

  ]),
  ),

  Step(
  title: const Text("Financial Behavior"),
  content: Column(children: [

  DropdownButtonFormField(
  value: risk,
  dropdownColor: const Color(0xFF0F2540),

  items:["Low","Moderate","High"]
      .map((e)=>DropdownMenuItem(value:e,child:Text(e)))
      .toList(),

  onChanged:(v)=>setState(()=>risk=v!),

  decoration: const InputDecoration(
  labelText:"Risk Appetite",
  ),
  ),

  field("Emergency Fund (months)", emergencyFund),
  field("Investment Experience (years)", experience),

  ]),
  ),

  Step(
  title: const Text("Simulation"),
  content: Column(children: [

  field("Result After How Many Years", years),

  ]),
  ),


  ];

  void finish() {


  double income =
  (double.tryParse(salary.text) ?? 0) +
  (double.tryParse(otherIncome.text) ?? 0) +
  (double.tryParse(passiveIncome.text) ?? 0);

  double expenses =
  (double.tryParse(rent.text) ?? 0) +
  (double.tryParse(groceries.text) ?? 0) +
  (double.tryParse(electricity.text) ?? 0) +
  (double.tryParse(transport.text) ?? 0) +
  (double.tryParse(insurance.text) ?? 0) +
  (double.tryParse(entertainment.text) ?? 0) +
  (double.tryParse(subscriptions.text) ?? 0);

  double investments =
  (double.tryParse(sip.text) ?? 0) +
  (double.tryParse(stocks.text) ?? 0) +
  (double.tryParse(crypto.text) ?? 0) +
  (double.tryParse(mutualFunds.text) ?? 0) +
  (double.tryParse(gold.text) ?? 0);

  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (_) => ResultScreen(
  salary: income,
  rent: expenses,
  groceries: investments,
  ),
  ),
  );


  }

  @override
  Widget build(BuildContext context) {


  return Scaffold(
  appBar: AppBar(title: const Text("FinancialGuard Wizard")),

  body: Stepper(
  currentStep: step,
  steps: steps(),

  onStepContinue: () {

  if (step < steps().length - 1) {
  setState(()=>step++);
  } else {
  finish();
  }

  },

  onStepCancel: () {

  if (step > 0) {
  setState(()=>step--);
  }

  },
  ),
  );


  }
}
