import 'package:flutter/material.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/state/app_state.dart';
import '../../../core/widgets/common_widgets.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final items = MockData.products.where((p) => app.isFavorite(p.id)).toList();
    return Scaffold(appBar: AppBar(title: const Text('Wishlist')), body: RefreshIndicator(onRefresh: () async => await Future.delayed(const Duration(milliseconds: 600)),
      child: items.isEmpty ? ListView(children: const [SizedBox(height: 120), EmptyState(icon: Icons.favorite_border, title: 'Your wishlist is empty', message: 'Save products you love and find them here later.')]) : GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 220, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.58), itemCount: items.length, itemBuilder: (_, i) {
        final p = items[i];
        return Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Stack(children: [Positioned.fill(child: ProductImage(url: p.imageUrl, radius: const BorderRadius.vertical(top: Radius.circular(16)))), Positioned(top: 4, right: 4, child: IconButton(icon: const Icon(Icons.close), onPressed: () => app.toggleFavorite(p.id)))])),
          Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4), PriceText(price: p.price, size: 15),
            const SizedBox(height: 8),
            SizedBox(width: double.infinity, child: FilledButton.tonal(onPressed: () { app.addToCart(p); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Moved to cart'))); }, child: const Text('Move to Cart'))),
          ])),
        ]));
      }),
    ));
  }
}
