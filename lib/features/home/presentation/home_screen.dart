import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/state/app_state.dart';
import '../../../core/widgets/common_widgets.dart';

class HomeScreen extends StatefulWidget { const HomeScreen({super.key}); @override State<HomeScreen> createState() => _HomeScreenState(); }
class _HomeScreenState extends State<HomeScreen> {
  int _banner = 0;
  late Timer _timer;
  Duration _dealEnds = const Duration(hours: 5, minutes: 42, seconds: 18);
  @override void initState() { super.initState(); _timer = Timer.periodic(const Duration(seconds: 1), (_) { if (mounted) setState(() => _dealEnds = _dealEnds - const Duration(seconds: 1)); }); }
  @override void dispose() { _timer.cancel(); super.dispose(); }

  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final products = MockData.products;
    return Scaffold(
      body: RefreshIndicator(onRefresh: () async => await Future.delayed(const Duration(milliseconds: 800)),
        child: CustomScrollView(slivers: [
          SliverAppBar(pinned: true, floating: true, toolbarHeight: 72, title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InkWell(onTap: () => context.push('/search'), child: Container(height: 44, padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(14)), child: const Row(children: [Icon(Icons.search), SizedBox(width: 8), Expanded(child: Text('Search products, brands...', style: TextStyle(color: Colors.grey))), Icon(Icons.mic_none)]))),
          ]), actions: [
            IconButton(onPressed: () => context.push('/notifications'), icon: Badge(label: Text('${app.unreadCount}'), isLabelVisible: app.unreadCount > 0, child: const Icon(Icons.notifications_none))),
          ], bottom: PreferredSize(preferredSize: const Size.fromHeight(32), child: Padding(padding: const EdgeInsets.fromLTRB(16,0,16,8), child: Row(children: const [Icon(Icons.location_on_outlined, size: 16, color: Colors.grey), SizedBox(width: 4), Expanded(child: Text('Deliver to: Home · 221B Market Street, San Francisco', style: TextStyle(fontSize: 12, color: Colors.grey), overflow: TextOverflow.ellipsis)), Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey)])))),
          SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 170, child: PageView.builder(itemCount: MockData.promos.length, onPageChanged: (i) => setState(() => _banner = i), itemBuilder: (_, i) {
              final p = MockData.promos[i];
              return Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: ClipRRect(borderRadius: BorderRadius.circular(18), child: Stack(fit: StackFit.expand, children: [
                ProductImage(url: p.imageUrl),
                Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black.withOpacity(0.55), Colors.transparent], begin: Alignment.bottomLeft, end: Alignment.topRight))),
                Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(p.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                  Text(p.subtitle, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  FilledButton.tonal(onPressed: () => context.go('/catalog'), child: Text('Use code ${p.code}')),
                ])),
              ])));
            })),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(MockData.promos.length, (i) => Container(margin: const EdgeInsets.all(3), height: 6, width: _banner == i ? 18 : 6, decoration: BoxDecoration(color: _banner == i ? Theme.of(context).colorScheme.primary : Colors.grey.shade400, borderRadius: BorderRadius.circular(6))))),
            const SectionHeader(title: 'Categories'),
            SizedBox(height: 96, child: ListView.separated(padding: const EdgeInsets.symmetric(horizontal: 16), scrollDirection: Axis.horizontal, itemBuilder: (_, i) {
              final c = MockData.categories[i];
              return InkWell(onTap: () => context.go('/catalog?category=${c.name}'), child: Column(children: [
                CircleAvatar(radius: 28, backgroundImage: NetworkImage(c.imageUrl)),
                const SizedBox(height: 6), SizedBox(width: 72, child: Text(c.name, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12))),
              ]));
            }, separatorBuilder: (_, __) => const SizedBox(width: 8), itemCount: MockData.categories.length)),
            Padding(padding: const EdgeInsets.fromLTRB(16,8,16,8), child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(16)), child: Row(children: [
              const Icon(Icons.flash_on, color: Colors.deepOrange), const SizedBox(width: 8), const Expanded(child: Text('Flash Deals', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black87))),
              _count(_dealEnds.inHours % 24), const Text(' : ', style: TextStyle(color: Colors.black87)), _count(_dealEnds.inMinutes % 60), const Text(' : ', style: TextStyle(color: Colors.black87)), _count(_dealEnds.inSeconds % 60),
            ]))),
            SizedBox(height: 250, child: ListView.separated(padding: const EdgeInsets.symmetric(horizontal: 16), scrollDirection: Axis.horizontal, itemBuilder: (_, i) {
              final p = products[i % products.length];
              return SizedBox(width: 170, child: ProductCard(product: p, isFavorite: app.isFavorite(p.id), onFavorite: () => app.toggleFavorite(p.id), onTap: () => context.push('/product/${p.id}')));
            }, separatorBuilder: (_, __) => const SizedBox(width: 12), itemCount: 5)),
            const SectionHeader(title: 'Trending Now', action: 'See all'),
            SizedBox(height: 250, child: ListView.separated(padding: const EdgeInsets.symmetric(horizontal: 16), scrollDirection: Axis.horizontal, itemBuilder: (_, i) {
              final p = products.reversed.toList()[i % products.length];
              return SizedBox(width: 170, child: ProductCard(product: p, isFavorite: app.isFavorite(p.id), onFavorite: () => app.toggleFavorite(p.id), onTap: () => context.push('/product/${p.id}')));
            }, separatorBuilder: (_, __) => const SizedBox(width: 12), itemCount: 5)),
            const SectionHeader(title: 'New Arrivals'),
            _grid(context, products.take(4).toList(), app),
            const SectionHeader(title: 'Recommended for You'),
            _grid(context, products, app),
            const SectionHeader(title: 'Top Brands'),
            SizedBox(height: 56, child: ListView.separated(padding: const EdgeInsets.symmetric(horizontal: 16), scrollDirection: Axis.horizontal, itemBuilder: (_, i) => Chip(label: Text(MockData.brands[i])), separatorBuilder: (_, __) => const SizedBox(width: 8), itemCount: MockData.brands.length)),
            const SizedBox(height: 24),
          ])),
        ]),
      ),
    );
  }

  Widget _count(int v) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)), child: Text(v.toString().padLeft(2,'0'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)));
  Widget _grid(BuildContext context, List products, AppState app) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 220, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.62), itemCount: products.length, itemBuilder: (_, i) {
    final p = products[i];
    return ProductCard(product: p, isFavorite: app.isFavorite(p.id), onFavorite: () => app.toggleFavorite(p.id), onTap: () => context.push('/product/${p.id}'));
  }));
}
