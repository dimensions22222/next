// ignore_for_file: prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_const_constructors

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:next/main%20pages/dashboard_page.dart';
import 'dart:math';

import 'package:next/main%20pages/utils/widgets/custom_button.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  String _autoLogoutOption = "passwordFree";
  bool _useFaceID = true;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    // trigger confetti when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive font sizes
    final titleFontSize = screenWidth * 0.05;
    final subtitleFontSize = screenWidth * 0.035;
    final sectionTitleFontSize = screenWidth * 0.04;
    final optionTitleFontSize = screenWidth * 0.038;
    final optionSubtitleFontSize = screenWidth * 0.032;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD), // soft light blue top
              Color(0xFFFFFDE7), // soft cream bottom
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🎉 Confetti Layer
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Success Card
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.06),
                      margin: EdgeInsets.only(top: screenHeight * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                            size: screenWidth * 0.18,
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          Text(
                            "Congratulations Ayuk",
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: screenHeight * 0.008),

                          Text(
                            "Your account has been created successfully",
                            style: TextStyle(
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: screenHeight * 0.03),

                          // Continue Button
                          CustomButton(
                          text: 'Continue to Dashboard',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const DashboardPage()),
                            );
                          },
                          color: const Color(0xFF0D47A1),
                          textColor: Colors.white,
                          width: double.infinity,
                          height: screenHeight * 0.065,
                          borderRadius: 30,
                          elevation: 2,
                        ),

                        ],
                      ),
                    ),

                    // 🎊 Confetti Emitter
                    Positioned(
                      top: 0,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirection: pi / 2, // upwards
                        emissionFrequency: 0.05,
                        numberOfParticles: 20,
                        gravity: 0.3,
                        shouldLoop: false,
                        colors: const [
                          Colors.red,
                          Colors.green,
                          Colors.blue,
                          Colors.orange,
                          Colors.purple
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.04),

                // ⚙️ Auto-Logout Settings
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Auto-Logout Setting",
                        style: TextStyle(
                          fontSize: sectionTitleFontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Password-Free Login Option
                      _buildLoginOptionCard(
                        title: "Password-Free Login",
                        subtitle:
                            "You can log into Texa without entering password",
                        value: "passwordFree",
                        groupValue: _autoLogoutOption,
                        onChanged: (value) {
                          setState(() => _autoLogoutOption = value!);
                        },
                        optionTitleFontSize: optionTitleFontSize,
                        optionSubtitleFontSize: optionSubtitleFontSize,
                      ),

                      // Password Always Needed Login
                      _buildLoginOptionCard(
                        title: "Password Always Needed Login",
                        subtitle:
                            "You need to enter password everytime you log into Texa",
                        value: "passwordAlways",
                        groupValue: _autoLogoutOption,
                        onChanged: (value) {
                          setState(() => _autoLogoutOption = value!);
                        },
                        optionTitleFontSize: optionTitleFontSize,
                        optionSubtitleFontSize: optionSubtitleFontSize,
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Biometric Login Section
                      Text(
                        "Biometric Login Option",
                        style: TextStyle(
                          fontSize: sectionTitleFontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),

                      Card(
                        color: Colors.white,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.01,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Log in with Face ID",
                                style: TextStyle(
                                  fontSize: optionTitleFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              Switch(
                                value: _useFaceID,
                                onChanged: (value) {
                                  setState(() => _useFaceID = value);
                                },
                                activeColor: Color(0xFF0D47A1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable login option card
  Widget _buildLoginOptionCard({
    required String title,
    required String subtitle,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
    required double optionTitleFontSize,
    required double optionSubtitleFontSize,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1.5,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        title: Text(
          title,
          style: TextStyle(
            fontSize: optionTitleFontSize,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: optionSubtitleFontSize,
            color: Colors.grey[700],
          ),
        ),
        trailing: Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: const Color(0xFF0D47A1),
        ),
      ),
    );
  }
}
