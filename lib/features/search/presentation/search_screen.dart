import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/state/app_state.dart';
import '../../../core/widgets/common_widgets.dart';

class SearchScreen extends StatefulWidget { const SearchScreen({super.key}); @override State<SearchScreen> createState() => _SearchScreenState(); }
class _SearchScreenState extends State<SearchScreen> {
  String _q = '';
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final results = _q.isEmpty ? [] : MockData.products.where((p) => p.title.toLowerCase().contains(_q.toLowerCase()) || p.brand.toLowerCase().contains(_q.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(title: TextField(autofocus: true, decoration: const InputDecoration(hintText: 'Search products, brands...', border: InputBorder.none), onChanged: (v) => setState(() => _q = v))),
      body: _q.isEmpty ? ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Recent searches', style: TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 8),
        ...MockData.recentSearches.map((s) => ListTile(leading: const Icon(Icons.history), title: Text(s), onTap: () => setState(() => _q = s))),
        const SizedBox(height: 16), const Text('Trending searches', style: TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: MockData.trendingSearches.map((s) => ActionChip(label: Text(s), onPressed: () => setState(() => _q = s))).toList()),
      ]) : results.isEmpty ? const EmptyState(icon: Icons.search_off, title: 'No results found', message: 'Try different keywords or check your spelling.') : GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 220, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.62), itemCount: results.length, itemBuilder: (_, i) => ProductCard(product: results[i], isFavorite: app.isFavorite(results[i].id), onFavorite: () => app.toggleFavorite(results[i].id), onTap: () => context.push('/product/${results[i].id}'))),
    );
  }
}
