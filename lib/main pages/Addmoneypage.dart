// ignore_for_file: deprecated_member_use, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next/main%20pages/utils/widgets/Custom_Title.dart';
import 'package:next/main%20pages/utils/widgets/custom_button.dart';
import 'package:share_plus/share_plus.dart';

class AddMoneyPage extends StatelessWidget {
  const AddMoneyPage({super.key});

  final String accountNumber = '703 450 0388';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Money',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank Transfer Section
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D47A1).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.account_balance,
                          color: Color(0xFF0D47A1)),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTitleText(title: 'Bank Transfer',
                          fontWeight: FontWeight.w600,fontSize: 16,
                          ),
                           SizedBox(height: 2),
                          CustomTitleText(title: 'Add money via mobile or internet banking',
                          color: Colors.grey,fontSize: 13,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Account Number
            CustomTitleText(title: 'Trigon Account Number',
            color: Colors.grey,fontSize: 14,
            ),
            const SizedBox(height: 8),
            Text(
              accountNumber,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 24),

            // Buttons Row
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Copy Number',
                    isOutlined: true,
                    height: 50,
                    borderRadius: 100,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0D47A1),
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: accountNumber));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Account number copied'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Share Details',
                    color: const Color(0xFF0D47A1),
                    height: 50,
                    borderRadius: 100,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () {
                      Share.share('Trigon Account Number: $accountNumber');
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Info Card
            const Card(
              color: Colors.white,
              margin: EdgeInsets.all(6),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitleText(title: 'Add money to your Trigon account in 3 easy steps:',
                    fontSize: 18,fontWeight: FontWeight.w600,textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 12),
                    Text('1. Copy your account details above - 703-450-0388.'),
                    Text(
                        '2. Open the bank app you want to transfer money from.'),
                    Text(
                        '3. Transfer the desired amount to your Trigon Account.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
