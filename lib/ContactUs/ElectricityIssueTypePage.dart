// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:next/ContactUs/ElectricityTransactionSelectPage.dart';


class ElectricityIssueTypePage extends StatefulWidget {
  const ElectricityIssueTypePage({Key? key}) : super(key: key);

  @override
  State<ElectricityIssueTypePage> createState() =>
      _ElectricityIssueTypePageState();
}

class _ElectricityIssueTypePageState extends State<ElectricityIssueTypePage> {
  int? selectedIssue;

  final issues = [
    "My account was debited but token was not generated",
    "My account was debited but the transaction is still pending",
    "My Electricity bill payment was unsuccessful",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Electricity",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _StepIndicator(step: "Step 2 of 3"),
            const SizedBox(height: 20),
            const Text(
              "Select Issue Type",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: List.generate(issues.length, (index) {
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: const Icon(
                      Icons.circle,
                      size: 10,
                      color:Color(0xFF0D47A1), 
                    ),
                    title: Text(
                      issues[index],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight:FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                    onTap: () {
                      setState(() => selectedIssue = index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ElectricityTransactionSelectPage(),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
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
        border: Border.all(color:const Color.fromARGB(255, 13, 71, 161).withOpacity(0.5),),
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
