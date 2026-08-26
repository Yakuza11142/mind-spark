class CurrencyConverter {
  static String formatNGN(double amount) {
    return '₦${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  static String formatUSD(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
  
  static double convertUSDToNGN(double usd, {double exchangeRate = 1500.0}) {
    return usd * exchangeRate;
  }
}
