// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:next/ContactUs/Electricity%20issue%20reporting%20page%20.dart';

class ElectricityTransactionSelectPage extends StatefulWidget {
  const ElectricityTransactionSelectPage({Key? key}) : super(key: key);

  @override
  State<ElectricityTransactionSelectPage> createState() =>
      _ElectricityTransactionSelectPageState();
}

class _ElectricityTransactionSelectPageState
    extends State<ElectricityTransactionSelectPage> {
  String? selectedTransaction;

  final transactions = [
    {"provider": "Abuja Electricity", "amount": "₦9,000.00", "status": "pending", "date": "Aug 13th, 11:11:12"},
    {"provider": "Abuja Electricity", "amount": "₦9,000.00", "status": "successful", "date": "Aug 10th, 21:10:10"},
    {"provider": "Abuja Electricity", "amount": "₦9,000.00", "status": "successful", "date": "Aug 10th, 21:10:10"},
    {"provider": "Abuja Electricity", "amount": "₦9,000.00", "status": "successful", "date": "Aug 10th, 21:10:10"},
    {"provider": "Abuja Electricity", "amount": "₦9,000.00", "status": "successful", "date": "Aug 10th, 21:10:10"},
    {"provider": "Abuja Electricity", "amount": "₦9,000.00", "status": "successful", "date": "Aug 10th, 21:10:10"},
    {"provider": "Abuja Electricity", "amount": "₦9,000.00", "status": "successful", "date": "Aug 10th, 21:10:10"},
    {"provider": "Abuja Electricity", "amount": "₦9,000.00", "status": "successful", "date": "Aug 10th, 21:10:10"},
    {"provider": "Abuja Electricity", "amount": "₦9,000.00", "status": "successful", "date": "Aug 10th, 21:10:10"},
    
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
    backgroundColor:const Color.fromARGB(247, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Electricity",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: _StepIndicator(step: "Step 3 of 3"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Which transaction has an issue?",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  final isSelected = selectedTransaction == tx["date"];
                  return GestureDetector(
                    onTap: () {
  setState(() => selectedTransaction = tx["date"]);

  // 👇 if it's pending, go straight to Reporting Page
  if (tx["status"] == "pending") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ElectricityIssueReportPage(),
      ),
    );
  }
},

                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? const Color.fromARGB(255, 13, 71, 161).withOpacity(0.5)
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey.shade100,
                            child:Image.asset('assets/images/abuja.png')
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tx["provider"]!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tx["date"]!,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "-${tx["amount"]!}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: tx["status"] == "pending"
                                      ? Colors.orange.shade50
                                      : Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  tx["status"]!,
                                  style: TextStyle(
                                    color: tx["status"] == "pending"
                                        ? Colors.orange
                                        : Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final String step;
  const _StepIndicator({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color.fromARGB(255, 13, 71, 161).withOpacity(0.5),),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color:Color(0xFF0D47A1), size: 18),
          const SizedBox(width: 6),
          Text(
            step,
            style: const TextStyle(
               color:Color(0xFF0D47A1), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
