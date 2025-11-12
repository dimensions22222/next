import 'package:flutter/material.dart';
import 'package:next/ContactUs/SelectCategoryPage.dart';

class Submitissuepage extends StatelessWidget {
  const Submitissuepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 400;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Support',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 20 : 40,
            vertical: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Custom icon section
              SizedBox(
                height: isSmallScreen ? 80 : 100,
                width: isSmallScreen ? 80 : 100,
                child: const Center(child: Icon(Icons.group_add_outlined, color: Color(0xFF0D47A1),  size: 100,)),
              ),
              const SizedBox(height: 24),

              // Description text
              Text(
                'You do not have any active issue currently. '
                'If you have any issue, kindly use the button below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),

              // Submit Issue Button
              SizedBox(
                width: size.width * 0.6,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SelectCategoryPage()),
                );
                
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E56A0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Submit Issue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
