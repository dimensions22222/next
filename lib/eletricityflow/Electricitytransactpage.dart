// lib/electricityflow/electricity_transact_page.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ElectricityTransactPage extends StatelessWidget {
  final String customerName;
  final String meterNumber;
  final String meterType;
  final String serviceAddress;
  final double amountPaid;
  final String transactionNo;
  final String transactionDate;
  final String token;
  final String units;

  const ElectricityTransactPage({
    Key? key,
    required this.customerName,
    required this.meterNumber,
    required this.meterType,
    required this.serviceAddress,
    required this.amountPaid,
    required this.transactionNo,
    required this.transactionDate,
    required this.token,
    required this.units,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Transaction Details",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 40 : 16,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSummaryCard(context),
            SizedBox(height: 20),
            _buildTransactionDetails(context),
            SizedBox(height: 30),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/abuja.png',
              height: 35,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Abuja Electricity",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            "₦${amountPaid.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.check_circle, color: Color(0xFF0D47A1), size: 18),
              SizedBox(width: 5),
              Text(
                "Successful",
                style: TextStyle(color: Color(0xFF0D47A1), fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    token,
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy, size: 20, color: Colors.grey[700]),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: token));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Token copied to clipboard"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(BuildContext context) {
    final labelStyle = TextStyle(color: Colors.grey[600], fontSize: 13);
    final valueStyle = TextStyle(
        color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 15);

    Widget buildRow(String label, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: labelStyle),
              Flexible(
                child: Text(
                  value,
                  style: valueStyle,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        );

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transaction Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          buildRow("Meter Number", meterNumber),
          buildRow("Customer Name", customerName),
          buildRow("Meter Type", meterType),
          buildRow("Service Address", serviceAddress),
          buildRow("Amount Paid", "₦${amountPaid.toStringAsFixed(2)}"),
          buildRow("Units Purchased", units),
          buildRow("Transaction No.", transactionNo),
          buildRow("Transaction Date", transactionDate),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFF0D47A1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Issue report feature coming soon")),
              );
            },
            child: Text("Report Issue",
                style: TextStyle(color: Color(0xFF0D47A1))),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0D47A1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
              onPressed:
              () {
                Share.share(
                    'Electricity Purchase Receipt');
              
            },
            child: Text("Share Receipt", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
