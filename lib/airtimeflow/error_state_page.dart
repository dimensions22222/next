// lib/airtime_flow/error_state_page.dart
//
// ErrorStatePage
// Shown when phone number input is invalid.
// Place inside: lib/airtime_flow/error_state_page.dart
// Navigate with:
// Navigator.push(context, MaterialPageRoute(builder: (_) => const ErrorStatePage()));

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

const Color _kBackgroundGray = Color(0xFF343434);
const Color _kAccentBlue = Color(0xFF0B63D6);
const Color _kErrorRed = Color(0xFFD32F2F);

class ErrorStatePage extends StatefulWidget {
  const ErrorStatePage({Key? key}) : super(key: key);

  @override
  State<ErrorStatePage> createState() => _ErrorStatePageState();
}

class _ErrorStatePageState extends State<ErrorStatePage> {
  final TextEditingController _phoneController = TextEditingController();

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
            Text('Airtime', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
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

            // Balance card
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
              child: Container(
                height: 110,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _kAccentBlue,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Available balance', style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 6),
                        Text('₦ 56,432.320', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                        Spacer(),
                        Text('+2,000.32 rewards', style: TextStyle(color: Colors.white70)),
                      ]),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('+ Add money'),
                    )
                  ],
                ),
              ),
            ),

            // Main white section
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phone input (with red border)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: _kErrorRed, width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person, color: _kErrorRed),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter phone number',
                                      isDense: true,
                                    ),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                const Icon(Icons.more_vert),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Invalid phone number. Please check and try again.',
                            style: TextStyle(color: _kErrorRed, fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    // Cashback promo
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F1FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Get up to ₦100 Cashback\nTop up now',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _kAccentBlue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('Top up now'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Bottom section (disabled Pay button)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: [
                          const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.local_offer, color: Colors.orange),
                            title: Text('Airtime service'),
                            subtitle: Text('USSD enquiry\nCheck phone balance and more'),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: null, // Disabled
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                                disabledForegroundColor: Colors.white.withOpacity(0.5),
                                disabledBackgroundColor: Colors.grey.shade300,
                                minimumSize: const Size.fromHeight(54),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text(
                                'Continue',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                        ],
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
}
