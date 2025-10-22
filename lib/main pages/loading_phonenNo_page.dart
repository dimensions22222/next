import 'package:flutter/material.dart';
import 'package:next/main%20pages/success_screen.dart';

class LoadingAcctPage extends StatefulWidget {
  const LoadingAcctPage({super.key});

  @override
  State<LoadingAcctPage> createState() => _LoadingAcctPageState();
}

class _LoadingAcctPageState extends State<LoadingAcctPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    // Wait for 3 seconds before navigating
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to the placeholder page
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>( Color(0xFF0D47A1),),
              ),
            SizedBox(height: 16),
            Text(
              'Creating your account...',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
