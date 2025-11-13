// widgets/empty_state_view.dart
import 'package:flutter/material.dart';
import 'package:next/main%20pages/utils/widgets/custom_button.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPrimary;

  const EmptyStateView({
    Key? key,
    this.title = 'No transaction records found for the past 1 year',
    this.subtitle = '',
    required this.onPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // placeholder illustration - replace with your asset
            SizedBox(
              width: 160,
              height: 160,
              child: Image.asset(
                'assets/images/empty.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(Icons.receipt_long, size: 120, color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(height: 100),
            Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(subtitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
            ],
            const SizedBox(height: 16),
            CustomButton(
              text: 'View Analysis',
              onPressed: onPrimary, 
              width: 2,
            ),
          ],
        ),
      ),
    );
  }
}
