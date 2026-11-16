import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/mock/models.dart';
import '../../../core/state/app_state.dart';
import '../../../core/widgets/common_widgets.dart';

class CatalogScreen extends StatefulWidget {
  final String? category;
  const CatalogScreen({super.key, this.category});
  @override State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  bool _grid = true;
  String _sort = 'Recommended';
  RangeValues _price = const RangeValues(0, 500);
  double _minRating = 0;
  final Set<String> _brands = {};
  bool _loading = false;

  List<Product> get _filtered {
    var list = MockData.products.where((p) => widget.category == null || p.category == widget.category).toList();
    list = list.where((p) => p.price >= _price.start && p.price <= _price.end && p.rating >= _minRating && (_brands.isEmpty || _brands.contains(p.brand))).toList();
    switch (_sort) {
      case 'Price: low to high': list.sort((a,b)=>a.price.compareTo(b.price)); break;
      case 'Price: high to low': list.sort((a,b)=>b.price.compareTo(a.price)); break;
      case 'Newest': list = list.reversed.toList(); break;
      case 'Best rating': list.sort((a,b)=>b.rating.compareTo(a.rating)); break;
    }
    return list;
  }

  Future<void> _refresh() async { setState(() => _loading = true); await Future.delayed(const Duration(milliseconds: 700)); if (mounted) setState(() => _loading = false); }

  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final items = _filtered;
    return Scaffold(
      appBar: AppBar(title: Text(widget.category ?? 'Shop'), actions: [IconButton(onPressed: () => setState(() => _grid = !_grid), icon: Icon(_grid ? Icons.view_list : Icons.grid_view))]),
      body: RefreshIndicator(onRefresh: _refresh, child: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(16,8,16,8), child: Row(children: [
          OutlinedButton.icon(onPressed: _openFilter, icon: const Icon(Icons.tune), label: const Text('Filter')),
          const SizedBox(width: 8),
          OutlinedButton.icon(onPressed: _openSort, icon: const Icon(Icons.sort), label: const Text('Sort')),
          const Spacer(),
          Text('${items.length} products', style: const TextStyle(color: Colors.grey)),
        ])),
        Expanded(child: _loading ? _skeleton() : items.isEmpty ? const EmptyState(icon: Icons.search_off, title: 'No products found', message: 'Try adjusting your filters to see more results.') : _grid ? GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 220, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.62), itemCount: items.length, itemBuilder: (_, i) => ProductCard(product: items[i], isFavorite: app.isFavorite(items[i].id), onFavorite: () => app.toggleFavorite(items[i].id), onTap: () => context.push('/product/${items[i].id}'))) : ListView.separated(padding: const EdgeInsets.all(16), itemCount: items.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (_, i) => _listTile(items[i], app))),
      ])),
    );
  }

  Widget _listTile(Product p, AppState app) => InkWell(onTap: () => context.push('/product/${p.id}'), child: Card(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
    SizedBox(width: 110, height: 110, child: ProductImage(url: p.imageUrl, radius: BorderRadius.circular(12))),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(p.brand, style: const TextStyle(color: Colors.grey)), Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 4), RatingStars(rating: p.rating, count: p.reviewCount), const SizedBox(height: 6), PriceText(price: p.price, original: p.originalPrice, discount: p.discount, size: 16)])),
    IconButton(onPressed: () => app.toggleFavorite(p.id), icon: Icon(app.isFavorite(p.id) ? Icons.favorite : Icons.favorite_border, color: app.isFavorite(p.id) ? Colors.red : null)),
  ]))));

  Widget _skeleton() => GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 220, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.62), itemCount: 6, itemBuilder: (_, __) => const Column(children: [Expanded(child: LoadingSkeleton(height: 200)), SizedBox(height: 8), LoadingSkeleton(height: 14), SizedBox(height: 6), LoadingSkeleton(height: 14, width: 100)]));

  void _openSort() => showModalBottomSheet(context: context, showDragHandle: true, builder: (_) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: ['Recommended','Price: low to high','Price: high to low','Newest','Best rating'].map((s) => RadioListTile<String>(title: Text(s), value: s, groupValue: _sort, onChanged: (v) { setState(() => _sort = v!); Navigator.pop(context); })).toList())));
  void _openFilter() => showModalBottomSheet(context: context, isScrollControlled: true, showDragHandle: true, builder: (_) => StatefulBuilder(builder: (ctx, setM) => DraggableScrollableSheet(expand: false, initialChildSize: 0.75, builder: (_, c) => ListView(controller: c, padding: const EdgeInsets.all(16), children: [
    const Text('Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
    const SizedBox(height: 12), const Text('Price range', style: TextStyle(fontWeight: FontWeight.w600)),
    RangeSlider(values: _price, min: 0, max: 500, divisions: 20, labels: RangeLabels('\$${_price.start.round()}', '\$${_price.end.round()}'), onChanged: (v) { setM(() => _price = v); setState(() => _price = v); }),
    const SizedBox(height: 8), const Text('Brand', style: TextStyle(fontWeight: FontWeight.w600)),
    Wrap(spacing: 8, children: MockData.brands.map((b) => FilterChip(label: Text(b), selected: _brands.contains(b), onSelected: (s) { setM(() { s ? _brands.add(b) : _brands.remove(b); }); setState((){}); })).toList()),
    const SizedBox(height: 12), const Text('Rating', style: TextStyle(fontWeight: FontWeight.w600)),
    Slider(value: _minRating, min: 0, max: 5, divisions: 5, label: '${_minRating.toStringAsFixed(1)}+', onChanged: (v) { setM(() => _minRating = v); setState(() => _minRating = v); }),
    const SizedBox(height: 12), const Text('Color'), Wrap(spacing: 8, children: ['Black','White','Blue','Red','Green'].map((c) => FilterChip(label: Text(c), selected: false, onSelected: (_) {})).toList()),
    const SizedBox(height: 12), const Text('Size'), Wrap(spacing: 8, children: ['S','M','L','XL','One Size'].map((c) => FilterChip(label: Text(c), selected: false, onSelected: (_) {})).toList()),
    const SizedBox(height: 12), SwitchListTile(title: const Text('Fast delivery'), value: true, onChanged: (_) {}),
    const SizedBox(height: 16), PrimaryButton(label: 'Apply Filters', onPressed: () => Navigator.pop(context)),
  ]))));
}
