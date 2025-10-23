// lib/airtime_flow/shared_widgets.dart
import 'package:flutter/material.dart';

/// Shared widgets used across the airtime flow pages.

const Color kBackgroundGray = Color(0xFF343434);
const Color kAccentBlue = Color(0xFF0B63D6);

class PhoneMockup extends StatelessWidget {
  final Widget child;
  const PhoneMockup({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // simple phone-like frame; you can remove this if you prefer full-screen pages
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(22), child: child),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final String balance;
  final String rewards;
  final VoidCallback? onAdd;
  const BalanceCard({Key? key,
   required this.balance,
    required this.rewards, this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: kAccentBlue,
         borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.all(14),
      child: Row(children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            const Text('Available balance',
             style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 6),
            Text(balance, style: const TextStyle(
              color: Colors.white, 
              fontSize: 20,
               fontWeight: FontWeight.w700)),
            const Spacer(),
            Text(rewards, style: const TextStyle(color: Colors.white70)),
          ]),
        ),
        ElevatedButton(
          onPressed: onAdd,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, 
            foregroundColor: Colors.black87, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24))),
          child: const Text('+ Add money'),
        )
      ]),
    );
  }
}

class AmountChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onTap;
  const AmountChip({Key? key, required this.text, this.selected = false, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? kAccentBlue : Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(text, style: TextStyle(color: selected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
