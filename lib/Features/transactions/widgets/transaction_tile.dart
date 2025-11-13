// transaction_tile.dart
// ignore_for_file: unreachable_switch_default, deprecated_member_use

import 'package:flutter/material.dart';
import '../Modelz/transaction_item.dart';

class TransactionTile extends StatelessWidget {
  final TransactionItem item;
  final VoidCallback onTap;

  const TransactionTile({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

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
        return Colors.purple.shade600;
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

  @override
  Widget build(BuildContext context) {
    final icon = _getIconForType(item.type);
    final statusColor = _getStatusColor(item.status);
    final isOutgoing = item.amount < 0;

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            children: [
              // Icon circle
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color:  const Color.fromARGB(255, 13, 71, 161).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon,
                    size: 22,
                    color:const Color(0xFF0D47A1)
                        ),
              ),
              const SizedBox(width: 12),

              // Title & subtitle column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Amount & status column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isOutgoing ? '- ' : '+ '}₦${item.amount.abs().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: isOutgoing
                          ? Colors.redAccent.shade200
                          : Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getStatusText(item.status),
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
