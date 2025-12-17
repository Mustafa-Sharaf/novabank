import 'package:flutter/material.dart';
import 'package:novabank/App_theme/AppColors.dart';

class ProfitScreen extends StatefulWidget {
  const ProfitScreen({super.key});

  @override
  State<ProfitScreen> createState() => _ProfitScreenState();
}

class _ProfitScreenState extends State<ProfitScreen> {
  final TextEditingController amountController = TextEditingController();
  String selectedCurrency = 'EUR';
  String selectedDuration = '6 months';
  String result = '';

  final Map<String, double> profitRates = {
    'EUR': 0.01,
    'USD': 0.012,
    'TRY': 0.015,
    'SYR': 0.05,
  };

  final List<String> durations = ['1 month', '3 months', '6 months', '12 months'];

  void calculateProfit() {
    double amount = double.tryParse(amountController.text.replaceAll(',', '')) ?? 0;
    double rate = profitRates[selectedCurrency] ?? 0.01;

    int months = int.parse(selectedDuration.split(' ')[0]);
    double profit = amount * rate * months;

    setState(() {
      result = 'Expected profit: ${profit.toStringAsFixed(2)} $selectedCurrency';
    });
  }

  Widget buildDropdownCard({required String title, required Widget child}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit Screen'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            buildDropdownCard(
              title: 'Duration in months',
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedDuration,
                items: durations.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedDuration = val!;
                  });
                },
              ),
            ),

            buildDropdownCard(
              title: 'Currency',
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedCurrency,
                items: profitRates.keys.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCurrency = val!;
                  });
                },
              ),
            ),
            buildDropdownCard(
              title: 'The amount',
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter the amount',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateProfit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Calculate now', style: TextStyle(fontSize: 16,color: AppColors.white)),
            ),

            const SizedBox(height: 24),
            if (result.isNotEmpty) ...[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      /*const Text(
                        'تم احتساب الربح المتوقع بناءً على متوسط نسبة الربح الموزعة عن آخر ربع',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),*/
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
