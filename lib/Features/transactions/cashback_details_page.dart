// cashback_details_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashbackDetailsPage extends StatefulWidget {
  const CashbackDetailsPage({Key? key}) : super(key: key);

  @override
  State<CashbackDetailsPage> createState() => _CashbackDetailsPageState();
}

// cashback_details_page.dart (fixed snippet)
class _CashbackDetailsPageState extends State<CashbackDetailsPage> {
  double totalCashback = 21.0;
  bool showEarnings = true;

  final List<Map<String, dynamic>> records = [
    {
      'title': 'Bonus from Airtime Purchase',
      'date': DateTime.now().subtract(const Duration(days: 21)),
      'amount': 17.5
    },
    {
      'title': 'Bonus from Airtime Purchase',
      'date': DateTime.now().subtract(const Duration(days: 25)),
      'amount': 17.5
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '₦', decimalDigits: 2);
    return Scaffold(
      appBar: AppBar(title: const Text('Cashback Details')),
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: Column(children: [
          // ... (unchanged header + earnings section)
          Expanded(
            child: records.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.hourglass_empty, size: 80, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('No record found for the last 7 months'),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: records.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final r = records[index];
                      final title = r['title'] as String;
                      final date = r['date'] as DateTime;
                      final amount = r['amount'] as double;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: const Icon(Icons.local_offer, color: Colors.blue),
                        ),
                        title: Text(title),
                        subtitle: Text(DateFormat.yMMMd().format(date)),
                        trailing: Text(
                          '+${currency.format(amount)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
          )
        ]),
      ),
    );
  }
}
