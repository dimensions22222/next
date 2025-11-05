// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next/main%20pages/create_acc_login_page.dart';
import 'package:next/main%20pages/create_acct_page.dart';
import 'package:next/main%20pages/utils/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),

              // Avatar with blue dot
              Stack(
                children: [
                  Container(
                    width: width * 0.13,
                    height: width * 0.13,
                    decoration: const BoxDecoration(
                      color: Color(0xFFAEC4E5),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        't',
                        style: TextStyle(
                          fontSize: width * 0.1,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFAEC4E5),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0.2, 0.2),
                              blurRadius: 0.1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.08,
                    top: width * 0.035,
                    child: Container(
                      width: width * 0.015,
                      height: width * 0.015,
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),

              // Welcome Text
              Text(
                "Welcome back Taiwo",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: height * 0.20),

              // Center Face ID Icon
              Center(
                child: Column(
                  children: [
                    Container(
                      width: width * 0.18,
                      height: width * 0.18,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4DFF5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/face_id.svg',
                          width: width * 0.09,
                          height: width * 0.09,
                          color: const Color(0xFF0D47A1),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Text(
                      "Tap icon above to Login",
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.08),

              // Login button
             Center(
  child: CustomButton(
    text: 'Login with phone number',
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateAccountLoginPage(),
        ),
      );
    },
    color: const Color(0xFF0D47A1),
    width: double.infinity,
    height: height * 0.06,
  ),
),

              const Spacer(),

              // Footer
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.035,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccountPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: const Color(0xFF0D47A1),
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
