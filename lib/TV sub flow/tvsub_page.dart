// lib/pages/tv_sub_page.dart
// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next/TV%20sub%20flow/TVsub_successpage.dart';
import 'package:next/main%20pages/dashboard_page.dart';
import 'package:next/main%20pages/utils/widgets/custom_button.dart';

class TvSubPage extends StatefulWidget {
  const TvSubPage({Key? key}) : super(key: key);

  @override
  State<TvSubPage> createState() => _TvSubPageState();
}

class _TvSubPageState extends State<TvSubPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _smartCardController = TextEditingController();
  String? selectedPlan;
  bool showGrid = false;
  int selectedTabIndex = 0;
  bool isVerifying = false;
  bool isVerified = false;
  String? errorMessage;

  // NEW DSTV REVIEW FLOW
  double walletBalance = 56000; // mock wallet balance ₦56,000
final ValueNotifier<bool> _shakeSmartcard = ValueNotifier(false);



 
  
  void _showSuccessDialog(String planName) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => TvsubSuccesspage(
        plan: planName,
        provider: selectedProvider, // now always a String
        amount: selectedPlan ?? 'N/A',
      ),
    ),
  );
}


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => showGrid = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black, size: 18),
          onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardPage()),
),
        ),
        title: const Text(
          'TV Subscription',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _headerSection(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _smartCardField(),
                  const SizedBox(height: 18),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: showGrid ? 1 : 0,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 500),
                      offset: showGrid ? Offset.zero : const Offset(0, 0.1),
                      child: _planGrid(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ------------------- HEADER SECTION -------------------
  String selectedProvider = "DSTV";

  Widget _headerSection() {
    return InkWell(
      onTap: _showProviderSelector,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // Circular logo that changes by provider + soft brand glow
Container(
  width: 60,
  height: 60,
  decoration: const BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.white,
  ),
  padding: const EdgeInsets.all(8),
  child: ClipOval(
    child: Image.asset(
      _getProviderLogo(selectedProvider),
      fit: BoxFit.contain,
    ),
  ),
),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedProvider,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Share the joy this season with DSTV - your home of drama series and football',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getProviderLogo(String? provider) {
  switch (provider) {
    case "GOtv":
      return "assets/images/gotv.png";
    case "StarTimes":
      return "assets/images/startimes.png";
    case "StarTimes ON":
      return "assets/images/startimes on.png";
    case "Showmax":
      return "assets/images/showmax.png";
    default:
      return "assets/images/DStv.jpg"; //  DSTV logo
  }
}


final Map<String, Map<String, dynamic>> providerBrand = {
  "DSTV": {
    "logo": "assets/images/dstv.png",
    "color": const Color(0xFF012169),
  },
  "GOtv": {
    "logo": "assets/images/gotv.png",
    "color": const Color(0xFF009739),
  },
  "StarTimes": {
    "logo": "assets/images/startimes.png",
    "color": const Color(0xFFFF6F00),
  },
  "StarTimes ON": {
    "logo": "assets/images/startimes on.png",
    "color": const Color(0xFF1B4EA3),
  },
  "Showmax": {
    "logo": "assets/images/showmax.png",
    "color": const Color(0xFF000000),
  },
};

 void _showProviderSelector() {
  String? tempSelection = selectedProvider;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        contentPadding: const EdgeInsets.all(20),
        content: StatefulBuilder(
          builder: (context, setStateDialog) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---- Header ----
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Provider',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child:
                          const Icon(Icons.close, size: 22, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // ---- Provider Grid ----
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildProviderOption(
                      context,
                      "StarTimes",
                      "assets/images/startimes.png",
                      tempSelection,
                      (v) => setStateDialog(() => tempSelection = v),
                      const Color.fromARGB(255, 246, 208, 179),
                    ),
                    _buildProviderOption(
                      context,
                      "GOtv",
                      "assets/images/gotv.png",
                      tempSelection,
                      (v) => setStateDialog(() => tempSelection = v),
                      const Color(0xFFFFB0B0),
                    ),
                    _buildProviderOption(
                      context,
                      "Showmax",
                      "assets/images/showmax.png",
                      tempSelection,
                      (v) => setStateDialog(() => tempSelection = v),
                      const Color.fromARGB(255, 249, 233, 233),
                    ),
                    _buildProviderOption(
                      context,
                      "StarTimes ON",
                      "assets/images/startimes on.png",
                      tempSelection,
                      (v) => setStateDialog(() => tempSelection = v),
                      const Color(0xFFB5CFFD),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ---- Proceed Button ----
                CustomButton(
                  text:'Proceed', 
                  onPressed: () {
                    setState(() =>
                        selectedProvider = tempSelection ?? selectedProvider);
                    Navigator.pop(context);
                  },
                )
              
              ],
            );
          },
        ),
      );
    },
  );
  
}

Widget _buildProviderOption(
  BuildContext context,
  String title,
  String imgPath,
  String? groupValue,
  ValueChanged<String> onChanged,
  Color brandColor,
) {
  final bool isSelected = groupValue == title;

  return GestureDetector(
    onTap: () {
      HapticFeedback.selectionClick();
      onChanged(title);
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: brandColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF0D47A1) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: const Color(0xFF0D47A1).withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Stack(
        children: [
          // --- Animated Blue Radio Indicator ---
          Positioned(
            right: 0,
            top: 0,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 250),
              scale: isSelected ? 1.1 : 0.9,
              curve: Curves.easeOutBack,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isSelected ? 1.0 : 0.5,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0D47A1),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Icon(
                    isSelected ? Icons.check : Icons.circle_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),

          // --- Content (Logo + Name) ---
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: brandColor.withOpacity(0.9),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? const Color(0xFF0D47A1) : Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}



  // ------------------- SMART CARD INPUT -------------------
  Widget _smartCardField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Smart card number',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Beneficiaries',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 1),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.black54,
                  ),
                ],
              ),
            ],
          ),
        ),
        TextField(
          controller: _smartCardController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter your smart card number',
            hintStyle: const TextStyle(fontSize: 13.5, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF0D47A1), width: 1.5),
            ),
          ),
          onChanged: (value) {
            setState(() {
              isVerifying = true;
              errorMessage = null;
              isVerified = false;
            });

            Future.delayed(const Duration(seconds: 2), () {
              if (!mounted) return;

              final cleanedValue = value.replaceAll(RegExp(r'\D'), ''); // keep only digits
              final isValid = RegExp(r'^\d{10,12}$').hasMatch(cleanedValue);

              setState(() {
                isVerifying = false;
                if (isValid) {
                  isVerified = true;
                  errorMessage = null;
                } else {
                  isVerified = false;
                  errorMessage = "Please enter the correct smart card number";
                }
              });
            });
          },
        ),
        const SizedBox(height: 6),
        if (isVerifying)
          const Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 6),
              Text(
                'Verifying account details',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        else if (errorMessage != null)
          Text(
            errorMessage!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 13,
            ),
          ),
        const SizedBox(height: 20),
        _tabBarSection(),
      ],
    );
  }

  Widget _tabBarSection() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedTabIndex == 0
                        ? const Color(0xFF0D47A1)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Hot offers',
                  style: TextStyle(
                    color: selectedTabIndex == 0
                        ? const Color(0xFF0D47A1)
                        : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTabIndex = 1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedTabIndex == 1
                        ? const Color(0xFF0D47A1)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Premium',
                  style: TextStyle(
                    color: selectedTabIndex == 1
                        ? const Color(0xFF0D47A1)
                        : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------- PLANS GRID -------------------
  Widget _planGrid() {
    final hotOffers = [
      {'name': 'DSTV Padi', 'price': '₦4400'},
      {'name': 'DSTV Yanga', 'price': '₦6000'},
      {'name': 'DSTV Confam', 'price': '₦11000'},
      {'name': 'DSTV Compact', 'price': '₦19000'},
      {'name': 'DSTV Compact plus', 'price': '₦30000'},
      {'name': 'DSTV Stream Premium', 'price': '₦44500'},
    ];

    final premiumPlans = [
      {'name': 'DSTV Premium', 'price': '₦44500'},
      {'name': 'DSTV Compact Plus', 'price': '₦30000'},
      {'name': 'DSTV Compact', 'price': '₦19000'},
    ];

    final plans = selectedTabIndex == 0 ? hotOffers : premiumPlans;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Container(
            width: 400,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DSTV Renewal',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 19),
                Row(
                  children: [
                    Text(
                      'Enter Amount',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(width: 8),
                     Icon(Icons.arrow_forward_ios,size: 12,)
                  ],
                ),
               
              ],
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: plans.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.4,
          ),
          itemBuilder: (context, index) {
            final plan = plans[index];
            final isSelected = selectedPlan == plan['name'];
            return GestureDetector(
              onTap: () {
                setState(() => selectedPlan = plan['name']);
                _showReviewDialog(plan['name']!, plan['price']!);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF0D47A1) : Colors.grey.shade200,
                    width: isSelected ? 1.6 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
  padding: const EdgeInsets.only(left: 20), 
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, 
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        plan['name']!,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.yellowAccent.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          '1 month',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Colors.orange,
          ),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        plan['price']!,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  ),
),


              ),
            );
          },
        ),
        const SizedBox(height: 15),
_cashbackBannerSection(),

      ],
    );

    
  }
  Widget _cashbackBannerSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        // ---------------- Blue Cashback Banner ----------------
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
              // Faint coin image (transparent background)
              Positioned(
                left: 10,
                top: 10,
                child: Opacity(
                  opacity: 0.25,
                  child: Image.asset(
                    'assets/images/coin.png',
                    width: 45,
                    height: 45,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Players image on the right bottom
              Positioned(
                right: 0,
                bottom: 30,
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                      'Top up ₦1,000 for betting and get up                                       to ₦100 cash back',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color.fromARGB(255, 3, 31, 72),
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

        const SizedBox(height: 19),

        // ---------------- Bet9ja Promo Section ----------------
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal:1, vertical: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
            color: Colors.white30,
            width: 1, //  border thickness
    ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),

              // Circular promo image
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/promo1.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.black12, width: 1),
                ),
              ),

              const SizedBox(width: 12),

              // Text
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sweet deal!',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Top up your account and get 100% bonus back',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    ),
  );
}


  // NEW DSTV REVIEW FLOW
  // ==================== REPLACE ONLY THIS FUNCTION ====================
void _showReviewDialog(String planName, String price) {
  final smartCard = _smartCardController.text.isNotEmpty
      ? _smartCardController.text
      : "8201990000";
  final amount = price;
  const userName = "TAIWO AYOOMODARA";

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---- Header ----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Review",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ---- Smart Card Field ----
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Smart card number",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    Text(
                      smartCard,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ---- Name Field ----
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    Text(
                      "TAIWO AYOOMODARA",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ---- Package Field ----
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Current Package",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    Flexible(
                      child: Text(
                        "$planName $amount.00",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ---- Proceed Button ----
              ValueListenableBuilder<bool>(
  valueListenable: ValueNotifier(isVerified),
  builder: (context, verified, _) {
    return  CustomButton(
      text:'Proceed',
      onPressed: verified
          ? () {
              Navigator.pop(context);
              _showConfirmPayment(
                planName,
                int.parse(amount.replaceAll(RegExp(r'[^0-9]'), '')),
              );
            }
          : () {
              // Trigger shake + SnackBar
              _shakeSmartcard.value = true;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Please verify your smartcard number before proceeding.',
                  ),
                  backgroundColor: Colors.black,
                ),
              );
            },
      );
  },
),

            ],
          ),
        ),
      );
    },
  );
}


  // NEW DSTV REVIEW FLOW — confirm payment sheet
  void _showConfirmPayment(String planName, int amount) {
  final hasEnoughBalance = walletBalance >= amount;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Text(
                "₦${amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Product info
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 // --- Provider info with logo + name ---
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
      "Product",
      style: TextStyle(fontSize: 13, color: Colors.black54),
    ),
    Row(
      children: [
        // Circular logo
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(_getProviderLogo(selectedProvider)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          selectedProvider,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    ),
  ],
),

                  _reviewRow("Account Number", "2081223344"),
                  _reviewRow("Account Name", "TAIWO AYOOMODARA"),
                  _reviewRow("Amount", amount.toStringAsFixed(2)),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cashback(₦3.50)",
                        style: TextStyle(
                            fontSize: 13, color: Colors.black54, height: 1.3),
                      ),
                      Text(
                        "-₦3.50 Cashback",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Payment method title
            const Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Payment Method Box
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade50,
                border: Border.all(
                  color: hasEnoughBalance
                      ? Colors.grey.shade300
                      : const Color(0xFFFFCDD2),
                  width: 1.2,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Available Balance (₦${walletBalance.toStringAsFixed(2)})",
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: hasEnoughBalance
                                ? Colors.black87
                                : Colors.red.shade700,
                          ),
                        ),
                        if (hasEnoughBalance)
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 18),
                      ],
                    ),
                    if (!hasEnoughBalance) ...[
                      const SizedBox(height: 4),
                      const Text(
                        "Insufficient available balance",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Wallet (₦${walletBalance.toStringAsFixed(2)})",
                          style: const TextStyle(
                              fontSize: 13.5, color: Colors.black87),
                        ),
                        Text(
                          "-₦${amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 26),

            // Confirm button
             CustomButton(
              text: "Confirm",
                  onPressed: () {
                  Navigator.pop(context);
                  if (hasEnoughBalance) {
                    setState(() => walletBalance -= amount);
                    _showSuccessDialog(planName);
                  } else {
                    _showInsufficientDialog();
                  }
                },
             ),
               const SizedBox(height: 14),
          ],
        ),
      );
    },
  );
}

// Helper widget for neat label-value rows
Widget _reviewRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}


  // NEW DSTV REVIEW FLOW — success
  

  // NEW DSTV REVIEW FLOW — insufficient funds
  void _showInsufficientDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Insufficient Balance'),
        content: const Text(
          'Your wallet balance is too low to complete this payment. Please fund your wallet and try again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }


  
}
