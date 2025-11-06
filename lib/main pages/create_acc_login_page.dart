// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next/main%20pages/dashboard_page.dart';
import 'package:next/main%20pages/utils/widgets/Custom_Title.dart';
import 'package:next/main%20pages/utils/widgets/custom_button.dart'; // Import your custom button

class CreateAccountLoginPage extends StatefulWidget {
  const CreateAccountLoginPage({super.key});

  @override
  State<CreateAccountLoginPage> createState() => _CreateAccountLoginPageState();
}

class _CreateAccountLoginPageState extends State<CreateAccountLoginPage> {
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Center(
              child:CustomTitleText(title: 'TRIGON',
              fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFF0D47A1),),
            ),
            const SizedBox(height: 24),
            CustomTitleText(title:'Get Started on Trigon',
            fontSize: 18,fontWeight: FontWeight.w800,
            ),
            const SizedBox(height: 24),

            // Phone label
            CustomTitleText(title:'Phone',fontSize: 14,fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 8),

            // Phone text field (numbers only)
            TextField(
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/flag.jfif',
                    width: 24,
                    height: 24,
                  ),
                ),
                hintText: 'Enter your phone number',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Use the CustomButton widget
            Center(
              child: CustomButton(
                text: 'Create Account',
                enabled: _phoneNumber.length >= 11,
                color: const Color(0xFF0D47A1),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardPage(),
                    ),
                  );
                },
                borderRadius: 100,
                width: double.infinity,
                height: 55,
                elevation: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
