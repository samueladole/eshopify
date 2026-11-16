import 'package:flutter/material.dart';
import '../../../core/state/app_state.dart';
import '../../../core/widgets/common_widgets.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final items = app.notifications;
    return Scaffold(appBar: AppBar(title: const Text('Notifications'), actions: [TextButton(onPressed: app.markAllRead, child: const Text('Mark all as read'))]),
      body: items.isEmpty ? const EmptyState(icon: Icons.notifications_none, title: 'No notifications', message: 'You\'re all caught up. We\'ll notify you about orders and deals here.') : ListView.separated(itemCount: items.length, separatorBuilder: (_, __) => const Divider(height: 1), itemBuilder: (_, i) {
        final n = items[i];
        IconData icon = n.type == 'order' ? Icons.local_shipping_outlined : n.type == 'price' ? Icons.sell_outlined : Icons.campaign_outlined;
        return ListTile(tileColor: n.read ? null : Theme.of(context).colorScheme.primary.withOpacity(0.05), leading: CircleAvatar(child: Icon(icon)), title: Text(n.title, style: TextStyle(fontWeight: n.read ? FontWeight.w500 : FontWeight.w700)), subtitle: Text(n.message), trailing: Text(_ago(n.time), style: const TextStyle(color: Colors.grey, fontSize: 12)));
      }),
    );
  }
  String _ago(DateTime t) { final d = DateTime.now().difference(t); if (d.inHours < 24) return '${d.inHours}h'; return '${d.inDays}d'; }
}
