// ignore_for_file: unused_field, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next/Features/transactions/transact_history_page.dart';
import 'package:next/TV%20sub%20flow/tvsub_page.dart';
import 'package:next/Features/airtimeflow/Airtime_page.dart';
import 'package:next/Features/bottomNAVpages/profile_me.dart';
import 'package:next/Features/bottomNAVpages/reward_page.dart';
import 'package:next/customWidget/profile_image_store.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart'; // For haptic feedback

import 'dart:io';

import 'package:next/Features/dataflow/Data_page.dart';
import 'package:next/Features/eletricityflow/Electricitypage.dart';
import 'package:next/main%20pages/Addmoneypage.dart';
import 'package:next/Features/ContactUs/Supportpage.dart';
import 'package:next/main%20pages/Notificationpage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isBalanceVisible = true;

  bool _isLongPressing = false;

  final ImagePicker _picker = ImagePicker();

  double availableBalance = 56432320;
  List<Map<String, dynamic>> transacts = [
    {
      'title': 'Transfer from PEARL CRAIG F..',
      'amount': 8000.00,
      'type': 'credit',
      'status': 'successful',
      'date': 'Aug 12th, 22:08:32',
    },
    {
      'title': 'Airtime',
      'amount': 9000.00,
      'type': 'debit',
      'status': 'pending',
      'date': 'Aug 13th, 11:11:12',
    },
  ];

  void addMoney(double amount) {
    setState(() {
      availableBalance += amount;
      transacts.insert(0, {
        'title': 'Money added',
        'amount': amount,
        'type': 'credit',
        'status': 'successful',
        'date': DateFormat("MMM d'th', HH:mm:ss").format(DateTime.now()),
      });
    });
  }

  final Color _bgWhite = Colors.white;
  final Color _primaryBlue = const Color(0xFF0D47A1);
  final Color _mutedGrey = const Color(0xFF6B7280);
  final Color _headingBlack = const Color(0xFF0F172A);

  bool _isSpecialAmount(double amount) {
    return amount == 8000.00 || amount == 9000.00;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isTablet = width > 700;

    final double horizontalPadding = isTablet ? 36 : 20;
    const double cardRadius = 16;
    final double sectionSpacing = isTablet ? 28 : 20;

    return Scaffold(
      backgroundColor: _bgWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 18),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: height - kBottomNavigationBarHeight - 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== HEADER CARD =====
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: _bgWhite,
                    borderRadius: BorderRadius.circular(cardRadius),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 6,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // === Open image dialog ===
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: "Close",
                                barrierColor: Colors.black54,
                                transitionDuration:
                                    const Duration(milliseconds: 250),
                                pageBuilder: (_, __, ___) {
                                  return Center(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: StatefulBuilder(
                                        builder: (context, setDialogState) {
                                          return Container(
                                            width: 300,
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // color: Colors.transparent,
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Colors.black.withOpacity(0.2),
                                              //     blurRadius: 10,
                                              //     spreadRadius: 2,
                                              //     offset: const Offset(0, 5),
                                              //   ),
                                              // ],
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: SizedBox(
                                                    width: 250,
                                                    height: 250,
                                                    child: ProfileImageStore
                                                                .imageFile !=
                                                            null
                                                        ? Image.file(
                                                            ProfileImageStore
                                                                .imageFile!,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(
                                                            color: Colors
                                                                .blue.shade50,
                                                            child: const Icon(
                                                              Icons
                                                                  .person_outline,
                                                              color: Color(
                                                                  0xFF0D47A1),
                                                              size: 120,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                                const SizedBox(height: 18),
                                                ElevatedButton.icon(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF0D47A1),
                                                    foregroundColor:
                                                        Colors.white,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 28,
                                                      vertical: 12,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  icon: const Icon(
                                                      Icons.camera_alt_outlined,
                                                      size: 20),
                                                  label: Text(
                                                    ProfileImageStore
                                                                .imageFile ==
                                                            null
                                                        ? "Add Photo"
                                                        : "Change Photo",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    final ImagePicker picker =
                                                        ImagePicker();
                                                    final pickedFile =
                                                        await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                    );
                                                    if (pickedFile != null) {
                                                      setState(() {
                                                        ProfileImageStore
                                                                .imageFile =
                                                            File(pickedFile
                                                                .path);
                                                      });
                                                      setDialogState(() {});
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                                transitionBuilder: (_, anim, __, child) {
                                  return FadeTransition(
                                    opacity: CurvedAnimation(
                                        parent: anim, curve: Curves.easeOut),
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 0.1),
                                        end: Offset.zero,
                                      ).animate(CurvedAnimation(
                                          parent: anim, curve: Curves.easeOut)),
                                      child: child,
                                    ),
                                  );
                                },
                              );
                            },

                            // === Long press to remove with red glow and haptic ===
                            onLongPressStart: (_) async {
                              setState(() => _isLongPressing = true);
                              HapticFeedback.mediumImpact(); // subtle vibration
                            },
                            onLongPressEnd: (_) async {
                              await Future.delayed(
                                  const Duration(milliseconds: 200));
                              setState(() => _isLongPressing = false);

                              if (ProfileImageStore.imageFile != null) {
                                final shouldRemove = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    title: const Text(
                                      "Remove Profile Photo?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                      "Are you sure you want to remove your profile picture?",
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                      ),
                                      TextButton(
                                        child: const Text(
                                          "Remove",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                      ),
                                    ],
                                  ),
                                );

                                if (shouldRemove == true) {
                                  setState(() {
                                    ProfileImageStore.imageFile = null;
                                  });
                                }
                              }
                            },

                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.all(2.2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _isLongPressing
                                      ? Colors.redAccent
                                      : ProfileImageStore.imageFile == null
                                          ? Colors.black
                                          : const Color(0xFF0D47A1),
                                  width: 2.5,
                                ),
                                boxShadow: _isLongPressing
                                    ? [
                                        BoxShadow(
                                          color:
                                              Colors.redAccent.withOpacity(0.6),
                                          blurRadius: 10,
                                          spreadRadius: 3,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.blue.shade50,
                                backgroundImage: ProfileImageStore.imageFile !=
                                        null
                                    ? FileImage(ProfileImageStore.imageFile!)
                                    : null,
                                child: ProfileImageStore.imageFile == null
                                    ? const Icon(
                                        Icons.person_outline,
                                        color: Color(0xFF0D47A1),
                                        size: 22,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Hi Taiwo",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 5, 201, 245),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 107, 195, 215)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: const Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 14),
                                    SizedBox(width: 6),
                                    Text(
                                      "22 pts",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.headset_mic_outlined,
                                size: 22, color: _mutedGrey),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SupportPage()),
                              );
                            },
                          ),
                          Stack(
                            children: [
                              IconButton(
                                icon: const Icon(
                                    Icons.notifications_none_outlined,
                                    size: 26),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationPage()),
                                  );
                                },
                              ),
                              Positioned(
                                right: 12,
                                top: 12,
                                child: Container(
                                  width: 9,
                                  height: 9,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: sectionSpacing),

                // ===== BALANCE CARD =====
                Container(
                  constraints: const BoxConstraints(minHeight: 130),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: _primaryBlue,
                    borderRadius: BorderRadius.circular(cardRadius + 4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Available balance",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isBalanceVisible = !_isBalanceVisible;
                              });
                            },
                            child: Icon(
                              _isBalanceVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TransactHistoryPage()),
                          );},
                            child: const Row(
                              children: [
                                Text(
                                  "Transact history",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios_outlined,
                                    color: Colors.white, size: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Wrap the balance text in a SizedBox with fixed width to prevent layout shift
                          SizedBox(
                            width: 200, // <-- adjust if needed for tablets
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    _isBalanceVisible
                                        ? "₦ ${NumberFormat("#,##0.", "en_NG").format(availableBalance)}"
                                        : "₦ ******",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      height: 1.05,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(), // this replaces fixed width spacing for more responsive layout
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: Colors.white, width: 1.4),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x22000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  // Navigate
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddMoneyPage(),
                                    ),
                                  );
                                },
                                onLongPress: () {
                                  // Long press adds money
                                  HapticFeedback
                                      .mediumImpact(); // optional feedback
                                  addMoney(5000);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add,
                                          color: Colors.black, size: 18),
                                      SizedBox(width: 6),
                                      Text(
                                        "Add money",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: sectionSpacing),

                // ===== NEW TRANSACTS CARD =====
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue.withOpacity(0.08)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: List.generate(transacts.length, (index) {
                      final tx = transacts[index];
                      final bool isCredit = tx['type'] == 'credit';
                      final double amt = tx['amount'] as double;
                      final bool specialBlack = _isSpecialAmount(amt);
                      final bool isSuccessful = tx['status'] == 'successful';

                      final Color statusBg = isSuccessful
                          ? const Color(0xFF22C55E).withOpacity(0.15)
                          : const Color(0xFFF59E0B).withOpacity(0.15);
                      final Color statusText = isSuccessful
                          ? const Color(0xFF15803D)
                          : const Color(0xFFB45309);

                      return Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.blue.shade50,
                                child: Icon(
                                  isCredit
                                      ? Icons.arrow_downward
                                      : Icons.phone_android,
                                  color: Colors.blue.shade700,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tx['title'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      tx['date'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF64748B)),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${isCredit ? '+₦' : '-₦'}${amt.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: specialBlack
                                          ? const Color(0xFF0F172A)
                                          : (isCredit
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2.5),
                                    decoration: BoxDecoration(
                                      color: statusBg,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      tx['status'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: statusText,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if (index != transacts.length - 1)
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 58.0, top: 10, bottom: 8),
                              child: Divider(
                                color: Color(0xFFE2E8F0),
                                thickness: 0.8,
                                height: 1,
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                ),

                SizedBox(height: sectionSpacing),

                // ===== QUICK ACTIONS CARD =====
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: _bgWhite,
                    borderRadius: BorderRadius.circular(cardRadius),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 6,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _QuickAction(icon: Icons.phone_android, label: "Airtime"),
                      _QuickAction(icon: Icons.tv, label: "TV"),
                      _QuickAction(icon: Icons.wifi, label: "Data"),
                      _QuickAction(icon: Icons.flash_on, label: "Electricity"),
                    ],
                  ),
                ),

                SizedBox(height: sectionSpacing),

                // ===== PROMO CARD =====
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5D1),
                    borderRadius: BorderRadius.circular(cardRadius),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 82, 233, 90),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.card_giftcard,
                            color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hurry and earn from Trigon",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text.rich(
                              TextSpan(
                                text: "Get 2% instant ",
                                style: TextStyle(
                                    fontSize: 13.5, color: Colors.black87),
                                children: [
                                  TextSpan(
                                    text: "cashback ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  TextSpan(text: "for every transact"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: _bgWhite,
        selectedItemColor: _primaryBlue,
        unselectedItemColor: _mutedGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
            case 1:
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RewardsPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: "Wallet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard_outlined), label: "Reward"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Me"),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    void navigate() {
      switch (label) {
        case "Airtime":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AirtimePage()),
          );
          break;
        case "TV":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TvSubPage()),
          );
          break;
        case "Data":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DataSubPage()),
          );
          break;
        case "Electricity":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ElectricityPage()),
          );
          break;
      }
    }

    return GestureDetector(
      onTap: navigate,
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, color: const Color(0xFF0D47A1), size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
