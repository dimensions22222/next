// lib/data_flow/data_sub_page.dart
// ignore_for_file: file_names, deprecated_member_use, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
// reuse existing success page
import 'package:next/dataflow/Datasuccesspage.dart';
import 'package:next/main%20pages/dashboard_page.dart';

const Color _kAccentBlue = Color(0xFF0D47A1);

class DataSubPage extends StatefulWidget {
  const DataSubPage({Key? key}) : super(key: key);

  @override
  State<DataSubPage> createState() => _DataSubPageState();
}

class _DataSubPageState extends State<DataSubPage> with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController(text: '08133228899');
  final FocusNode _phoneFocus = FocusNode();
  final TextEditingController _customAmountController = TextEditingController();

  String _selectedNetwork = 'MTN';

  // tabs like Figma: HOT, Daily, Weekly, Monthly, XtraValue, Broadband
  final List<String> _tabs = ['HOT', 'Daily', 'Weekly', 'Monthly', 'XtraValue', 'Broadband'];
  int _activeTabIndex = 0;

  // sample data plans per tab (in a real app this would come from API)
    // Force grid to 3x3 layout
  // Builds responsive grid column count from width
int _gridCountForWidth(double width) {
  return 3; // fixed to 3 columns always
}


  // sample data plans per tab (now all have 9 entries to fill 3x3 grid)
  final Map<String, List<Map<String, dynamic>>> _plans = {
  'HOT': [
    {'size': '1GB', 'duration': '1 Day', 'price': 50, 'cashback': '₦1'},
    {'size': '2.5GB', 'duration': '1 Day', 'price': 100, 'cashback': '₦2'},
    {'size': '500MB', 'duration': '7 Days', 'price': 150, 'cashback': '₦3'},
    {'size': '3.5GB', 'duration': '30 Days', 'price': 2500, 'cashback': '₦50'},
    {'size': '5GB', 'duration': '14 Days', 'price': 1200, 'cashback': '₦10'},
    {'size': '10GB', 'duration': '30 Days', 'price': 3000, 'cashback': '₦30'},
  ],
  'Daily': [
    {'size': '100MB', 'duration': '1 Day', 'price': 25, 'cashback': '₦0'},
    {'size': '200MB', 'duration': '1 Day', 'price': 50, 'cashback': '₦1'},
    {'size': '500MB', 'duration': '1 Day', 'price': 100, 'cashback': '₦2'},
    {'size': '1GB', 'duration': '1 Day', 'price': 200, 'cashback': '₦3'},
    {'size': '1.5GB', 'duration': '1 Day', 'price': 250, 'cashback': '₦4'},
    {'size': '2GB', 'duration': '1 Day', 'price': 300, 'cashback': '₦5'},
  ],
  'Weekly': [
    {'size': '1.5GB', 'duration': '7 Days', 'price': 400, 'cashback': '₦5'},
    {'size': '2.5GB', 'duration': '7 Days', 'price': 700, 'cashback': '₦7'},
    {'size': '3GB', 'duration': '7 Days', 'price': 900, 'cashback': '₦10'},
    {'size': '4GB', 'duration': '7 Days', 'price': 1200, 'cashback': '₦15'},
    {'size': '5GB', 'duration': '7 Days', 'price': 1500, 'cashback': '₦20'},
    {'size': '7GB', 'duration': '7 Days', 'price': 2000, 'cashback': '₦25'},
  ],
  'Monthly': [
    {'size': '1GB', 'duration': '30 Days', 'price': 500, 'cashback': '₦10'},
    {'size': '5GB', 'duration': '30 Days', 'price': 2500, 'cashback': '₦50'},
    {'size': '10GB', 'duration': '30 Days', 'price': 4000, 'cashback': '₦80'},
    {'size': '20GB', 'duration': '30 Days', 'price': 6000, 'cashback': '₦120'},
    {'size': '30GB', 'duration': '30 Days', 'price': 8000, 'cashback': '₦160'},
    {'size': '50GB', 'duration': '30 Days', 'price': 12000, 'cashback': '₦250'},
  ],
  'XtraValue': [
    {'size': '10GB', 'duration': '30 Days', 'price': 3000, 'cashback': '₦30'},
    {'size': '15GB', 'duration': '30 Days', 'price': 4000, 'cashback': '₦40'},
    {'size': '20GB', 'duration': '30 Days', 'price': 5000, 'cashback': '₦50'},
    {'size': '25GB', 'duration': '30 Days', 'price': 6000, 'cashback': '₦60'},
    {'size': '30GB', 'duration': '30 Days', 'price': 7000, 'cashback': '₦70'},
    {'size': '40GB', 'duration': '30 Days', 'price': 8000, 'cashback': '₦80'},
  ],
  'Broadband': [
    {'size': '50GB', 'duration': '30 Days', 'price': 15000, 'cashback': '₦300'},
    {'size': '75GB', 'duration': '60 Days', 'price': 20000, 'cashback': '₦400'},
    {'size': '100GB', 'duration': '60 Days', 'price': 25000, 'cashback': '₦500'},
    {'size': '150GB', 'duration': '90 Days', 'price': 35000, 'cashback': '₦700'},
    {'size': '200GB', 'duration': '90 Days', 'price': 40000, 'cashback': '₦800'},
    {'size': '300GB', 'duration': '120 Days', 'price': 50000, 'cashback': '₦1000'},
  ],
};

  // selection state
  Map<String, dynamic>? _selectedPlan;

  // networks (icons are optional — keep /assets and icons in sync)
  final List<Map<String, String>> _networks = [
    {'name': 'MTN', 'icon': 'assets/images/mtn.png'},
    {'name': 'Airtel', 'icon': 'assets/images/airtel.png'},
    {'name': 'Glo', 'icon': 'assets/images/glo.jpeg'},
    {'name': '9mobile', 'icon': 'assets/images/9Mobile.jpeg'},
  ];

  @override
  void initState() {
    super.initState();
    _validateForm();
  }

  void _validateForm() {
    final phoneValid = _phoneController.text.trim().length >= 10;
    final planSelected = _selectedPlan != null || (_customAmountController.text.trim().isNotEmpty);
    setState(() {
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocus.dispose();
    _customAmountController.dispose();
    super.dispose();
  }


 
  void _onSelectPlan(Map<String, dynamic> plan) {
  setState(() {
    _selectedPlan = plan;
    _customAmountController.clear();
  });
  _validateForm();

  // Show confirmation popup
  _showDataConfirmSheet(context);
}

  Future<void> _showDataConfirmSheet(BuildContext context) async {
  final amount = _selectedPlan != null
      ? _selectedPlan!['price'] as num
      : int.tryParse(_customAmountController.text) ?? 0;
  final planName = _selectedPlan != null
      ? '${_selectedPlan!['size']} • ${_selectedPlan!['duration']}'
      : 'Custom Data';
  if (amount <= 0) return;

  // find selected network icon
  final networkData = _networks.firstWhere(
    (n) => n['name'] == _selectedNetwork,
    orElse: () => {'icon': 'assets/images/mtn.png', 'name': _selectedNetwork},
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final screenHeight = MediaQuery.of(context).size.height;
  
      return SizedBox(
        height: screenHeight * 0.62 , // increased popup height
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '₦ ${amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                // Product name with network image aligned right
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
                                networkData['icon']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Mobile Data',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                         ],
                      ),
                    ],
                  ),
                ),

                _buildConfirmRow('Recipient Mobile',
                    _phoneController.text.trim()),
                _buildConfirmRow(
                  'Data Bundle',
                   planName,valueColor:
                    _kAccentBlue,),
                _buildConfirmRow('Amount', '₦${amount.toStringAsFixed(2)}'),
                const SizedBox(height: 8),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bonus to Earn'),
                    Text('+₦50 Cashback',
                        style: TextStyle(color: Color(0xFF0D47A1))),
                  ],
                ),
                const SizedBox(height: 4),
                _buildConfirmRow('Cashback(₦3.50)', '-₦3.50 Cashback'),
                const SizedBox(height: 20),
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
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await _showEnterPinPopup(context, amount.toString());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kAccentBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

 Widget _buildConfirmRow(String title, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black54),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.black, 
              ),
          ),
        ),
      ],
    ),
  );
}


  Future<void> _showEnterPinPopup(BuildContext context, String amount) async {
    final List<String> pin = ['', '', '', ''];
    bool showError = false;
    bool useFaceId = false;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setModalState) {
          void onKeyPressed(String value) {
            setModalState(() {
              final index = pin.indexOf('');
              if (index != -1) pin[index] = value;

              if (!pin.contains('')) {
                Future.delayed(const Duration(milliseconds: 200), () {
                  if (pin.join() == '1111') {
                   Navigator.pop(ctx); // close the sheet using the sheet’s context
                  Future.delayed(const Duration(milliseconds: 200), () {
                   Navigator.of(ctx, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => DataSuccesspage(
                        amount: amount,
                        phoneNumber: _phoneController.text,
                        provider: _selectedNetwork,
                      ),
                    ),
                  );


                  });

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
                  color: showError ? Colors.red : (filled ? _kAccentBlue : Colors.grey.shade300),
                  width: 1.5,
                ),
              ),
              child: filled ? const Icon(Icons.circle, size: 12, color: Colors.black87) : const SizedBox(),
            );
          }

          Widget buildKey(String label, {IconData? icon}) {
            return InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: () => icon == Icons.backspace_outlined ? onDelete() : onKeyPressed(label),
              child: Center(
                child: icon == null ? Text(label, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)) : Icon(icon, size: 24, color: Colors.black54),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 22, right: 22, top: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 5, width: 40, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20))),
                const SizedBox(height: 16),
                const Text('Enter Payment PIN', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                const Text('Confirm your transaction', style: TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 24),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(4, buildPinBox)),
                const SizedBox(height: 10),
                GestureDetector(onTap: () {}, child: const Text('Forgot Payment PIN?', style: TextStyle(color: Color(0xFF0D47A1), fontSize: 13))),
                const SizedBox(height: 22),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Use Face ID next time', style: TextStyle(fontSize: 13)),
                  Switch(value: useFaceId, onChanged: (v) => setModalState(() => useFaceId = v), activeColor: _kAccentBlue),
                ]),
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
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeTab = _tabs[_activeTabIndex];
    final plans = _plans[activeTab] ?? [];
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Data', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
        }),
        actions: [
          TextButton(onPressed: () {}, child: const Text('History', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600))),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // banner (re-usable header)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(colors: [Color(0xFF4E8EF6), Color(0xFF7CA8FB)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('OUT OF AIRTIME?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 6),
                          Text('Top up anytime, anywhere and enjoy up to 6% cashback', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ]),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/gal.png', width: 96, fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // For (recipient) block
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('For', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(children: [
                      SizedBox(
                        width: 70,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedNetwork,
                            items: _networks.map((n) {
                              return DropdownMenuItem<String>(
                                value: n['name'],
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (n['icon'] != null)
                                      ClipOval(child: Image.asset(n['icon']!, width: 30, height: 30, fit: BoxFit.cover)),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (v) => setState(() {
                              _selectedNetwork = v ?? _selectedNetwork;
                              _validateForm();
                            }),
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
                          ),
                        ),
                      ),
                      Container(width: 1, height: 32, color: Colors.grey.shade300),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(children: [
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              focusNode: _phoneFocus,
                              keyboardType: TextInputType.phone,
                              onChanged: (_) => _validateForm(),
                              decoration: const InputDecoration(border: InputBorder.none, hintText: '08133228899'),
                            ),
                          ),
                          Container(width: 36, height: 36, decoration: const BoxDecoration(color: _kAccentBlue, shape: BoxShape.circle), child: const Icon(Icons.person, color: Colors.white)),
                        ]),
                      ),
                    ]),
                  ),
                ]),
              ),

              const SizedBox(height: 18),

              // Top up section title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Text('Data Plans', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 12),

              // Tabs (scrollable)
              SizedBox(
                height: 40,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: _tabs.length,
                  itemBuilder: (ctx, i) {
                    final active = _activeTabIndex == i;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _activeTabIndex = i;
                        _selectedPlan = null;
                        _customAmountController.clear();
                        _validateForm();
                      }),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: active ? _kAccentBlue : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: active ? _kAccentBlue : Colors.grey.shade300),
                        ),
                        child: Center(child: Text(_tabs[i], style: TextStyle(color: active ? Colors.white : Colors.black87, fontWeight: FontWeight.w600))),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 14),

              // responsive plans grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0 ),
                child: LayoutBuilder(builder: (context, constraints) {
                  final crossAxis = _gridCountForWidth(constraints.maxWidth);
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: plans.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxis,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.05,

                    ),
                    itemBuilder: (ctx, idx) {
                      final plan = plans[idx];
                      final selected = _selectedPlan == plan;
                      return GestureDetector(
                        onTap: () => _onSelectPlan(plan),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: selected ? _kAccentBlue : Colors.grey.shade300, width: selected ? 1.6 : 1),
                            boxShadow: [BoxShadow(color: selected ? _kAccentBlue.withOpacity(0.06) : Colors.grey.shade100, blurRadius: 6, offset: const Offset(0,2))],
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(6)),
                              child: Text('${plan['cashback']} Cashback', style: const TextStyle(fontSize: 11, color: _kAccentBlue, fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(height: 8),
                            Text(plan['size'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(plan['duration'], style: const TextStyle(fontSize: 13, color: Colors.black54)),
                            const SizedBox(height: 8),
                            Text('₦${plan['price']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ]),
                        ),
                      );
                    },
                  );
                }),
              ),

              
              const SizedBox(height: 22),

              // Airtime Service & promos (reuse pattern from airtime)
              Container(
                color: Colors.grey.shade50,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Airtime service', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
                    child: const Row(children: [
                      Icon(Icons.phone_android, color: Color(0xFF0D47A1)),
                      SizedBox(width: 10),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('USSD enquiry', style: TextStyle(fontWeight: FontWeight.w600)), Text('Check phone balance and more', style: TextStyle(fontSize: 13, color: Colors.grey))])),
                      Icon(Icons.chevron_right),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  const Text('More events', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  _promoItem(imageUrl: 'assets/images/promo1.png', title: 'Up to 100% Bonus', subtitle: 'Top up your account and get 100% bonus back'),
                  _promoItem(imageUrl: 'assets/images/promo2.png', title: 'Up to 30GB FREE Data!', subtitle: 'Join & Claim Instantly'),
                ]),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _promoItem({required String imageUrl, required String title, required String subtitle}) {
    final local = !imageUrl.startsWith('http');
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        ClipOval(child: local ? Image.asset(imageUrl, width: 36, height: 36, fit: BoxFit.cover) : Image.network(imageUrl, width: 36, height: 36, fit: BoxFit.cover)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)), const SizedBox(height: 2), Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey))])),
        const Icon(Icons.chevron_right),
      ]),
    );
  }
}
