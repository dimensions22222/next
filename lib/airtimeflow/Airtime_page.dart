// lib/airtime_flow/airtime_page.dart

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
    final media = MediaQuery.of(context);
    final isNarrow = media.size.width < 360;

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
          physics: const BouncingScrollPhysics(),
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

              // Top-up Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phone input
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade700,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                'M',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
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
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const Icon(Icons.person_outline),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Amount selection grid
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _amounts.map((a) {
                        final selected = a == _selectedAmount;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedAmount = a),
                          child: Container(
                            width: 95,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: selected ? _kAccentBlue : Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '₦$a',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color:
                                        selected ? Colors.white : Colors.black,
                                    fontSize: isNarrow ? 13 : 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '2% Cashback',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        selected ? Colors.white70 : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 25),

                    // Custom amount + Pay button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('₦'),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '50 - 500,000',
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        ElevatedButton(
                          onPressed: _onContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _kAccentBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Pay'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
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
