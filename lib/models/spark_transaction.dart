class SparkTransaction {
  final String transactionId;
  final double amount;
  final String currency;
  final DateTime timestamp;

  SparkTransaction({
    required this.transactionId,
    required this.amount,
    required this.currency,
    required this.timestamp,
  });
}
