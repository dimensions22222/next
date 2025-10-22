// lib/airtime_flow/airtime_confirmation_page.dart
//
// AirtimeConfirmationPage
// Screen for reviewing and confirming airtime purchase.
// Place inside: lib/airtime_flow/airtime_confirmation_page.dart
// Navigate with:
// Navigator.push(context, MaterialPageRoute(builder: (_) => const AirtimeConfirmationPage()));

import 'package:flutter/material.dart';

const Color _kBackgroundGray = Color(0xFF343434);
const Color _kAccentBlue = Color(0xFF0B63D6);
const Color _kLightGray = Color(0xFFE0E0E0);

class AirtimeConfirmationPage extends StatelessWidget {
  const AirtimeConfirmationPage({Key? key}) : super(key: key);

  void _onConfirm(BuildContext context) {
    // Navigate to PIN entry screen
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const EnterPinPage()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proceeding to PIN entry')),
    );
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
            Text('Airtime Confirmation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header profile
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

            // Main confirmation area
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Confirm Airtime Purchase',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),

                      // Confirmation Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _kLightGray),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(0, 3),
                              blurRadius: 8,
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

                      const SizedBox(height: 40),
                      const Text(
                        'By confirming, you authorize this payment to proceed.',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const Spacer(),

                      // Confirm Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _onConfirm(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _kAccentBlue,
                            minimumSize: const Size.fromHeight(54),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Confirm Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
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
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
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
