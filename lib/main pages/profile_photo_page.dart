// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:next/main%20pages/loading_phonenNo_page.dart';
import 'package:next/customWidget/profile_image_store.dart'; // Add this import at the top


class ProfilePhotoScreen extends StatefulWidget {
  const ProfilePhotoScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

 Future<void> _pickImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _imageFile = File(pickedFile.path);
      ProfileImageStore.imageFile = _imageFile; // ✅ store globally
    });
  }
}


  // 👇 Dialog for "Profile not complete"
  void _showProfileIncompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.06),
            child: Stack(
              children: [
                // Main content
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: screenWidth * 0.1,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      "Profile not complete",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Trigon will create a temporal account for you pending verification",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.037,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  
                  ],
                ),

                // ❌ Exit icon button at top-right
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey.shade600,
                      size: screenWidth * 0.06,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // close dialog
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasImage = _imageFile != null;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double titleFontSize = screenWidth * 0.06;
    double subtitleFontSize = screenWidth * 0.035;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.01),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: screenWidth * 0.065,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                SizedBox(height: screenHeight * 0.005),

                // Progress bar
                LinearProgressIndicator(
                  value: 0.2,
                  backgroundColor: Colors.grey.shade300,
                  color: const Color(0xFF0D47A1),
                  minHeight: 3,
                ),

                SizedBox(height: screenHeight * 0.04),

                // Title
                Text(
                  "Profile photo",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Sellers with pictures get better patronage",
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // Profile photo area
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Image.asset(
                            'assets/images/Untitled.png',
                            width: screenWidth * 0.85,
                            height: screenWidth * 0.85,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -40),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: screenWidth * 0.23,
                              height: screenWidth * 0.23,
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: hasImage
                                    ? Image.file(
                                        _imageFile!,
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: screenWidth * 0.1,
                                          color: Colors.green.shade600,
                                        ),
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: -9,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D47A1),
                                    shape: BoxShape.circle,
                                  ),
                                  padding:
                                      EdgeInsets.all(screenWidth * 0.015),
                                  child: Icon(
                                    Icons.add_sharp,
                                    weight: sqrt1_2,
                                    color: Colors.white,
                                    size: screenWidth * 0.045,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.06),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.065,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!hasImage) {
                        _showProfileIncompleteDialog(); // show dialog only if no image
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoadingAcctPage(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          hasImage ? const Color(0xFF0D47A1) : Colors.blue.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color: hasImage ? Colors.white : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),

                // Skip Button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoadingAcctPage(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      "Skip and continue",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.black38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
