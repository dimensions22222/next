import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final bool isUnread;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.isUnread,
  });

  NotificationItem copyWith({
    String? title,
    String? subtitle,
    String? time,
    IconData? icon,
    bool? isUnread,
  }) {
    return NotificationItem(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      time: time ?? this.time,
      icon: icon ?? this.icon,
      isUnread: isUnread ?? this.isUnread,
    );
  }
}
