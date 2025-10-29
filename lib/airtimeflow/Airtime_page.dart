// lib/airtime_flow/airtime_page.dart

// ignore_for_file: deprecated_member_use, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:next/airtimeflow/airtime_success_page.dart';
import 'package:next/main%20pages/dashboard_page.dart';
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
  final TextEditingController _amountController = TextEditingController();


String _selectedNetwork = 'MTN';
bool _isFormValid = false;

void _validateForm() {
  final isPhoneValid = _phoneController.text.trim().length >= 10;
  final isAmountValid = _selectedAmount > 0;
  final isNetworkSelected = _selectedNetwork.isNotEmpty;

  setState(() {
    _isFormValid = isPhoneValid && isAmountValid && isNetworkSelected;
  });
}


final List<Map<String, String>> _networks = [
  {'name': 'MTN', 'icon': 'assets/images/mtn.png'},
  {'name': 'Airtel', 'icon': 'assets/images/airtel.png'},
  {'name': 'Glo', 'icon': 'assets/images/glo.jpeg'},
  {'name': '9mobile', 'icon': 'assets/images/9Mobile.jpeg'},
];



void _showAirtimeConfirmation(BuildContext context, double amount, String phoneNumber) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Center(
              child: Text(
                "₦ ${amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildConfirmationRow("Product name", "Airtime"),
            _buildConfirmationRow("Recipient Mobile", phoneNumber),
            _buildConfirmationRow("Amount", "₦${amount.toStringAsFixed(2)}"),
            const SizedBox(height: 5),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Bonus to Earn"),
                Text("+2% Cashback", style: TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Payment Method", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Available Balance (₦56,000.00)",
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Wallet", style: TextStyle(fontSize: 14, color: Colors.black54)),
                      Text("-₦${amount.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                Navigator.pop(context); // close confirmation
                await _showEnterPinPopup(context); // show PIN popup
              },

                child: const Text("Confirm", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildConfirmationRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.black54)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    ),
  );
}


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
  _amountController.dispose(); 
  super.dispose();
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
          onPressed: () =>  
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ),
        ),
        ),
        title: const Text(
          'Airtime',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to history 
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cashback Banner
             Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 78, 142, 246), Color.fromARGB(255, 124, 168, 251)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // coin image
              Positioned(
                left: 10,
                top: 10,
                child: Opacity(
                  opacity: 0.25,
                  child: Image.asset(
                    'assets/images/coin.png',
                    width: 35,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Players image 
              Positioned(
                right: 0,
                bottom: 20,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(18),
                  ),
                  child: Image.asset(
                    'assets/images/players.png',
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Text + Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Get up to ₦100 Cashback',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Top up ₦1,000 for betting and get up                                             to ₦100 cash back',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color.fromARGB(255, 50, 67, 76),
                        height: 1.3,
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          'Top up now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
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


              const SizedBox(height: 16),

              // --- TOP-UP SECTION
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
    // container for dropdown + textfield ---
    Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            // --- Network dropdown ---
            SizedBox(
              width: 70, // fixed width for logo area
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedNetwork,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black87, size: 20),
                  isExpanded: true,
                  alignment: Alignment.center,
                  items: _networks.map((network) {
                    return DropdownMenuItem<String>(
                      value: network['name']!,
                      child: Center(
                        child: ClipOval(
                          child: Image.asset(
                            network['icon']!,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                  setState(() => _selectedNetwork = value!);
                  _validateForm();
                },

                ),
              ),
            ),

            // --- Vertical divider ---
            Container(
              width: 1,
              height: 28,
              color: Colors.grey.shade300,
            ),

            // --- Phone input ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                  Expanded(
                    child: TextField(
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    keyboardType: TextInputType.phone,
                    onChanged: (_) => _validateForm(), //auto recheck on change
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '08133228890',
                      isDense: true,
                    ),
                    style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                    color: Color(0xFF0D47A1),
                    shape: BoxShape.circle,
                    ),
                    child: const Icon(
                    Icons.account_circle_outlined,
                    size: 24,
                    color: Colors.white,
                    ),
                  ),
                  ],
                ),
              ),
            ),
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
                setState(() {
                  _selectedAmount = amount;
                  _amountController.text = amount.toString();
                });
                _validateForm();
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
                              ? const Color(0xFF0D47A1).withOpacity(0.1)
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
    controller: _amountController,
    textAlign: TextAlign.center,
    keyboardType: TextInputType.number,
    onChanged: (value) {
      final parsed = int.tryParse(value) ?? 0;
      setState(() {
        _selectedAmount = parsed;
      });
      _validateForm();
    },
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
  onPressed: _isFormValid
      ? () {
          _showAirtimeConfirmation(
            context,
            _selectedAmount.toDouble(),
            _phoneController.text,
          );
        }
      : null,
  style: ElevatedButton.styleFrom(
    backgroundColor:
        _isFormValid ? _kAccentBlue : Colors.grey.shade300,
    elevation: 0,
    foregroundColor:
        _isFormValid ? Colors.white : Colors.black45,
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
                          Icon(Icons.phone_android, color: Color(0xFF0D47A1)),
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



Future<void> _showEnterPinPopup(BuildContext context) async {
  final List<String> pin = ['', '', '', ''];
  bool showError = false;
  bool useFaceId = false;


  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          void onKeyPressed(String value) {
            setModalState(() {
              final index = pin.indexOf('');
              if (index != -1) pin[index] = value;

              if (!pin.contains('')) {
                Future.delayed(const Duration(milliseconds: 250), () {
                  if (pin.join() == '1111') {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AirtimeSuccessPage()),
);

                  } else {
                    setModalState(() {
                      showError = true;
                      pin.fillRange(0, 4, '');
                    });
                  }
                });
              }
            });
          }

          void onDelete() {
            setModalState(() {
              for (int i = 3; i >= 0; i--) {
                if (pin[i].isNotEmpty) {
                  pin[i] = '';
                  break;
                }
              }
            });
          }

          Widget buildPinBox(int i) {
            final filled = pin[i].isNotEmpty;
            return Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: showError
                      ? Colors.red
                      : (filled ? const Color(0xFF0D47A1) : Colors.grey.shade300),
                  width: 1.5,
                ),
              ),
              child: filled
                  ? const Icon(Icons.circle, size: 12, color: Colors.black87)
                  : const SizedBox(),
            );
          }

          Widget buildKey(String label, {IconData? icon}) {
            return InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: () =>
                  icon == Icons.backspace_outlined ? onDelete() : onKeyPressed(label),
              child: Center(
                child: icon == null
                    ? Text(label,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600))
                    : Icon(icon, size: 24, color: Colors.black54),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 22,
              right: 22,
              top: 18,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter Payment PIN',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                const Text('Confirm your transaction',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, buildPinBox),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot Payment PIN?',
                    style: TextStyle(color: Color(0xFF0D47A1), fontSize: 13),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Use Face ID next time',
                        style: TextStyle(fontSize: 13)),
                    Switch(
                      value: useFaceId,
                      onChanged: (v) => setModalState(() => useFaceId = v),
                      activeColor: const Color(0xFF0D47A1),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: 1.4,
                  children: [
                    ...List.generate(9, (i) => buildKey('${i + 1}')),
                    const SizedBox(),
                    buildKey('0'),
                    buildKey('', icon: Icons.backspace_outlined),
                  ],
                ),
                const SizedBox(height: 18),
              ],
            ),
          );
        },
      );
    },
  );
}
