// lib/airtime_flow/enter_pin_page.dart
//
// EnterPinPage
// Page for entering transaction PIN.
// Place inside: lib/airtime_flow/enter_pin_page.dart
// Navigate with:
// Navigator.push(context, MaterialPageRoute(builder: (_) => const EnterPinPage()));

// ignore_for_file: unused_field

import 'package:flutter/material.dart';

const Color _kBackgroundGray = Color(0xFF343434);
const Color _kAccentBlue = Color(0xFF0B63D6);

class EnterPinPage extends StatefulWidget {
  const EnterPinPage({Key? key}) : super(key: key);

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  final List<String> _pin = ['', '', '', ''];
  final int _currentIndex = 0;

  void _onKeyTap(String value) {
    setState(() {
      if (value == 'back') {
        for (int i = _pin.length - 1; i >= 0; i--) {
          if (_pin[i].isNotEmpty) {
            _pin[i] = '';
            break;
          }
        }
      } else {
        for (int i = 0; i < _pin.length; i++) {
          if (_pin[i].isEmpty) {
            _pin[i] = value;
            break;
          }
        }
      }
    });
  }

  bool get _isPinComplete => !_pin.contains('');

  void _onConfirm() {
    if (_isPinComplete) {
      // Navigate to success page
      // Navigator.push(context, MaterialPageRoute(builder: (_) => const AirtimeSuccessPage()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN confirmed, proceeding...')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackgroundGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: const Row(
          children: [
            SizedBox(width: 4),
            Icon(Icons.arrow_back_ios, size: 18, color: Colors.white70),
            SizedBox(width: 8),
            Text('Enter PIN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(color: Color(0xFFECEFF1), shape: BoxShape.circle),
                    child: const Icon(Icons.person, color: Colors.black54),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi Ayuk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text('22 pts', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.black54),
                ],
              ),
            ),

            // Main PIN input section
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter your transaction PIN',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 24),

                    // PIN Circles
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        bool filled = _pin[index].isNotEmpty;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: filled ? _kAccentBlue : Colors.grey.shade300,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 60),

                    // Numeric Keypad
                    _buildKeypad(),

                    const SizedBox(height: 30),

                    // Confirm button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isPinComplete ? _onConfirm : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isPinComplete ? _kAccentBlue : Colors.grey.shade400,
                            minimumSize: const Size.fromHeight(54),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
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
    );
  }

  Widget _buildKeypad() {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'back'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              if (key.isEmpty) {
                return const SizedBox(width: 80);
              }
              return GestureDetector(
                onTap: () => _onKeyTap(key),
                child: Container(
                  width: 80,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                  ),
                  child: key == 'back'
                      ? const Icon(Icons.backspace_outlined, color: Colors.black54)
                      : Text(
                          key,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
