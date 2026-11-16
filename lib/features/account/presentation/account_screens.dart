import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/state/app_state.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override Widget build(BuildContext context) {
    Widget tile(IconData i, String t, {String? sub, VoidCallback? onTap}) => ListTile(leading: Icon(i), title: Text(t), subtitle: sub!=null?Text(sub):null, trailing: const Icon(Icons.chevron_right), onTap: onTap);
    return Scaffold(appBar: AppBar(title: const Text('Account')), body: ListView(children: [
      ListTile(contentPadding: const EdgeInsets.all(16), leading: const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30)), title: const Text('Samuel Lee', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)), subtitle: const Text('samuel@example.com'), trailing: TextButton(onPressed: (){}, child: const Text('Edit'))),
      const Divider(),
      tile(Icons.receipt_long, 'Orders', sub: 'Track, return, or buy again', onTap: () => context.go('/orders')),
      tile(Icons.location_on_outlined, 'Addresses', sub: 'Manage delivery locations', onTap: () => context.push('/addresses')),
      tile(Icons.credit_card, 'Payment Methods', sub: 'Cards and wallets', onTap: () => context.push('/payments')),
      tile(Icons.favorite_border, 'Wishlist', onTap: () => context.push('/wishlist')),
      tile(Icons.confirmation_num_outlined, 'Coupons', sub: '2 available'),
      tile(Icons.notifications_none, 'Notifications', onTap: () => context.push('/notifications')),
      tile(Icons.help_outline, 'Help Center'),
      tile(Icons.settings_outlined, 'Settings', onTap: () => context.push('/settings')),
      const Divider(),
      ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text('Logout', style: TextStyle(color: Colors.red)), onTap: () => context.go('/welcome')),
    ]));
  }
}

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    return Scaffold(appBar: AppBar(title: const Text('Addresses')), floatingActionButton: FloatingActionButton.extended(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Add Address')),
      body: ListView.separated(padding: const EdgeInsets.all(16), itemCount: app.addresses.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (_, i) {
        final a = app.addresses[i];
        return Card(child: ListTile(leading: Icon(a.label == 'Home' ? Icons.home_outlined : Icons.work_outline), title: Row(children: [Text('${a.label} · ${a.name}', style: const TextStyle(fontWeight: FontWeight.w700)), if (a.isDefault) ...[const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)), child: const Text('Default', style: TextStyle(color: Colors.green, fontSize: 11)))]]), subtitle: Text('${a.line1}\n${a.city} ${a.zip}\n${a.phone}'), isThreeLine: true, trailing: IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {})));
      }));
  }
}

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Payment Methods')), floatingActionButton: FloatingActionButton.extended(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Add Method')),
      body: ListView.separated(padding: const EdgeInsets.all(16), itemCount: MockData.paymentMethods.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (_, i) {
        final p = MockData.paymentMethods[i];
        return Card(child: ListTile(leading: Icon(p.type == 'apple_pay' ? Icons.apple : Icons.credit_card), title: Text(p.label, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(p.details), trailing: const Icon(Icons.chevron_right)));
      }));
  }
}
