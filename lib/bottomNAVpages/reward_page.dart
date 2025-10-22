// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // optional: for copy to clipboard if you enable it

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  static const Color primary = Color(0xFF6366F1);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _currentIndex = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ---------------------- CONVERT SHEET ----------------------

  void _showConvertSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        TextEditingController controller = TextEditingController(text: "100");
        double conversionRate = 20.0;
        double amount = 100 * conversionRate;
        bool isButtonEnabled = true; // starts valid because 100 pts is preset

        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
            builder: (context, setState) {
              void updateState(String val) {
                double pts = double.tryParse(val) ?? 0;
                setState(() {
                  amount = pts * conversionRate;
                  isButtonEnabled = pts >= 100;
                });
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.black54),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Convert your points to money",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Enter Points",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textSecondary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Points",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Balance - 400 pts",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: controller,
                              keyboardType: TextInputType.number,
                              onChanged: updateState,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "0",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.info_outline_rounded,
                                    color: Colors.grey[600], size: 16),
                                SizedBox(width: 6),
                                Text(
                                  "1 point = ₦20.00",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.check_circle_rounded,
                                    color: Colors.green, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  "Zero fee",
                                  style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "₦${amount.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isButtonEnabled
                              ? () {
                                  Navigator.pop(context);
                                  _showSuccessSheet();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isButtonEnabled
                                ? primary
                                : Colors.grey.shade300,
                            minimumSize: Size(double.infinity, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Convert now",
                            style: TextStyle(
                              color: isButtonEnabled
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ---------------------- SUCCESS SHEET ----------------------

  void _showSuccessSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black54),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(height: 10),
              CircleAvatar(
                radius: 26,
                backgroundColor: Color(0xFFFFF8E1),
                child: Icon(Icons.monetization_on,
                    color: Colors.amber, size: 36),
              ),
              SizedBox(height: 16),
              Text(
                "Sweet! You just redeemed 100 pts",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Earn more points",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ---------------------- MAIN UI ----------------------

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: Text(
          'Rewards',
          style: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _referCard(),
            const SizedBox(height: 24),
            _rewardBalance(width),
            const SizedBox(height: 20),
            _tabs(),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 350),
              child: IndexedStack(
                key: ValueKey<int>(_currentIndex),
                index: _currentIndex,
                children: [
                  _rewardActivities(),
                  _earningHistory(),
                  _howToEarn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------- REMAINING COMPONENTS ----------------------

  Widget _referCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary.withOpacity(0.12), secondary.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Refer and \n earn points',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: "Code - ",
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 17,
                              ),
                              children: [
                                TextSpan(
                                  text: "49RTXA",
                                  style: TextStyle(
                                    color: Color(0xFF111827),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton.outlined(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: "49RTXA"));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Copied code to clipboard')),
                            );
                          },
                          icon: const Icon(
                            Icons.copy_rounded,
                            size: 18,
                            color: Color.fromARGB(46, 17, 24, 39),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 235, 246, 255),
                            foregroundColor: secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        OutlinedButton.icon(
                          onPressed: () {},
                          label: const Text(
                            "Share",
                            style: TextStyle(
                              color: Color(0xFF111827),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 235, 246, 255),
                            foregroundColor: secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
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
      );

  Widget _rewardBalance(double width) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Reward points balance',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '1 point = ₦30.00',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6FAFA),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.monetization_on,
                          color: Color(0xFFFFB800),
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '330 ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'pts',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: _showConvertSheet,
                  icon: const Icon(Icons.sync_rounded,
                      size: 18, color: Color(0xFF111827)),
                  label: const Text(
                    'Convert',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.7,
                minHeight: 5,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor:
                    const AlwaysStoppedAnimation(Color(0xFF06B6D4)),
              ),
            ),
          ],
        ),
      );

  Widget _tabs() => TabBar(
        controller: _tabController,
        labelColor: primary,
        unselectedLabelColor: Colors.grey,
        indicatorColor: primary,
        labelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Activities'),
          Tab(text: 'History'),
          Tab(text: 'How to Earn'),
        ],
      );

  Widget _rewardActivities() => Column(
        children: const [
          RewardActivityTile('Complete your onboarding with KYC', 15),
          RewardActivityTile('Make bill payments with Texa', 15),
          RewardActivityTile('Refer 5 friends who sign up', 10),
          RewardActivityTile('Daily login and recharge', 20),
        ],
      );

  Widget _earningHistory() => Column(
        children: const [
          RewardHistoryTile('Completed onboarding', '13/12/25 at 7:04am', 15),
          RewardHistoryTile('Paid your 1st bill', '13/12/25 at 7:06am', 15),
          RewardHistoryTile('Referred 7 friends', '13/12/25 at 7:09am', 15),
          RewardHistoryTile(
              'Daily login and recharge', '13/12/25 at 7:10am', 20),
        ],
      );

  Widget _howToEarn() => Column(
        children: const [
          RewardHowToTile('Sign up & stay active',
              'Create an account and verify your KYC'),
          RewardHowToTile('Refer & complete tasks',
              'Invite friends, complete actions to earn more'),
          RewardHowToTile('Redeem & enjoy exclusive perks',
              'Turn points into cash or exclusive offers'),
        ],
      );
}

class RewardActivityTile extends StatelessWidget {
  final String title;
  final int points;
  const RewardActivityTile(this.title, this.points);

  @override
  Widget build(BuildContext context) {
    IconData leadingIcon;
    Color iconColor;
    Color iconBg;

    if (title.toLowerCase().contains('onboarding')) {
      leadingIcon = Icons.verified_user_rounded;
      iconColor = const Color(0xFF6366F1);
      iconBg = const Color(0xFFEFF6FF);
    } else if (title.toLowerCase().contains('bill')) {
      leadingIcon = Icons.receipt_long_rounded;
      iconColor = const Color(0xFF14B8A6);
      iconBg = const Color(0xFFE6FAFA);
    } else if (title.toLowerCase().contains('refer')) {
      leadingIcon = Icons.group_add_rounded;
      iconColor = const Color(0xFFF59E0B);
      iconBg = const Color(0xFFFFF8E1);
    } else {
      leadingIcon = Icons.flash_on_rounded;
      iconColor = const Color(0xFFEF4444);
      iconBg = const Color(0xFFFEE2E2);
    }

    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: iconBg,
            child: Icon(leadingIcon, color: iconColor, size: 22),
          ),
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 15),
          ),
          trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.monetization_on_rounded,
                  color: Color(0xFFFFB800), size: 18),
              const SizedBox(width: 4),
              Text(
                '+$points pts',
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60.0), // indent under avatar
          child: const Divider(height: 1, thickness: 0.7, color: Color(0xFFE5E7EB)),
        ),
      ],
    );
  }
}

class RewardHistoryTile extends StatelessWidget {
  final String title;
  final String date;
  final int points;
  const RewardHistoryTile(this.title, this.date, this.points);

  @override
  Widget build(BuildContext context) {
    IconData leadingIcon;
    Color iconColor;
    Color iconBg;

    if (title.toLowerCase().contains('onboard')) {
      leadingIcon = Icons.verified_user_rounded;
      iconColor = const Color(0xFF6366F1);
      iconBg = const Color(0xFFEFF6FF);
    } else if (title.toLowerCase().contains('bill')) {
      leadingIcon = Icons.receipt_long_rounded;
      iconColor = const Color(0xFF14B8A6);
      iconBg = const Color(0xFFE6FAFA);
    } else if (title.toLowerCase().contains('refer')) {
      leadingIcon = Icons.group_add_rounded;
      iconColor = const Color(0xFFF59E0B);
      iconBg = const Color(0xFFFFF8E1);
    } else {
      leadingIcon = Icons.flash_on_rounded;
      iconColor = const Color(0xFF3B82F6);
      iconBg = const Color(0xFFEFF6FF);
    }

    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: iconBg,
            child: Icon(leadingIcon, color: iconColor, size: 22),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            date,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200, width: 1),
            ),
            child: Text(
              '+$points pts',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: const Divider(height: 1, thickness: 0.7, color: Color(0xFFE5E7EB)),
        ),
      ],
    );
  }
}


class RewardHowToTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const RewardHowToTile(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          leading: const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFEFF6FF),
            child: Icon(Icons.info_outline_rounded,
                color: Color(0xFF6366F1), size: 22),
          ),
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 15),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
                fontSize: 13, color: Color(0xFF6B7280)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: const Divider(height: 1, thickness: 0.7, color: Color(0xFFE5E7EB)),
        ),
      ],
    );
  }
}
