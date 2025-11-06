import 'package:flutter/material.dart';
import 'package:next/main%20pages/create_acct_page.dart';
import 'package:next/main%20pages/login_faceid_page.dart';
import 'package:next/main%20pages/utils/widgets/custom_button.dart';
import 'package:next/main%20pages/dashboard_page.dart'; // make sure this import exists

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _showDevButton = false; // <--- state for dev button visibility
  late AnimationController _animController;
  late Animation<Offset> _offsetAnimation;

  final List<String> _imagePaths = [
    'assets/images/cashback.png',
    'assets/images/Placeholder1.PNG',
    'assets/images/Placeholder2.PNG',
  ];

  @override
void initState() {
  super.initState();
  _animController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900), // 🕒 slower, smoother
  );

  _offsetAnimation = Tween<Offset>(
    begin: const Offset(1.5, 0), // 👈 slide in from right
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack, // 🎯 subtle bounce, feels premium
    ),
  );
}


  Widget _buildPageIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: _currentPage == index ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? const Color(0xFF0D47A1)
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// MAIN CONTENT
          Padding(
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
                        text: " on every Airtime\nData top up",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
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
                      setState(() => _currentPage = index);
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: 'Create a new account',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateAccountPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    /// LOGIN button with LONG PRESS
                    GestureDetector(
                      onLongPress: () {
                        setState(() {
                          _showDevButton = true;
                        });
                        _animController.forward();
                      },
                      child: CustomButton(
                        text: 'Login',
                        isOutlined: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          /// FLOATING DEV BUTTON (appears from left)
          if (_showDevButton)
            Positioned(
              top: 590,
              right: 10,
              child: FadeTransition(
  opacity: _animController,
  child: SlideTransition(
    position: _offsetAnimation,
    child: FloatingActionButton.extended(
      heroTag: "devButton",
      backgroundColor: const Color(0xFF0D47A1),
      icon: const Icon(Icons.developer_mode, color: Colors.white),
      label: const Text("Dev Mode", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      },
    ),
  ),
),            ),
        ],
      ),
    );
  }
}
