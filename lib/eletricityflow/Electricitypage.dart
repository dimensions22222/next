// lib/pages/electricity_page.dart
// ignore_for_file: deprecated_member_use, file_names, use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next/main%20pages/dashboard_page.dart'; // adjust if your path differs

class ElectricityPage extends StatefulWidget {
  const ElectricityPage({Key? key}) : super(key: key);

  @override
  State<ElectricityPage> createState() => _ElectricityPageState();
}

class _ElectricityPageState extends State<ElectricityPage> {
  // ---- Controllers & state ----
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _customAmountController = TextEditingController();

  String selectedProvider = 'Abuja Electricity';
  bool isPrepaid = true;
  bool isVerifying = false;
  bool isAccountValid = false;
  String? accountName; // filled on "verification"
  String? verificationError;
  int? selectedAmount; // in Naira (integer)
  double walletBalance = 56000.0; // mocked wallet balance
  bool showProviderSelector = false;
  bool showKeyboard = false;

 
    final List<Map<String, String>> providers = [
  {'name': 'Abuja Electric', 'logo': 'assets/images/abuja.png'},
  {'name': 'Ikeja Electric', 'logo': 'assets/images/ikeja.png'},
  {'name': 'Ibadan Electric', 'logo': 'assets/images/ibadan.png'},
  {'name': 'Port Harcourt Electric', 'logo': 'assets/images/portharcourt.png'},
  {'name': 'Kaduna Electric', 'logo': 'assets/images/kaduna.png'},
  {'name': 'Kano Electric', 'logo': 'assets/images/kano.png'},
  {'name': 'Jos Electric', 'logo': 'assets/images/jos.png'},
];


  final List<int> quickAmounts = [1000, 2000, 3000, 5000, 10000, 20000];

  @override
  void dispose() {
    _accountController.dispose();
    _customAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardPage()),
          ),
        ),
        centerTitle: true,
        title: const Text('Electricity', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {
              // history button - placeholder
            },
            child: const Text('History', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 10),
          const Row(
            
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 6),
              Text('   service provider', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 10),
          _providerHeader(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              _typeToggle(),
              const SizedBox(height: 12),
              _accountField(),
              const SizedBox(height: 12),
              _amountSection(),
              const SizedBox(height: 12),
              _enterAmountField(),
              const SizedBox(height: 10),
            
              const SizedBox(height: 18),
              _moreEvents(),
              const SizedBox(height: 24),
            ]),
          ),
        ]),
      ),
    );
  }
// CUSTOM WIDGETS BELOW---------------------------------------------
  Widget _providerHeader() {
    final providerLogo = providers.firstWhere((p) => p['name'] == selectedProvider, orElse: () => providers[0])['logo']!;
    return InkWell(
      onTap: _openProviderSelector,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: 
        Row(children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))
            ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(providerLogo, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(selectedProvider, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ]),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ]),
      ),
    );
  }

  Widget _typeToggle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Type',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => isPrepaid = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isPrepaid ? const Color(0xFFEEF4FF) : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    border: Border.all(
                      color: isPrepaid ? const Color(0xFF0D47A1) : Colors.transparent,
                      width: 1.3,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prepaid',
                          style: TextStyle(
                            color: isPrepaid ? const Color(0xFF0D47A1) : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.verified_user_outlined, size: 20, color: Color(0xFF0D47A1)),
                       ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => isPrepaid = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: !isPrepaid ? const Color(0xFFEEF4FF) : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(
                      color: !isPrepaid ? const Color(0xFF0D47A1) : Colors.transparent,
                      width: 1.3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Postpaid',
                      style: TextStyle(
                        color: !isPrepaid ? const Color(0xFF0D47A1) : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _accountField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Meter / Account Number',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.5,
            ),
          ),
          Row(
            children: [
              Text(
                'Beneficiaries',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              SizedBox(width: 6),
              Icon(Icons.arrow_forward_ios, size: 13, color: Colors.black54),
            ],
          ),
        ],
      ),
      const SizedBox(height: 8),

      // Compound TextField + Animated Proceed button
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            // Text input area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12 ,bottom: 2,top:2),
                child: TextField(
                  controller: _accountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: '1234-2344-004',
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    suffixIcon: _accountController.text.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _accountController.clear();
                                  accountName = null;
                                  isAccountValid = false;
                                });
                              },
                              child: const Icon(
                                Icons.cancel_outlined,
                                size: 25,
                                color: Colors.black45,
                              ),
                            ),
                          )
                        : null,
                  ),
                  onChanged: (v) {
                    setState(() {
                      isVerifying = true;
                      verificationError = null;
                      accountName = null;
                      isAccountValid = false;
                    });

                    Future.delayed(const Duration(milliseconds: 900), () {
                      if (!mounted) return;
                      final cleaned = v.trim();
                      final valid = cleaned.length >= 8 && cleaned.length <= 12;
                      setState(() {
                        isVerifying = false;
                        if (valid) {
                          isAccountValid = true;
                          accountName = 'TAIWO AYOOMODARA';
                        } else {
                          isAccountValid = false;
                          accountName = null;
                        }
                      });
                    });
                  },
                ),
              ),
            ),

            // Animated Proceed button 
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0.4, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      // here’s the “easeOutBack” bounce effect 🎯
                      curve: const Cubic(0.175, 0.885, 0.32, 1.275),
                    ),
                  );
                  return SlideTransition(position: offsetAnimation, child: child);
                },
                child: isAccountValid
                    ? ElevatedButton(
                        key: const ValueKey('proceed'),
                        onPressed: () {
                          setState(() {
                            isVerifying = true;
                            verificationError = null;
                          });
                          Future.delayed(const Duration(milliseconds: 900), () {
                            if (!mounted) return;
                            setState(() {
                              isVerifying = false;
                              isAccountValid = true;
                              accountName = 'TAIWO AYOOMODARA';
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          elevation: 0,
                          minimumSize: const Size(85, 42),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                        ),
                        child: const Text(
                          'Proceed',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.5,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 10),

      if (isVerifying)
        const Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child:
                  CircularProgressIndicator(strokeWidth: 2, color: Colors.green),
            ),
            SizedBox(width: 8),
            Text('Verifying account details',
                style: TextStyle(color: Colors.green)),
          ],
        )
      else if (accountName != null)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF5FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.blue, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    accountName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Min Purchase',
                      style: TextStyle(fontSize: 13, color: Colors.black54)),
                  Text('900.00',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service Address',
                      style: TextStyle(fontSize: 13, color: Colors.black54)),
                  Text('PLOT****',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        )
      else if (verificationError != null)
        Text(
          verificationError!,
          style: const TextStyle(color: Colors.red),
        ),
    ],
  );
}



Widget _amountSection() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Align(
        alignment: Alignment.centerLeft,
        child: Text('Select Amount',
            style: TextStyle(fontWeight: FontWeight.w600))),
    const SizedBox(height: 10),
    ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(6),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quickAmounts.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.25),
            itemBuilder: (context, idx) {
              final amount = quickAmounts[idx];
              final selected = selectedAmount == amount;
              return GestureDetector(
                onTap: () {
  setState(() {
    selectedAmount = amount;
    _customAmountController.clear();
  });
  // ⬇ Always open confirm popup
  if (isAccountValid) {
    _showReviewModal();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please verify account first.')),
    );
  }
},

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF0D47A1)
                        : Colors.blue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: selected
                            ? const Color(0xFF0D47A1)
                            : Colors.grey.shade200,
                        width: selected ? 1.6 : 1),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6)
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('₦$amount',
                            style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text('Pay ₦$amount',
                            style: TextStyle(
                                color: selected
                                    ? Colors.white.withOpacity(0.9)
                                    : Colors.black54,
                                fontSize: 12)),
                      ]),
                ),
              );
            },
          ),
        ),
      ),
    ),
  ]);
}

Widget _enterAmountField() {
  final isPayEnabled = isAccountValid &&
      _customAmountController.text.isNotEmpty &&
      int.tryParse(_customAmountController.text.replaceAll(',', '')) != null &&
      int.parse(_customAmountController.text.replaceAll(',', '')) > 0;

  return TextField(
    controller: _customAmountController,
    keyboardType: TextInputType.number,
    
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    decoration: InputDecoration(
      hintText: 'Enter Amount',
      filled: true,
      fillColor: Colors.white,
     
      contentPadding: const EdgeInsets.symmetric(horizontal: 9, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF0D47A1), width: 1),
      ),
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 30,right: 0, top: 10, bottom: 5),
        child: Text(
          '₦',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 6,top:5,bottom:5 ),
              child: ElevatedButton(
          onPressed: () {
            final parsed = int.tryParse(
                _customAmountController.text.replaceAll(',', ''));
            if (parsed != null && parsed > 0 && isAccountValid) {
              setState(() => selectedAmount = parsed);
              _showReviewModal(); // works even when re-enabled
            }
          },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPayEnabled
                       
                       ?const Color(0xFF0D47A1)
                      : const Color.fromARGB(255, 13, 71, 161).withOpacity(0.5),
                  elevation: 0,
                  minimumSize: const Size(85, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                child: Text(
            'Pay',
            style: TextStyle(
              color: isPayEnabled ? Colors.white : Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
              ),
            ),
    ),
    onChanged: (_) => setState(() {}),
  );
}

  Widget _moreEvents() {
    return Column(children: [
      // promo card
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)]),
        child: Row(children: [
          Container(width: 48, height: 48, decoration: const BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage('assets/images/promo1.png'), fit: BoxFit.cover)),),
          const SizedBox(width: 12),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [Text('Sweet deal!',
            style: TextStyle(
              fontWeight: FontWeight.w700)),
               SizedBox(height: 4),
                Text('Top up your account and get 100% bonus back',
                 style: TextStyle(fontSize: 12.5))])),
        ]),
      ),
      const SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)]),
        child: Row(children: [
          Container(width: 48,
           height: 48,
            decoration: 
            const BoxDecoration(
              shape: BoxShape.circle, 
              image: DecorationImage(
                image: AssetImage('assets/images/promo2.png'), fit: BoxFit.cover)),),
          const SizedBox(width: 12),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [Text('Up to 30GB FREE Data',
            style: TextStyle(
              fontWeight: FontWeight.w700)),
               SizedBox(height: 4),
                Text('Join BANGBET, Deposit & Claim Instantly',
                 style: TextStyle(fontSize: 12.5))])),
        ]),
      ),
      const SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)]),
        child: Row(children: [
          Container(width: 48,
           height: 48,
            decoration: 
            const BoxDecoration(
              shape: BoxShape.circle, 
              image: DecorationImage(
                image: AssetImage('assets/images/promo2.png'), fit: BoxFit.cover)),),
          const SizedBox(width: 12),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [Text('Up to 30GB FREE Data',
            style: TextStyle(
              fontWeight: FontWeight.w700)),
               SizedBox(height: 4),
                Text('Join BANGBET, Deposit & Claim Instantly',
                 style: TextStyle(fontSize: 12.5))])),
        ]),
      ),
    ]);
  }

  // ---------- Provider selector dialog ----------
 void _openProviderSelector() {
  // Capture current provider name for reference
  final String currentMain = selectedProvider;

  showDialog(
    context: context,
    builder: (dialogContext) {
      String? tempSelected;

      return StatefulBuilder(
        builder: (context, setDialogState) {
          // Filter out the selected provider
          final List<Map<String, String>> availableProviders =
              providers.where((p) => p['name'] != currentMain).toList();

          // Keep exactly 6 visible tiles (if possible)
          final List<Map<String, String>> displayProviders =
              availableProviders.length > 6
                  ? availableProviders.sublist(0, 6)
                  : availableProviders;

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            contentPadding: const EdgeInsets.all(18),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select Provider",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(dialogContext),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

               SizedBox(
  height: MediaQuery.of(context).size.height * 0.5, // limits dialog height
  child: SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Center(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: List.generate(displayProviders.length, (index) {
          final provider = displayProviders[index];
          final name = provider['name']!;
          final logo = provider['logo']!;
          final isSelected = name == tempSelected;

          return GestureDetector(
            onTap: () {
              setDialogState(() {
                tempSelected = name;
              });
            },
            child: Container(
              width: 120,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade300,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: [
            Colors.blue.shade50,
            Colors.green.shade50,
            Colors.orange.shade50,
            Colors.purple.shade50,
            Colors.red.shade50,
            Colors.teal.shade50,
            Colors.amber.shade50,
          ][index % 7],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(logo, fit: BoxFit.contain),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: isSelected
              ? const Color(0xFF0D47A1)
              : Colors.black87,
        ),
      ),
    ],
  ),
),

                  Positioned(
                    right: 8,
                    top: 8,
                    child: Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: isSelected
                          ? const Color(0xFF0D47A1)
                          : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ),
  ),
),
                const SizedBox(height: 22),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: tempSelected == null
                        ? null
                        : () {
                            final newSelection = tempSelected!;
                            Navigator.pop(dialogContext);

                            Future.delayed(const Duration(milliseconds: 100), () {
                              setState(() {
                                // Swap the selected provider positions
                                final oldIndex = providers.indexWhere(
                                    (p) => p['name'] == currentMain);
                                final newIndex = providers.indexWhere(
                                    (p) => p['name'] == newSelection);

                                if (oldIndex != -1 && newIndex != -1) {
                                  final temp = providers[oldIndex];
                                  providers[oldIndex] = providers[newIndex];
                                  providers[newIndex] = temp;
                                }

                                selectedProvider = newSelection;
                              });
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Proceed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


  // ---------- Review modal (bottom sheet) ----------
  void _showReviewModal() {
    final amount = selectedAmount ?? 0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (context) {
        final hasEnough = walletBalance >= amount;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: 6),
            Container(height: 4, width: 60, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4))),
            const SizedBox(height: 14),
            Text('₦${amount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
               Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Product name',
                          style: TextStyle(color: Colors.black54)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                           child: ClipOval(
                          child: Image.asset(
                            providers.firstWhere(
                              (p) => p['name'] == selectedProvider,
                              orElse: () => providers.first,
                            )['logo']!,
                            fit: BoxFit.cover,
                          ),
                        ),

                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Electricity',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                         ],
                      ),
                    ],
                  ),
                ),
                _labelValueRow('Meter Number', _accountController.text.isNotEmpty ? _accountController.text : 'N/A'),
                _labelValueRow('Account Name', accountName ?? 'N/A'),
                _labelValueRow('Amount', '₦${amount.toStringAsFixed(2)}'),
                const SizedBox(height: 6),
                const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Cashback(₦3.50)', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  Text('-₦3.50 Cashback', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ]),
              ]),
            ),
            const SizedBox(height: 16),
            const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(' Payment Method',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(height: 4),
                    Text('Wallet',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 20),

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
                      const Text('Available Balance (₦56,000.00)',
                          style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Wallet (₦56,000.00)',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54)),
                          Text('-₦${amount.toStringAsFixed(2)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
              ]),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close sheet
                  if (hasEnough) {
                    _showPinEntry(amount);
                  } else {
                    _showInsufficient();
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                child: const Text('Confirm',
                 style: TextStyle(
                  fontSize: 16,
                   fontWeight: FontWeight.w600,
                    color: Colors.white,
                   )),
              ),
            ),
            const SizedBox(height: 10),
          ]),
        );
      },
    );
  }

  Widget _labelValueRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
        Flexible(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w600))),
      ]),
    );
  }

  void _showInsufficient() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('Insufficient Balance'),
        content: const Text('Your wallet balance is too low to complete this payment. Please fund your wallet and try again.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }

  // ---------- PIN entry modal ----------
  void _showPinEntry(int amount) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      String entered = '';

      return StatefulBuilder(builder: (context, setState) {
        void pushDigit(String d) {
          if (entered.length >= 4) return;
          entered += d;
          setState(() {});
          if (entered.length == 4) {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (entered == '1234') {
                if (walletBalance >= amount) {
                  setState(() => walletBalance -= amount);
                  Navigator.pop(context);
                  _showSuccess(amount);
                } else {
                  Navigator.pop(context);
                  _showInsufficient();
                }
              } else {
                entered = '';
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Incorrect PIN. Try 1234 for demo.')),
                );
              }
            });
          }
        }

        void removeLast() {
          if (entered.isNotEmpty) {
            entered = entered.substring(0, entered.length - 1);
            setState(() {});
          }
        }

        Widget buildKey(String number, [String? letters]) {
          if (number.trim().isEmpty) return const SizedBox(width: 100, height: 70);
          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              if (number == '<') {
                removeLast();
              } else {
                pushDigit(number);
              }
            },
            child: Container(
              width: 100,
              height: 70,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: number == '<'
                    ? const Icon(Icons.backspace_outlined, size: 24)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            number,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (letters != null)
                            Text(
                              letters,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                letterSpacing: 1,
                              ),
                            ),
                        ],
                      ),
              ),
            ),
          );
        }

        return FractionallySizedBox(
          heightFactor: 0.75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const Text(
                'Enter Payment PIN',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 20),

              // PIN Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  bool filled = index < entered.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                    ),
                    child: Center(
                      child: filled
                          ? const Icon(Icons.circle, size: 12, color: Colors.black)
                          : const SizedBox.shrink(),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showForgotPin();
                },
                child: const Text(
                  'Forgot Payment PIN?',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Keypad
              Expanded(
                child: Container(
                  color: const Color(0xFFF3F4F6),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildKey('1'),
                          buildKey('2', 'ABC'),
                          buildKey('3', 'DEF'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildKey('4', 'GHI'),
                          buildKey('5', 'JKL'),
                          buildKey('6', 'MNO'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildKey('7', 'PQRS'),
                          buildKey('8', 'TUV'),
                          buildKey('9', 'WXYZ'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 100, height: 70),
                          buildKey('0'),
                          buildKey('<'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
    },
  );
}


  void _showForgotPin() {
    showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Forgot PIN'), content: const Text('PIN reset flow is not implemented in this demo.'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))]));
  }

  void _showSuccess(int amount) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.check_circle, size: 56, color: Colors.green),
          const SizedBox(height: 8),
          const Text('Payment Successful', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('₦${amount.toStringAsFixed(2)} paid to $selectedProvider'),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // navigate back to dashboard or any success page
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              child: const Text('Done'),
            ),
          )
        ]),
      ),
    );
  }
}
