// transaction_details_sheet.dart
// ignore_for_file: unreachable_switch_default, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next/Features/transactions/Modelz/transaction_item.dart';

class TransactionDetailsSheet extends StatelessWidget {
  final TransactionItem item;

  const TransactionDetailsSheet({Key? key, required this.item})
      : super(key: key);

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'transfer':
      case 'transfer from':
      case 'transfer to':
        return Icons.compare_arrows;
      case 'airtime':
        return Icons.phone_android;
      case 'mobile data':
        return Icons.wifi;
      case 'electricity':
        return Icons.flash_on;
      case 'tv':
        return Icons.tv;
      case 'add money':
        return Icons.account_balance_wallet;
      case 'bonus':
      case 'cashback':
        return Icons.card_giftcard;
      default:
        return Icons.receipt_long;
    }
  }

  Color _getStatusColor(TxStatus status) {
    switch (status) {
      case TxStatus.successful:
        return Colors.green.shade600;
      case TxStatus.pending:
        return Colors.orange.shade600;
      case TxStatus.failed:
        return Colors.red.shade600;
      case TxStatus.reversed:
        return Colors.blueGrey.shade600;
      case TxStatus.toBePaid:
        return Color(0xFF0D47A1);
      default:
        return Colors.grey.shade600;
    }
  }

  String _getStatusText(TxStatus status) {
    switch (status) {
      case TxStatus.successful:
        return 'Successful';
      case TxStatus.pending:
        return 'Pending';
      case TxStatus.failed:
        return 'Failed';
      case TxStatus.reversed:
        return 'Reversed';
      case TxStatus.toBePaid:
        return 'To be paid';
      default:
        return '';
    }
  }

  Widget _detailRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: Colors.grey.shade500),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(item.status);
    final icon = _getIconForType(item.type);
    final isOutgoing = item.amount < 0;
    final currency = NumberFormat.currency(symbol: '₦', decimalDigits: 2);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),

          // Header icon and summary
          CircleAvatar(
            radius: 28,
               backgroundColor: const Color.fromARGB(255, 13, 71, 161).withOpacity(0.2),
            child: Icon(icon,
                color: Color(0xFF0D47A1),
                size: 28),
          ),
          const SizedBox(height: 14),

          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            _getStatusText(item.status),
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          // Amount
          Text(
            (isOutgoing ? '- ' : '+ ') + currency.format(item.amount.abs()),
            style: TextStyle(
              color: isOutgoing
                  ? Colors.redAccent.shade200
                  : Colors.green.shade700,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 25),

          // Divider
          Divider(thickness: 1, color: Colors.grey.shade200),

          // Details section
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Transaction Details",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Use the actual fields from TransactionItem
          _detailRow("Transaction Type", item.type, icon: Icons.receipt_long),
          _detailRow(
              "Payment Method", item.paymentMethod, icon: Icons.payment),
          _detailRow("Transaction NO.", item.transactionNo,
              icon: Icons.confirmation_number_outlined),
          _detailRow(
              "Transaction Date",
              DateFormat.yMMMMd().add_jm().format(item.date),
              icon: Icons.calendar_today),

          // Cashback (if present)
          if (item.isCashback && item.cashbackAmount != null) ...[
            const SizedBox(height: 8),
            Divider(thickness: 1, color: Colors.grey.shade200),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Bonus from Data Purchase",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.grey.shade800),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(children: [
                  const CircleAvatar(
                      backgroundColor: Color(0xFF0D47A1),
                      child: Icon(Icons.local_offer, color: Colors.white)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(
                          '₦${item.cashbackAmount!.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold))),
                  Text('Successful',
                      style: TextStyle(color: Colors.green.shade700)),
                ]),
              ),
            ),
          ],

          const SizedBox(height: 20),
          Divider(thickness: 1, color: Colors.grey.shade200),

          // Buttons
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Report Issue clicked')));
                  },
                  icon: const Icon(Icons.report_problem_outlined, size: 18),
                  label: const Text("Report Issue"),
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share Receipt')));
                  },
                  icon: const Icon(Icons.share_outlined, size: 18),
                  label: const Text("Share Receipt"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D47A1),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
