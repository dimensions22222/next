// lib/airtime_flow/airtime_success_page.dart
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:next/main%20pages/dashboard_page.dart';
import 'package:share_plus/share_plus.dart';

import 'Electricitytransactpage.dart';

class ElectricitySuccesspage extends StatefulWidget {
  const ElectricitySuccesspage({
    Key? key,
    required this.plan,
    required this.provider,
    required this.amount,
  }) : super(key: key);
  final String plan;
  final String provider;
  final String amount;

  @override
  State<ElectricitySuccesspage> createState() => _ElectricitySuccesspageState();
}

class _ElectricitySuccesspageState extends State<ElectricitySuccesspage> {
  late final ConfettiController _confettiController;

  // Fixed accents to always match the Figma regardless of app theme
  static const Color _accentBlue = Color(0xFF0D47A1);
  static const Color _rewardGold = Color(0xFFFFC107);
  static const Color _successGreen = Color(0xFF4CAF50);
  static const Color _darkText = Color(0xFF222222);
  static const Color _secondaryText = Color(0xFF707070);

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 2400));
    // play once on load
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _confettiController.play());
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  double _scaleForWidth(double width) {
    // base layout measured for ~400 logical width; scale smaller/larger
    if (width <= 340) return 0.86;
    if (width <= 375) return 0.92;
    if (width <= 420) return 0.98;
    if (width <= 520) return 1.06;
    return 1.12;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardPage(),
              ),
            ),
            child: Text(
              'Done',
              style: theme.textTheme.labelLarge?.copyWith(
                color: _accentBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final scale = _scaleForWidth(width);
          final contentPadding = (22.0 * scale).clamp(14.0, 30.0);
          final iconContainerSize = (110.0 * scale).clamp(76.0, 140.0);
          final iconSize = (100.0 * scale).clamp(46.0, 92.0);
          final headerFont = theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: (18.5 * scale).clamp(14.0, 22.0),
            color: _darkText,
          );
          theme.textTheme.bodyMedium?.copyWith(
            fontSize: (14.0 * scale).clamp(12.0, 16.0),
            color: _secondaryText,
            height: 1.4,
          );

          return Stack(
            children: [
              // Confetti aligned top center
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  emissionFrequency: 0.04,
                  numberOfParticles: 12,
                  maxBlastForce: 18,
                  minBlastForce: 6,
                  gravity: 0.25,
                  colors: const [
                    _accentBlue,
                    _successGreen,
                    _rewardGold,
                    Color(0xFFFF5722)
                  ],
                ),
              ),

              // Main scrollable content
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: contentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 28.0 * scale),

                    // Success icon circle & check
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: iconContainerSize,
                            height: iconContainerSize,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Icon(
                            Icons.verified_rounded,
                            color: _accentBlue,
                            size: iconSize,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 22.0 * scale),

                    // Title
                    Text(
                      'Successful',
                      style: headerFont,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 10.0 * scale),

                    // 🔹 Token Section
                    SizedBox(height: 16.0 * scale),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: (14.0 * scale).clamp(10.0, 20.0),
                        vertical: (12.0 * scale).clamp(8.0, 14.0),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F8FB),
                        borderRadius: BorderRadius.circular(
                            (12.0 * scale).clamp(8.0, 14.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Token ',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: (14.0 * scale).clamp(12.0, 16.0),
                                  color: _darkText,
                                ),
                              ),
                              SizedBox(width: 15.0 * scale),
                              Text(
                                '6497-7401-0380-4494',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: (14.0 * scale).clamp(12.0, 16.0),
                                  color: _darkText,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Copy icon inside circle
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 3,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.copy_rounded,
                                      color: Colors.black87),
                                  iconSize: (18.0 * scale).clamp(14.0, 20.0),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('ID copied to clipboard')),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 13.0 * scale),

                    // Cashback/reward banner y
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all((12.0 * scale).clamp(8.0, 18.0)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E5),
                        borderRadius: BorderRadius.circular(
                            (10.0 * scale).clamp(6.0, 14.0)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.emoji_events_rounded,
                              color: _successGreen,
                              size: (26.0 * scale).clamp(18.0, 30.0)),
                          SizedBox(width: 10.0 * scale),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Congratulations! You earned ₦80.00 cashback on airtime recharge',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: (14.0 * scale).clamp(12.0, 16.0),
                                    color: _darkText,
                                  ),
                                ),
                                SizedBox(height: 4.0 * scale),
                                Text(
                                  'See reward >',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: _accentBlue,
                                    fontSize: (13.0 * scale).clamp(11.0, 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 26.0 * scale),

                    // Rewards header
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get your rewards!',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: (16.0 * scale).clamp(13.0, 18.0),
                              color: _darkText,
                            ),
                          ),
                          SizedBox(height: 4.0 * scale),
                          Text(
                            "You're eligible for massive bonus!",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: _secondaryText,
                              fontSize: (13.0 * scale).clamp(11.0, 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.0 * scale),
                    const Divider(height: 1),

                    // Reward rows with dividers (no borders)
                    _buildRewardRow(
                      icon: Icons.card_giftcard_outlined,
                      iconBg: const Color(0xFFF3F6FB),
                      iconColor: _accentBlue,
                      title: 'Claim your rewards',
                      subtitle: 'Grab free coupons & cashback',
                      scale: scale,
                    ),
                    const Divider(height: 1),

                    _buildRewardRow(
                      icon: Icons.percent_outlined,
                      iconBg: const Color(0xFFF3F6FB),
                      iconColor: _accentBlue,
                      title: 'Get daily cashback',
                      subtitle: 'Buy airtime, get up to 2% cash',
                      scale: scale,
                    ),
                    const Divider(height: 1),

                    _buildRewardRow(
                      icon: Icons.people_outline,
                      iconBg: const Color(0xFFF3F6FB),
                      iconColor: _accentBlue,
                      title: 'Earn up to ₦3000',
                      subtitle: 'Invite friends and earn cash',
                      scale: scale,
                    ),
                    const Divider(height: 1),

                    SizedBox(height: 22.0 * scale),

                    // Buttons row
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                           onPressed: () {
  final receiptText = '''
💡 Electricity Purchase Receipt

Provider: ${widget.provider}
Plan: ${widget.plan}
Amount Paid: ₦${widget.amount}
Token: 6497-7401-0380-4494
Units: 4.4 kWh

Thank you for using Next!
  ''';

  Share.share(receiptText, subject: 'Electricity Purchase Receipt');
},

                            icon: Icon(
                              Icons.share_outlined,
                              size: (18.0 * scale).clamp(14.0, 20.0),
                              color: const Color(0xFF0D47A1),
                            ),
                            label: Text(
                              'Share Receipt',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: (14.0 * scale).clamp(12.0, 16.0),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: (14.0 * scale).clamp(10.0, 18.0)),
                              side: const BorderSide(
                                  color: Color(0xFF0D47A1), width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    (30.0 * scale).clamp(20.0, 40.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 14.0 * scale),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const ElectricityTransactPage(
      customerName: "TAIWO AYOOMODARA",
      meterNumber: "12342344004",
      meterType: "Prepaid",
      serviceAddress: "PLOT 222 APO RESETTLEMENT",
      amountPaid: 1000.00,
      transactionNo: "12347890123478909874321",
      transactionDate: "OCT 31, 2025 12:00:32",
      token: "6497-7401-0380-449",
      units: "4.4kWh",
    ),
  ),
);

                            },
                            icon: Icon(
                              Icons.receipt,
                              size: (18.0 * scale).clamp(14.0, 20.0),
                              color: const Color(0xFF0D47A1),
                            ),
                            label: Text(
                              'View Details',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: (14.0 * scale).clamp(12.0, 16.0),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: (14.0 * scale).clamp(10.0, 18.0)),
                              side: const BorderSide(
                                  color: Color(0xFF0D47A1), width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    (30.0 * scale).clamp(20.0, 40.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 28.0 * scale),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRewardRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required double scale,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: (10.0 * scale).clamp(6.0, 14.0)),
      child: Row(
        children: [
          Container(
            width: (40.0 * scale).clamp(30.0, 48.0),
            height: (40.0 * scale).clamp(30.0, 48.0),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius:
                  BorderRadius.circular((12.0 * scale).clamp(8.0, 14.0)),
            ),
            child: Icon(icon,
                color: iconColor, size: (20.0 * scale).clamp(14.0, 22.0)),
          ),
          SizedBox(width: (14.0 * scale).clamp(8.0, 20.0)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: (14.0 * scale).clamp(12.0, 16.0),
                    color: _darkText,
                  ),
                ),
                SizedBox(height: (4.0 * scale).clamp(2.0, 8.0)),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: (12.5 * scale).clamp(10.0, 14.0),
                    color: _secondaryText,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _accentBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: (18), vertical: (10)),
              elevation: 0,
            ),
            child: Text(
              'Go',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: (14.0 * scale).clamp(12.0, 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
