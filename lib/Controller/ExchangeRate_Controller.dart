import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExchangeRateController extends GetxController {
  var rates = <Map<String, String>>[].obs;
  var loading = true.obs;
  var lastUpdate = "".obs;

  final double usdToSyp = 11765;

  @override
  void onInit() {
    super.onInit();
    fetchRates();
  }

  Future<void> fetchRates() async {
    try {
      final response = await http.get(Uri.parse('https://api.frankfurter.app/latest?from=USD')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['rates'] != null) {
          final Map<String, dynamic> ratesMap = Map<String, dynamic>.from(data['rates']);


          rates.value = [
            {
              "name": "USD",
              "buy": usdToSyp.toStringAsFixed(0),
              "sell": (usdToSyp * 1.01).toStringAsFixed(0),
              "flag": getFlagForCurrency("USD"),
            },
            ...ratesMap.entries.map((e) {
              double rateInUSD = (e.value as num).toDouble();
              double rateInSYP = usdToSyp / rateInUSD;


              return {
                "name": e.key,
                "buy": rateInSYP.toStringAsFixed(0),
                "sell": (rateInSYP * 1.01).toStringAsFixed(0),
                "flag": getFlagForCurrency(e.key),
              };
            }).toList()
          ];


          lastUpdate.value = data['date'] ?? "";
        } else {
          print("Error: 'rates' is null or missing in API response");
        }
      } else {
        print("Failed to load exchange rates: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      loading.value = false;
    }
  }

  String getFlagForCurrency(String code) {
    switch (code) {
      case "USD": return "🇺🇸";
      case "EUR": return "🇪🇺";
      case "GBP": return "🇬🇧";
      case "TRY": return "🇹🇷";
      case "CNY": return "🇨🇳";
      case "JPY": return "🇯🇵";
      case "AED": return "🇦🇪";
      case "SAR": return "🇸🇦";
      case "CAD": return "🇨🇦";
      case "AUD": return "🇦🇺";
      case "BRL": return "🇧🇷";
      case "INR": return "🇮🇳";
      case "RUB": return "🇷🇺";
      case "KRW": return "🇰🇷";
      case "MXN": return "🇲🇽";
      case "NZD": return "🇳🇿";
      case "THB": return "🇹🇭";
      case "CHF": return "🇨🇭";
      case "PLN": return "🇵🇱";
      case "SEK": return "🇸🇪";
      case "NOK": return "🇳🇴";
      case "DKK": return "🇩🇰";
      case "HUF": return "🇭🇺";
      case "CZK": return "🇨🇿";
      case "ILS": return "🇮🇱";
      case "PHP": return "🇵🇭";
      case "IDR": return "🇮🇩";
      case "MYR": return "🇲🇾";
      case "RON": return "🇷🇴";
      case "ZAR": return "🇿🇦";
      case "HKD": return "🇭🇰";
      case "ISK": return "🇮🇸";
      case "SGD": return "🇸🇬";
      default: return "💱";
    }
  }
}
