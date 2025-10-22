// lib/airtime_flow/airtime_success_page.dart
//
// AirtimeSuccessPage
// Final success confirmation screen after successful purchase.
// Place inside: lib/airtime_flow/airtime_success_page.dart
// Navigate with:
// Navigator.push(context, MaterialPageRoute(builder: (_) => const AirtimeSuccessPage()));

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

const Color _kBackgroundGray = Color(0xFF343434);
const Color _kAccentBlue = Color(0xFF0B63D6);
const Color _kSuccessGreen = Color(0xFF4CAF50);

class AirtimeSuccessPage extends StatelessWidget {
  const AirtimeSuccessPage({Key? key}) : super(key: key);

  void _onDone(BuildContext context) {
    // Navigate back to dashboard or pop all
    Navigator.popUntil(context, (route) => route.isFirst);
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
            Text('Airtime Success', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
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

            // Success area
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Success icon placeholder
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _kSuccessGreen.withOpacity(0.1),
                        border: Border.all(color: _kSuccessGreen, width: 2),
                      ),
                      child: const Icon(Icons.check, color: _kSuccessGreen, size: 50),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Airtime Purchase Successful!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '₦2,000 has been credited to 08133228899',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Transaction ID: TXN13482219',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 40),

                    // Transaction summary card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildRow('Phone Number', '08133228899'),
                            const Divider(),
                            _buildRow('Network', 'MTN'),
                            const Divider(),
                            _buildRow('Amount', '₦2,000'),
                            const Divider(),
                            _buildRow('Convenience Fee', '₦10'),
                            const Divider(),
                            _buildRow('Total', '₦2,010', bold: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom "Done" button
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onDone(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kAccentBlue,
                    minimumSize: const Size.fromHeight(54),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 15, color: Colors.black87)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
