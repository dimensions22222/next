// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next/customWidget/ticket.dart';

class AccountLimitPage extends StatelessWidget {
  const AccountLimitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Account Limits',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ticket-like info card
           TicketCard(
  child: Column(
    children: [
      Stack(
  clipBehavior: Clip.none,
  children: [
    // The ticket itself
    TicketCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '9044588443',
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    ),
                ),
                const SizedBox(width: 8),
                InkWell(
  onTap: () {
    Clipboard.setData(const ClipboardData(text: '9044588443'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account number copied!'),
        duration: Duration(seconds: 1),
      ),
    );
  },
  child: Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.black26, // light grey border
        width: 1,
      ),
    ),
    child: const Row(
      children: [
        Text(
          'Copy',
          style: TextStyle(
            color: Color(0xFF0D47A1),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 4),
        Icon(
          Icons.copy,
          size: 16,
          color: Color(0xFF0D47A1),
        ),
      ],
    ),
  ),
),

              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'AYUK NDIP EMMANUEL',
                style: TextStyle(
                    color: Color(0xFF0D47A1),
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    ),

    // Account Info label (center top, outside the ticket)
    Positioned(
      top: -22,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 223, 222, 253),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Text(
            'Account Info',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6F63C9),
            ),
          ),
        ),
      ),
    ),

    // Tier 1 badge 
    Positioned(
      top: -26,
      right: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF0D47A1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Tier 1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  ],
),

    ],
  ),
),

            const SizedBox(height: 16),

            // Linked ID section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                title: const Text('Linked ID',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('NIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.black45),
                  ],
                ),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 16),

            // Limit Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Limit Info',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F2F4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'The higher your account tier, the higher your transaction limit',
                      style:
                          TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Level Benefit Table
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Level Benefit',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 14),
                  _tierRow('Tier', 'Daily Transaction Limit',
                      'Maximum Account balance', isHeader: true),
                  const Divider(),
                  _tierRow('Tier 1', '₦50,000', '₦300,000', tag: 'Current'),
                  _tierRow('Tier 2', '₦200,000', '₦500,000', tag: 'Up next'),
                  _tierRow('Tier 3', '₦5,000,000', 'Unlimited'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Upgrade button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
                onPressed: () {
                  // Upgrade action
                },
                child: const Text(
                  'Upgrade to Tier 2',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tier table row widget
  static Widget _tierRow(String tier, String daily, String max,
      {bool isHeader = false, String? tag}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  tier,
                  style: TextStyle(
                    fontWeight:
                        isHeader ? FontWeight.bold : FontWeight.w500,
                    fontSize: isHeader ? 13 : 14,
                  ),
                ),
                if (tag != null) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 6),
                    decoration: BoxDecoration(
                      color: tag == 'Current'
                          ? const Color.fromARGB(255, 183, 209, 252)
                          : const Color(0xFF0D47A1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color:
                            tag == 'Current' ? const Color.fromARGB(255, 54, 110, 194) : Colors.white,
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Text(daily,
                  style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13))),
          Expanded(
              flex: 1,
              child: Text(max,
                  style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13))),
        ],
      ),
    );
  }
}
