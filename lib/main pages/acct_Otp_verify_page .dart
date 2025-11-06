// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:next/main%20pages/pin_code_page.dart';
import 'package:next/main%20pages/utils/widgets/Custom_Title.dart';

class VerifyPhoneNumber extends StatefulWidget {
  const VerifyPhoneNumber({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  int _secondsRemaining = 41;
  late Timer _timer;

  // controllers for each OTP box
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
  return Container(
    width: 55, // set a specific width
    height: 60, // and height
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade400),
    ),
    alignment: Alignment.center,
    child: TextField(
      key: ValueKey('otp_field_$index'),
      controller: _otpControllers[index],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: '',
      ),
      onChanged: (value) {
        if (value.isNotEmpty && index < 3) {
          FocusScope.of(context).nextFocus();
        }
        if (_otpControllers.every((c) => c.text.isNotEmpty)) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreatePinScreen()),
            );
          });
        }
      },
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              // Back button and Progress bar (1/2 tries)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 50,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
             
              const SizedBox(height: 10),
              // Title
              CustomTitleText(title: "Verify Phone Number",fontSize: 20,fontWeight: FontWeight.bold),
              const SizedBox(height: 10),
              Row(
                children: [
                  CustomTitleText(title: "Verification code sent to ",fontSize: 14,color: Colors.grey[600]),
                  CustomTitleText(title:"08133228899",fontSize: 14,color: Colors.black54,),
                ],
              ),
              const SizedBox(height: 40),

              // OTP 
              Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOtpBox(0),
                  const SizedBox(width: 10),
                  _buildOtpBox(1),
                  const SizedBox(width: 10),
                  _buildOtpBox(2),
                  const SizedBox(width: 10),
                  _buildOtpBox(3),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  CustomTitleText(
                    title: "Resend code in",
                    fontSize: 14,color: Colors.grey[600],fontWeight: FontWeight.w500,
                  ),
              const SizedBox(width: 6),
              CustomTitleText(title: "0:${_secondsRemaining.toString().padLeft(2, '0')}s",
              fontSize: 14,color: Colors.blue,fontWeight: FontWeight.w500
              ),
                ],
              ), // Resend timer
              
              const Spacer(),

              // Secured N encrypted
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 18, color: Colors.blue),
                  SizedBox(width: 6),
                  CustomTitleText(title:"Secured and encrypted",fontSize: 14, color: Colors.grey),
                  ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}