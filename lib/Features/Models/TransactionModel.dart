class ElectricityTransaction {
  final String providerName;
  final double amountPaid;
  final String token;
  final String meterNumber;
  final String customerName;
  final String meterType;
  final String serviceAddress;
  final double unitsPurchased;
  final String transactionNo;
  final DateTime transactionDate;

  ElectricityTransaction({
    required this.providerName,
    required this.amountPaid,
    required this.token,
    required this.meterNumber,
    required this.customerName,
    required this.meterType,
    required this.serviceAddress,
    required this.unitsPurchased,
    required this.transactionNo,
    required this.transactionDate,
  });
}
