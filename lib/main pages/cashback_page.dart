import 'package:flutter/material.dart';
import 'package:next/main%20pages/create_acct_page.dart';
import 'package:next/main%20pages/login_faceid_page.dart';
import 'package:next/main pages/utils/widgets/';




/// Onboarding screen with image slider, text, and buttons
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _imagePaths = [
    'assets/images/cashback.png',
    'assets/images/Placeholder1.PNG', // Placeholder image 1
    'assets/images/Placeholder2.PNG', // Placeholder image 2
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: _currentPage == index ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF0D47A1) : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.2),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 80),

            /// Cashback text
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Cashback",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF0D47A1),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: " on every Airtime/\nData top up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight:   FontWeight.w500,),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),

            /// Image slider
            SizedBox(
              height: 450,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _imagePaths.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Image.asset(
                      _imagePaths[index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),

            /// Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _imagePaths.length,
                (index) => _buildPageIndicator(index),
              ),
            ),

            const SizedBox(height: 40),

            /// Buttons
           /// Buttons
Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    CustomButton(
      text: 'Create a new account',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateAccountPage()),
        );
      },
    ),
    const SizedBox(height: 20),
    CustomButton(
      text: 'Login',
      isOutlined: true,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
    ),
  ],
),

            const SizedBox(height: 20),
            // Moved inside the ListView children
          ],
        ),
      ),
    );
  }
}
