import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../App_theme/AppColors.dart';
import '../Controller/ExchangeRate_Controller.dart';


class ExchangeRateScreen extends StatelessWidget {
  const ExchangeRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeRateController controller = Get.put(ExchangeRateController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exchange Rate (SYP)"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Last Update: ${controller.lastUpdate.value}",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(flex: 3, child: Text("Currency", style: _headerStyle)),
                  Expanded(flex: 2, child: Text("Buy", style: _headerStyle)),
                  Expanded(flex: 2, child: Text("Sell", style: _headerStyle)),
                ],
              ),
              const Divider(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.rates.length,
                  itemBuilder: (context, index) {
                    final rate = controller.rates[index];
                    return _rateItem(
                      flag: rate["flag"]!,
                      name: rate["name"]!,
                      buy: rate["buy"]!,
                      sell: rate["sell"]!,
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _rateItem({
    required String flag,
    required String name,
    required String buy,
    required String sell,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(flag, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 8),
                Text(name, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(buy, style: const TextStyle(fontSize: 15)),
          ),
          Expanded(
            flex: 2,
            child: Text(sell, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

const _headerStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);
