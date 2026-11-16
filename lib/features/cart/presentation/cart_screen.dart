import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/state/app_state.dart';
import '../../../core/widgets/common_widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final items = app.cart;
    return Scaffold(
      appBar: AppBar(title: Text('Cart (${app.cartCount})')),
      body: items.isEmpty ? const EmptyState(icon: Icons.shopping_cart_outlined, title: 'Your cart is empty', message: 'Looks like you haven\'t added anything yet.') : Column(children: [
        Expanded(child: ListView.separated(padding: const EdgeInsets.all(16), itemCount: items.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (_, i) {
          final item = items[i];
          return Dismissible(key: ValueKey('${item.product.id}-${item.color}-${item.size}'), direction: DismissDirection.endToStart, background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.delete, color: Colors.white)), onDismissed: (_) => app.removeFromCart(item),
            child: Card(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
              SizedBox(width: 90, height: 90, child: ProductImage(url: item.product.imageUrl, radius: BorderRadius.circular(12))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.product.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4), Text('${item.color} · ${item.size}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Row(children: [PriceText(price: item.product.price, size: 16), const Spacer(), QuantityStepper(value: item.quantity, onChanged: (v) => app.updateQty(item, v))]),
                Row(children: [TextButton(onPressed: () => app.removeFromCart(item), child: const Text('Remove')), TextButton(onPressed: () {}, child: const Text('Save for later'))]),
              ])),
            ]))),
          );
        })),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0,-2))]), child: SafeArea(top: false, child: Column(children: [
          Row(children: [Expanded(child: TextField(decoration: const InputDecoration(hintText: 'Promo code', prefixIcon: Icon(Icons.local_offer_outlined)))), const SizedBox(width: 8), FilledButton.tonal(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Promo code applied (mock)'))), child: const Text('Apply'))]),
          const SizedBox(height: 12),
          _row('Subtotal', app.subtotal), _row('Shipping', app.shipping), _row('Discount', -app.discount, highlight: true), _row('Tax', app.tax), const Divider(),
          _row('Total', app.total, bold: true),
          const SizedBox(height: 12),
          PrimaryButton(label: 'Proceed to Checkout', onPressed: () => context.push('/checkout')),
        ]))),
      ]),
    );
  }

  Widget _row(String l, double v, {bool bold = false, bool highlight = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [Text(l, style: TextStyle(fontWeight: bold ? FontWeight.w700 : FontWeight.w400)), const Spacer(), Text('${v < 0 ? '-' : ''}\$${v.abs().toStringAsFixed(2)}', style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w600, color: highlight ? Colors.green : null, fontSize: bold ? 18 : 14))]));
}
