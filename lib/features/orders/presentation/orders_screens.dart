import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/state/app_state.dart';
import '../../../core/widgets/common_widgets.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override Widget build(BuildContext context) {
    final tabs = ['All','Active','Completed','Cancelled','Returns'];
    return DefaultTabController(length: tabs.length, child: Scaffold(
      appBar: AppBar(title: const Text('Orders'), bottom: TabBar(isScrollable: true, tabs: tabs.map((t) => Tab(text: t)).toList())),
      body: TabBarView(children: tabs.map((t) => _OrdersList(tab: t)).toList()),
    ));
  }
}

class _OrdersList extends StatelessWidget {
  final String tab; const _OrdersList({required this.tab});
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    var orders = app.orders;
    if (tab != 'All') orders = orders.where((o) => tab == 'Returns' ? o.status == 'Returned' : o.status == tab).toList();
    if (orders.isEmpty) return RefreshIndicator(onRefresh: () async {}, child: ListView(children: const [SizedBox(height: 120), EmptyState(icon: Icons.receipt_long_outlined, title: 'No orders yet', message: 'Your orders will appear here once you place them.')]));
    return RefreshIndicator(onRefresh: () async => await Future.delayed(const Duration(milliseconds: 600)), child: ListView.separated(padding: const EdgeInsets.all(16), itemCount: orders.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (_, i) {
      final o = orders[i];
      return Card(child: InkWell(onTap: () => context.push('/order-detail/${o.id}'), borderRadius: BorderRadius.circular(16), child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Text(o.id, style: const TextStyle(fontWeight: FontWeight.w800)), const Spacer(), _status(o.status)]),
        const SizedBox(height: 6), Text('${o.date.month}/${o.date.day}/${o.date.year} · \$${o.total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 10),
        SizedBox(height: 54, child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: o.items.length, separatorBuilder: (_, __) => const SizedBox(width: 8), itemBuilder: (_, j) => ClipRRect(borderRadius: BorderRadius.circular(8), child: SizedBox(width: 54, height: 54, child: ProductImage(url: o.items[j].product.imageUrl))))),
        const SizedBox(height: 8), Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => context.push('/order-tracking/${o.id}'), child: const Text('Track / Details'))),
      ]))));
    }));
  }
  Widget _status(String s) { Color c = s=='Active'?Colors.blue: s=='Completed'?Colors.green: s=='Cancelled'?Colors.red: Colors.orange; return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: c.withOpacity(0.12), borderRadius: BorderRadius.circular(20)), child: Text(s, style: TextStyle(color: c, fontWeight: FontWeight.w700, fontSize: 12))); }
}

class OrderDetailScreen extends StatelessWidget {
  final String orderId; const OrderDetailScreen({super.key, required this.orderId});
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final o = app.orders.firstWhere((e) => e.id == orderId, orElse: () => app.orders.first);
    final steps = ['Ordered','Packed','Shipped','Out for delivery','Delivered'];
    final current = steps.indexOf(o.trackingStatus) < 0 ? 0 : steps.indexOf(o.trackingStatus);
    return Scaffold(appBar: AppBar(title: Text(o.id)), body: ListView(padding: const EdgeInsets.all(16), children: [
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Status: ${o.status}', style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text('Total: \$${o.total.toStringAsFixed(2)}'), Text('Deliver to: ${o.addressSummary}', style: const TextStyle(color: Colors.grey)),
      ]))),
      const SizedBox(height: 16), const Text('Order Timeline', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)), const SizedBox(height: 8),
      ...List.generate(steps.length, (i) => _step(steps[i], i <= current, i == current)),
      const SizedBox(height: 16), const Text('Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)), const SizedBox(height: 8),
      ...o.items.map((it) => ListTile(contentPadding: EdgeInsets.zero, leading: SizedBox(width: 56, height: 56, child: ProductImage(url: it.product.imageUrl, radius: BorderRadius.circular(8))), title: Text(it.product.title), subtitle: Text('${it.color} · ${it.size} · Qty ${it.quantity}'), trailing: Text('\$${it.product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700)))),
      const SizedBox(height: 16),
      Row(children: [Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Reorder'))), const SizedBox(width: 12), Expanded(child: FilledButton.tonal(onPressed: () {}, child: const Text('Invoice')))]),
    ]));
  }
  Widget _step(String t, bool done, bool active) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Column(children: [Icon(done ? Icons.check_circle : Icons.radio_button_unchecked, color: done ? Colors.green : Colors.grey), Container(width: 2, height: 28, color: Colors.grey.shade300)]),
    const SizedBox(width: 12), Padding(padding: const EdgeInsets.only(top: 2), child: Text(t, style: TextStyle(fontWeight: active ? FontWeight.w700 : FontWeight.w500, color: done ? null : Colors.grey))),
  ]);
}

class OrderTrackingScreen extends StatelessWidget {
  final String orderId; const OrderTrackingScreen({super.key, required this.orderId});
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final o = app.orders.firstWhere((e) => e.id == orderId, orElse: () => app.orders.first);
    final steps = ['Ordered','Packed','Shipped','Out for delivery','Delivered'];
    final current = steps.indexOf(o.trackingStatus) < 0 ? 1 : steps.indexOf(o.trackingStatus).clamp(0, 4);
    return Scaffold(appBar: AppBar(title: const Text('Track Order')), body: ListView(padding: const EdgeInsets.all(16), children: [
      Container(height: 180, decoration: BoxDecoration(color: Colors.blueGrey.shade100, borderRadius: BorderRadius.circular(16)), child: const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.map_outlined, size: 48, color: Colors.blueGrey), SizedBox(height: 8), Text('Map placeholder', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w600))]))),
      const SizedBox(height: 16),
      Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: const Text('Courier: Alex Johnson'), subtitle: Text('Estimated arrival: Today, 4:30 PM · ${o.id}'), trailing: IconButton(icon: const Icon(Icons.call), onPressed: () {}))),
      const SizedBox(height: 16), const Text('Delivery Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      ...List.generate(steps.length, (i) => ListTile(leading: Icon(i <= current ? Icons.check_circle : Icons.radio_button_unchecked, color: i <= current ? Colors.green : Colors.grey), title: Text(steps[i], style: TextStyle(fontWeight: i==current?FontWeight.w700:FontWeight.w500)))),
      const SizedBox(height: 12), PrimaryButton(label: 'Contact Support', icon: Icons.support_agent, onPressed: () {}),
    ]));
  }
}
