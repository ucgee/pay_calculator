import 'package:flutter/material.dart';

void main() {
  runApp(PayCalculatorApp());
}

class PayCalculatorApp extends StatelessWidget {
  const PayCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PayCalculatorScreen(),
    );
  }
}

class PayCalculatorScreen extends StatefulWidget {
  const PayCalculatorScreen({super.key});

  @override
  _PayCalculatorScreenState createState() => _PayCalculatorScreenState();
}

class _PayCalculatorScreenState extends State<PayCalculatorScreen> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;

  void calculatePay() {
    final double hoursWorked = double.tryParse(_hoursController.text) ?? 0.0;
    final double hourlyRate = double.tryParse(_rateController.text) ?? 0.0;

    if (hoursWorked <= 40) {
      regularPay = hoursWorked * hourlyRate;
      overtimePay = 0.0;
    } else {
      regularPay = 40 * hourlyRate;
      overtimePay = (hoursWorked - 40) * hourlyRate * 1.5;
    }

    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pay Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Fields
            TextField(
              controller: _hoursController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number of Hours Worked'),
            ),
            TextField(
              controller: _rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Hourly Rate'),
            ),
            SizedBox(height: 16),

            // Calculate Button
            ElevatedButton(
              onPressed: calculatePay,
              child: Text('Calculate'),
            ),

            SizedBox(height: 16),

            // Output Data
            Text('Regular Pay: \$${regularPay.toStringAsFixed(2)}'),
            Text('Overtime Pay: \$${overtimePay.toStringAsFixed(2)}'),
            Text('Total Pay (before tax): \$${totalPay.toStringAsFixed(2)}'),
            Text('Tax: \$${tax.toStringAsFixed(2)}'),

            Spacer(),

            // About Me Section
            Center(
              child: Text(
                'Name: Uchenna Enyita\nStudent ID: 301258888,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
