// lib/airtime_flow/airtime_page.dart

// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';

const Color _kAccentBlue = Color(0xFF0B63D6);

class AirtimePage extends StatefulWidget {
  const AirtimePage({Key? key}) : super(key: key);

  @override
  State<AirtimePage> createState() => _AirtimePageState();
}

class _AirtimePageState extends State<AirtimePage> {
  final TextEditingController _phoneController =
      TextEditingController(text: '08133228890');
  final FocusNode _phoneFocus = FocusNode();
  final List<int> _amounts = [50, 100, 200, 500, 1000, 2000];
  int _selectedAmount = 1000;

String _selectedNetwork = 'MTN';

final List<Map<String, String>> _networks = [
  {'name': 'MTN', 'icon': 'assets/images/mtn.png'},
  {'name': 'Airtel', 'icon': 'assets/images/airtel.png'},
  {'name': 'Glo', 'icon': 'assets/images/glo.jpeg'},
  {'name': '9mobile', 'icon': 'assets/images/9Mobile.jpeg'},
];

String _getPayAmount(int amount) {
  switch (amount) {
    case 500:
      return '200';
    case 1000:
      return '700';
    case 2000:
      return '1,700';
    default:
      return amount.toString();
  }
}

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  void _onContinue() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Continue: ${_phoneController.text} — ₦$_selectedAmount'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Airtime',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to history page
            },
            child: const Text(
              'History',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      
      body: SafeArea(
        child: SingleChildScrollView(
          
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cashback Banner
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 100, 157, 248),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/coin.png', // placeholder coin
                            width: 40,
                            height: 40,
                            opacity: const AlwaysStoppedAnimation(0.9),
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Get up to ₦100 Cashback',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Top up ₦1,000 for betting and get up to ₦100 cash back',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Positioned(
                        right: -10,
                        child: Image.asset(
                          'assets/images/players.png', // placeholder footballers
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // --- TOP-UP SECTION (FINAL POLISHED VERSION) ---
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 18.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // --- For Section ---
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'For',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
            children: [
            // --- Network Dropdown ---
            Flexible(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedNetwork,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
                isExpanded: true, // ✅ fixes overflow by letting it size safely
                alignment: Alignment.centerLeft,
                items: _networks.map((network) {
                  return DropdownMenuItem<String>(
                    value: network['name']!,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ✅ Circular image with safe sizing
                        ClipOval(
                          child: Image.asset(
                            network['icon']!,
                            width: 28,
                            height: 28,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedNetwork = value!);
                },
              ),
            ),
          ),
        ),

    const SizedBox(width: 10),

    // --- Phone number input ---
    Expanded(
      flex: 5,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _phoneController,
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '08133228899',
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const Icon(Icons.account_circle_outlined, color: Colors.black54),
          ],
        ),
      ),
    ),
  ],
),

          ],
        ),
      ),

      const SizedBox(height: 20),

      // --- Top Up Section ---
      const Text(
        'Top up',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),

      // --- Amount Grid with animation ---
      LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = (constraints.maxWidth - 24) / 3;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _amounts.map((amount) {
              final bool selected = amount == _selectedAmount;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedAmount = amount);
                },
                child: AnimatedScale(
                  scale: selected ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    width: boxWidth,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selected
                            ? _kAccentBlue
                            : Colors.grey.shade300,
                        width: selected ? 1.5 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: selected
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.grey.shade200,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '₦2% Cashback',
                          style: TextStyle(
                            color: Color(0xFF0B63D6),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₦$amount',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Pay ₦${_getPayAmount(amount)}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),

      const SizedBox(height: 20),

      // --- Custom Amount + Pay Button ---
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '₦',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '50 - 500,000',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: const UnderlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 6),
          ElevatedButton(
            onPressed: _onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
              elevation: 0,
              foregroundColor: Colors.black54,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Pay',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    ],
  ),
),


              // Airtime Service and Promos
              Container(
                color: Colors.grey.shade50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Airtime service',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.phone_android, color: Colors.blue),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('USSD enquiry',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text('Check phone balance and more',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'More events',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    _promoItem(
                      imageUrl: 'assets/images/promo1.png',
                      title: 'Up to 100% Bonus',
                      subtitle: 'Top up your account and get 100% bonus back',
                    ),
                    _promoItem(
                      imageUrl: 'assets/images/promo2.png',
                      title: 'Up to 30GB FREE Data!',
                      subtitle: 'Join BANGBET, Deposit & Claim Instantly',
                    ),
                    _promoItem(
                      imageUrl: 'assets/images/promo2.png',
                      title: 'Up to 30GB FREE Data!',
                      subtitle: 'Join BANGBET, Deposit & Claim Instantly',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _promoItem({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    final bool isLocal = !imageUrl.startsWith('http');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // 👇 Circular image container
          ClipOval(
            child: isLocal
                ? Image.asset(
                    imageUrl,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imageUrl,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
