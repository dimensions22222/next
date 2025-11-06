// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next/main%20pages/acct_Otp_verify_page%20.dart';
import 'package:next/main%20pages/utils/widgets/Custom_Title.dart';
import 'package:next/main%20pages/utils/widgets/custom_button.dart';




class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    // Add a TextEditingController and a variable to track validity
    final  TextEditingController phoneController = TextEditingController();
    bool isPhoneValid = false;

    // Use StatefulBuilder or move controller to the State class for proper disposal in production
    return StatefulBuilder(
      builder: (context, setState) {
      // Listen to changes in the phone field
      phoneController.addListener(() {
        final valid = phoneController.text.trim().length == 11;
        if (valid != isPhoneValid) {
        setState(() {
          isPhoneValid = valid;
        });
        }
      });

      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Title
            CustomTitleText(title: 'Create an account',
             fontSize: 24,fontWeight: FontWeight.w700,),
            const SizedBox(height: 32),

            // Label
            CustomTitleText(title:'Phone',
            fontSize: 14,fontWeight: FontWeight.w600,),
            const SizedBox(height: 8),

            // Input Row
            Row(
            children: [
              // Country code dropdown
              Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                border: Border.all(color: const Color(0xFFC4C4C4)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                children: [
                Text('🇳🇬  '),
                SizedBox(
                  height: 50,
                  child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  ),
                ),
                CustomTitleText(title:'+234',
                fontSize: 16,fontWeight: FontWeight.w500,),
                Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                ],
              ),
              ),
              const SizedBox(width: 8),

              // Phone number field
              Expanded(
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [ FilteringTextInputFormatter.digitsOnly,],
                decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                hintText: 'phone number',
                hintStyle: const TextStyle(
                  color: Colors.black45,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                  color: Color(0xFFC4C4C4),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                  color: Color(0xFFC4C4C4),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                  color: Color(0xFF0D47A1),
                  width: 1.5,
                  ),
                ),
                ),
                style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                ),
              ),
              ),
            ],
            ),

            const SizedBox(height: 8),

            // Helper text
            CustomTitleText(title:'Verification code will be sent to this number',
            fontSize: 13,fontWeight: FontWeight.w400,color: Color(0xFF6C6C6C),),
            const SizedBox(height: 32),

            // Continue button
            CustomButton(
            text: 'Continue',
            onPressed: isPhoneValid
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerifyPhoneNumber(),
                      ),
                    );
                  }
                : () {},
            color: isPhoneValid
                ? const Color(0xFF0D47A1)
                : const Color(0xFFB3C6E6),
            textColor: Colors.white,
            width: double.infinity,
          ),

          ],
          ),
        ),
        ),
      );
      },
    );
    
  }
}
