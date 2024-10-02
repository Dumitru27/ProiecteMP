import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Demo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _sliderValue = 0.0;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();
  double _monthlyPayment = 0.0;

  @override
  void dispose() {
    _amountController.dispose();
    _percentageController.dispose();
    super.dispose();
  }

  void _calculatePayment() {
    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    final double percentage = double.tryParse(_percentageController.text) ?? 0.0;
    final int months = _sliderValue.toInt();

    if (amount > 0 && percentage > 0 && months > 0) {
      // Simple formula for monthly payment calculation
      final monthlyRate = percentage / 100 / 12;
      final monthlyPayment = (amount * monthlyRate) / (1 - pow(1 + monthlyRate, -months).toDouble());
      setState(() {
        _monthlyPayment = monthlyPayment;
      });
    } else {
      setState(() {
        _monthlyPayment = 0.0; // Handle case where input is invalid
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 56,
      ),
      body: SingleChildScrollView(  // Add SingleChildScrollView
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 36),
              const Center(
                child: Text(
                  'Loan Calculator',
                  style: TextStyle(
                    fontFamily: 'CeraPro',
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    height: 21 / 40,
                  ),
                ),
              ),
              const SizedBox(height: 60),

              const Text(
                'Enter amount',
                style: TextStyle(
                  fontFamily: 'CeraPro',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10.5),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  hintText: 'Amount',
                  hintStyle: const TextStyle(
                    fontFamily: 'CeraPro',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
              const SizedBox(height: 36.5),
              const Text(
                'Enter number of months',
                style: TextStyle(
                  fontFamily: 'CeraPro',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32.5),

              Stack(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: const Color(0xFF246AFE),
                      inactiveTrackColor: Colors.blue[100],
                      thumbColor: const Color(0xFF1427C5),
                      overlayColor: Colors.blue.withOpacity(0.2),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 15.0),
                      valueIndicatorColor: Colors.blue,
                      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                      trackHeight: 8.0,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: _sliderValue,
                              min: 0,
                              max: 60,
                              divisions: 60,
                              label: _sliderValue.toStringAsFixed(0),
                              onChanged: (value) {
                                setState(() {
                                  _sliderValue = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFBDBDBD),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(
                      '60 luni',
                      style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFBDBDBD),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Enter % per month',
                style: TextStyle(
                  fontFamily: 'CeraPro',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10.5),
              TextField(
                controller: _percentageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFE1E2E8), width: 1.0),
                  ),
                  hintText: 'Percent',
                  hintStyle: const TextStyle(
                    fontFamily: 'CeraPro',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
              const SizedBox(height: 60),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: const Color(0xFFF1F2F6),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)), // Rounded top corners
                      ),
                      child: const Text(
                        'You will pay the\n'
                            'approximate amount\n'
                            'monthly:',
                        style: TextStyle(
                          fontFamily: 'CeraPro',
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                      ),
                      child: Text(
                        '\$${_monthlyPayment.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontFamily: 'CeraPro',
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1427C5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36.5),
              ElevatedButton(
                onPressed: _calculatePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1427C5),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                    fontFamily: 'CeraPro',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
