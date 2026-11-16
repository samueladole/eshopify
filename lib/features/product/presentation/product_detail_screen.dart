import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/state/app_state.dart';
import '../../../core/widgets/common_widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});
  @override State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _img = 0; String? _color; String? _size; int _qty = 1; bool _expanded = false;
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final p = MockData.products.firstWhere((e) => e.id == widget.productId, orElse: () => MockData.products.first);
    _color ??= p.colors.first; _size ??= p.sizes.first;
    return Scaffold(
      appBar: AppBar(title: Text(p.brand), actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)), IconButton(onPressed: () => app.toggleFavorite(p.id), icon: Icon(app.isFavorite(p.id) ? Icons.favorite : Icons.favorite_border, color: app.isFavorite(p.id) ? Colors.red : null))]),
      body: ListView(children: [
        AspectRatio(aspectRatio: 1, child: PageView.builder(itemCount: p.images.length, onPageChanged: (i) => setState(() => _img = i), itemBuilder: (_, i) => InteractiveViewer(child: ProductImage(url: p.images[i], fit: BoxFit.cover)))),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(p.images.length, (i) => Container(margin: const EdgeInsets.all(4), height: 8, width: _img == i ? 20 : 8, decoration: BoxDecoration(color: _img == i ? Theme.of(context).colorScheme.primary : Colors.grey.shade400, borderRadius: BorderRadius.circular(8))))),
        Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(p.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Row(children: [RatingStars(rating: p.rating, count: p.reviewCount), const SizedBox(width: 8), Text('${p.reviewCount} reviews', style: const TextStyle(color: Colors.grey))]),
          const SizedBox(height: 12),
          PriceText(price: p.price, original: p.originalPrice, discount: p.discount, size: 24),
          const SizedBox(height: 16),
          const Text('Color', style: TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 8),
          Wrap(spacing: 8, children: p.colors.map((c) => ChoiceChip(label: Text(c), selected: _color == c, onSelected: (_) => setState(() => _color = c))).toList()),
          const SizedBox(height: 16),
          const Text('Size', style: TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 8),
          Wrap(spacing: 8, children: p.sizes.map((s) => ChoiceChip(label: Text(s), selected: _size == s, onSelected: (_) => setState(() => _size = s))).toList()),
          const SizedBox(height: 16),
          Row(children: [const Text('Quantity', style: TextStyle(fontWeight: FontWeight.w700)), const Spacer(), QuantityStepper(value: _qty, onChanged: (v) => setState(() => _qty = v))]),
          const SizedBox(height: 16),
          _info(Icons.local_shipping_outlined, 'Delivery', p.deliveryEstimate),
          _info(Icons.assignment_return_outlined, 'Returns', p.returnPolicy),
          _info(Icons.inventory_2_outlined, 'Availability', p.inStock ? 'In stock' : 'Out of stock'),
          const Divider(height: 32),
          const Text('Description', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)), const SizedBox(height: 8),
          Text(p.description, maxLines: _expanded ? null : 3, overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis),
          TextButton(onPressed: () => setState(() => _expanded = !_expanded), child: Text(_expanded ? 'Show less' : 'Read more')),
          const Divider(height: 32),
          const Text('Specifications', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)), const SizedBox(height: 8),
          ...p.specs.entries.map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [Expanded(child: Text(e.key, style: const TextStyle(color: Colors.grey))), Expanded(child: Text(e.value, style: const TextStyle(fontWeight: FontWeight.w600)))]))),
          const Divider(height: 32),
          Row(children: [const Text('Customer Reviews', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)), const Spacer(), TextButton(onPressed: () {}, child: const Text('See all'))]),
          ...MockData.reviews.map((r) => ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(child: Text(r.user[0])), title: Text(r.user, style: const TextStyle(fontWeight: FontWeight.w600)), subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [RatingStars(rating: r.rating), const SizedBox(height: 4), Text(r.comment), const SizedBox(height: 2), Text(r.date, style: const TextStyle(color: Colors.grey, fontSize: 12))]))),
          const Divider(height: 32),
          const Text('Related Products', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)), const SizedBox(height: 12),
          SizedBox(height: 250, child: ListView.separated(scrollDirection: Axis.horizontal, itemBuilder: (_, i) { final rp = MockData.products.where((x) => x.id != p.id).toList()[i]; return SizedBox(width: 170, child: ProductCard(product: rp, isFavorite: app.isFavorite(rp.id), onFavorite: () => app.toggleFavorite(rp.id), onTap: () => context.push('/product/${rp.id}'))); }, separatorBuilder: (_, __) => const SizedBox(width: 12), itemCount: MockData.products.length - 1)),
          const SizedBox(height: 100),
        ])),
      ]),
      bottomNavigationBar: SafeArea(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]), child: Row(children: [
        Expanded(child: SecondaryButton(label: 'Add to Cart', onPressed: () { app.addToCart(p, color: _color, size: _size, qty: _qty); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${p.title} to cart'), action: SnackBarAction(label: 'VIEW CART', onPressed: () => context.go('/cart')))); })),
        const SizedBox(width: 12),
        Expanded(child: PrimaryButton(label: 'Buy Now', onPressed: () { app.addToCart(p, color: _color, size: _size, qty: _qty); context.push('/checkout'); })),
      ]))),
    );
  }

  Widget _info(IconData i, String t, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [Icon(i, size: 20, color: Colors.grey), const SizedBox(width: 10), Text('$t: ', style: const TextStyle(fontWeight: FontWeight.w600)), Expanded(child: Text(v))]));
}
