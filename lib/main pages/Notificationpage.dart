import 'package:flutter/material.dart';
import 'package:next/Models/NotificationModell.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<NotificationItem> notifications;
  NotificationItem? recentlyDeleted;

  @override
  void initState() {
    super.initState();
    notifications = [
      NotificationItem(
        title: 'Trigon',
        subtitle: 'You received ₦20,000 from Lawal Umar...',
        time: '1 day ago',
        icon: Icons.arrow_downward_rounded,
        isUnread: true,
      ),
      NotificationItem(
        title: 'Cash back reward received',
        subtitle: 'You received ₦200 cash back reward',
        time: '7 days ago',
        icon: Icons.card_giftcard_rounded,
        isUnread: false,
      ),
      NotificationItem(
        title: 'Cash back reward received',
        subtitle: 'You received ₦200 cash back reward',
        time: '7 days ago',
        icon: Icons.card_giftcard_rounded,
        isUnread: false,
      ),
      NotificationItem(
        title: 'Trigon',
        subtitle: 'You received ₦20,000 from Lawal Umar...',
        time: '1 day ago',
        icon: Icons.arrow_downward_rounded,
        isUnread: true,
      ),
      NotificationItem(
        title: 'Trigon',
        subtitle: 'You received ₦20,000 from Lawal Umar...',
        time: '1 day ago',
        icon: Icons.arrow_downward_rounded,
        isUnread: true,
      ),
    ];
  }

  int get unreadCount => notifications.where((n) => n.isUnread).length;

  void markAsRead(int index) {
    setState(() {
      notifications[index] = notifications[index].copyWith(isUnread: false);
    });
  }

  void deleteNotification(int index) {
    setState(() {
      recentlyDeleted = notifications[index];
      notifications.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Notification deleted',
          style: TextStyle(fontSize: 15),
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              if (recentlyDeleted != null) {
                notifications.insert(index, recentlyDeleted!);
                recentlyDeleted = null;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Unread banner
          Container(
            width: double.infinity,
            color: Colors.grey[100],
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                const Icon(Icons.circle, color: Colors.red, size: 12),
                const SizedBox(width: 10),
                Text(
                  'You have $unreadCount unread notification${unreadCount == 1 ? '' : 's'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Section label
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 0, 8),
            child: Text(
              'Yesterday',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // List of notifications
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: notifications.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Colors.transparent),
              itemBuilder: (context, index) {
                final notif = notifications[index];

                return Dismissible(
  key: UniqueKey(),
  direction: DismissDirection.endToStart,
  background: Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.only(right: 20),
    alignment: Alignment.centerRight,
    decoration: BoxDecoration(
      color: Colors.red[400],
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.delete_forever, color: Colors.white, size: 28),
  ),
  onDismissed: (_) {
    setState(() {
      recentlyDeleted = notifications[index];
      notifications.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted', style: TextStyle(fontSize: 15)),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              if (recentlyDeleted != null) {
                notifications.insert(index, recentlyDeleted!);
                recentlyDeleted = null;
              }
            });
          },
        ),
      ),
    );
  },
  child: GestureDetector(
    onTap: () => markAsRead(index),
    child: AnimatedOpacity(
      opacity: notif.isUnread ? 1.0 : 0.85,
      duration: const Duration(milliseconds: 250),
      child: _NotificationTile(
        title: notif.title,
        subtitle: notif.subtitle,
        time: notif.time,
        icon: notif.icon,
        isUnread: notif.isUnread,
      ),
    ),
  ),
);

              },
            ),
          ),
        ],
      ),
    );
  }
}

// Notification tile widget
class _NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final bool isUnread;

  const _NotificationTile({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon bubble
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF0D47A1), size: 26),
            ),
            const SizedBox(width: 14),

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14.5,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Red unread dot
            if (isUnread)
              const Padding(
                padding: EdgeInsets.only(top: 8, right: 4),
                child: Icon(Icons.circle, color: Colors.red, size: 12),
              ),
          ],
        ),
      ),
    );
  }
}
