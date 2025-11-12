// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:next/ContactUs/ElectricityIssueTypePage.dart';


class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({Key? key}) : super(key: key);

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  int? selectedIndex;

  final categories = [
    {'icon': Icons.phone_android, 'label': 'Airtime'},
    {'icon': Icons.tv, 'label': 'TV'},
    {'icon': Icons.wifi, 'label': 'Data'},
    {'icon': Icons.flash_on, 'label': 'Electricity'},
    {'icon': Icons.more_horiz, 'label': 'Others'},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
     backgroundColor:const Color.fromARGB(247, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Support",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: _StepIndicator(step: "Step 1 of 3"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Select Issue Category",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(categories.length, (index) {
                  final c = categories[index];
                  final isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                      if (c['label'] == 'Electricity') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ElectricityIssueTypePage(),
                          ),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: 
                               const Color.fromARGB(69, 187, 222, 251),
                          child: Icon(
                            c['icon'] as IconData,
                            color:const Color(0xFF0D47A1), 
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          c['label'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected
                                ? Colors.blue.shade700
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final String step;
  const _StepIndicator({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all( color:const Color.fromARGB(255, 13, 71, 161).withOpacity(0.5),),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle,  color:Color(0xFF0D47A1),  size: 18),
          const SizedBox(width: 6),
          Text(
            step,
            style: const TextStyle(
                 color:Color(0xFF0D47A1),  fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
