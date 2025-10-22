// lib/airtime_flow/active_state_page.dart
//
// ActiveStatePage
// Screen showing active top-up selection (user ready to proceed).
// Place inside: lib/airtime_flow/active_state_page.dart
// Navigate from AirtimePage with:
// Navigator.push(context, MaterialPageRoute(builder: (_) => const ActiveStatePage()));

import 'package:flutter/material.dart';

const Color _kBackgroundGray = Color(0xFF343434);
const Color _kAccentBlue = Color(0xFF0B63D6);

class ActiveStatePage extends StatefulWidget {
  const ActiveStatePage({Key? key}) : super(key: key);

  @override
  State<ActiveStatePage> createState() => _ActiveStatePageState();
}

class _ActiveStatePageState extends State<ActiveStatePage> {
  final TextEditingController _phoneController = TextEditingController(text: '08133228899');
  final List<int> _amounts = [50, 100, 200, 500, 1000, 2000, 5000, 10000];
  int _selectedAmount = 2000;

  void _onContinue() {
    // Navigate to confirmation page
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const AirtimeConfirmationPage()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proceeding to confirmation ₦$_selectedAmount')));
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
            Text('Airtime', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
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

            // Main white area
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Phone input
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: const BoxDecoration(color: Color(0xFFFFC107), shape: BoxShape.circle),
                            child: const Icon(Icons.person, color: Colors.white, size: 18),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '08133228899',
                                isDense: true,
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const Icon(Icons.more_vert),
                        ],
                      ),
                    ),

                    // Cashback promo strip
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

                    const SizedBox(height: 12),

                    // Select amount
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        children: [
                          Text('Select amount', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Amount chips
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _amounts.map((a) {
                          final selected = a == _selectedAmount;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedAmount = a),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: selected ? _kAccentBlue : Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: selected ? _kAccentBlue : Colors.grey.shade300),
                              ),
                              child: Text(
                                '₦$a',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: selected ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const Spacer(),

                    // Bottom actions
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
                              onPressed: _onContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _kAccentBlue,
                                minimumSize: const Size.fromHeight(54),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text('Pay ₦${_selectedAmount.toString()}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
