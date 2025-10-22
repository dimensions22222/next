// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:next/main%20pages/profile_photo_page.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({Key? key}) : super(key: key);

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  String? selectedIdType;
  final TextEditingController idController = TextEditingController();

  bool get isButtonEnabled {
    if (selectedIdType == null) return false;
    if (selectedIdType == "BVN" && idController.text.length == 11) return true;
    if (selectedIdType == "NIN" && idController.text.length >= 8) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.06),

              // Back button + Progress bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Container(
                    width: width * 0.15,
                    height: 3,
                    decoration: BoxDecoration(
                      color:  const Color(0xFF0D47A1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),

              // Title
              Text(
                "Identity Verification",
                style: TextStyle(
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: height * 0.01),

              Text(
                "According to CBN regulations, please verify your BVN/NIN before using your Texa account. Texa will protect your information security.",
                style: TextStyle(
                  fontSize: width * 0.035,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              SizedBox(height: height * 0.04),

              // ID Type
              Text(
                "ID Type",
                style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: height * 0.015),

              // BVN / NIN Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedIdType = "BVN";
                          idController.clear();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: selectedIdType == "BVN"
                              ?  const Color(0xFF0D47A1)
                              : Colors.grey.shade300,
                        ),
                        backgroundColor: selectedIdType == "BVN"
                            ? Colors.white
                            : const Color(0xFFF7F7F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: height * 0.018),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "BVN",
                            style: TextStyle(
                              color: selectedIdType == "BVN"
                                  ? Colors.black
                                  : Colors.grey.shade600,
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.verified_user_sharp,
                            size: width * 0.045,
                            color: selectedIdType == "BVN"
                                ?  const Color(0xFF0D47A1)
                                : Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.04),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedIdType = "NIN";
                          idController.clear();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: selectedIdType == "NIN"
                              ?  const Color(0xFF0D47A1)
                              : Colors.grey.shade300,
                        ),
                        backgroundColor: selectedIdType == "NIN"
                            ? Colors.white
                            : const Color(0xFFF7F7F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: height * 0.018),
                      ),
                      child: Text(
                        "NIN",
                        style: TextStyle(
                          color: selectedIdType == "NIN"
                              ? Colors.black
                              : Colors.grey.shade600,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.04),

              // Input Field (BVN/NIN)
              if (selectedIdType != null) ...[
                Text(
                  "$selectedIdType Number",
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.015),
    AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: TextField(
        controller: idController,
        keyboardType: TextInputType.number,
        maxLength: selectedIdType == "BVN" ? 11 : 15,
        decoration: InputDecoration(
          hintText: selectedIdType == "BVN"
              ? "Please enter 11 digit BVN number"
              : "Please enter your NIN number",
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: width * 0.037,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color:  Color(0xFF0D47A1), width: 1.2),
            borderRadius: BorderRadius.circular(8),
          ),
          counterText: "",
        ),
        onChanged: (_) => setState(() {}),
      ),
    ),
  ],
              

              SizedBox(height: height * 0.08),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ProfilePhotoScreen(),
                            ),
                          );
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color(0xFFDDE4F2); // grayish-blue
                        }
                        return  const Color(0xFF0D47A1); // active blue
                      },
                    ),
                    elevation: const MaterialStatePropertyAll(0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: width * 0.043,
                      color: isButtonEnabled
                          ? Colors.white
                          :  const Color(0xFF0D47A1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
