// models/transaction_item.dart
// ignore_for_file: unused_import

import 'package:flutter/material.dart';

enum TxStatus { successful, pending, failed, reversed, toBePaid }

class TransactionItem {
  final String id;
  final String title;
  final String subtitle;
  final DateTime date;
  final double amount;
  final TxStatus status;
  final String type; // e.g. "Mobile Data", "Airtime"
  final bool isCashback;
  final double? cashbackAmount;
  final String transactionNo;
  final String paymentMethod;

  TransactionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.status,
    required this.type,
    this.isCashback = false,
    this.cashbackAmount,
    required this.transactionNo,
    required this.paymentMethod,
  });
}
