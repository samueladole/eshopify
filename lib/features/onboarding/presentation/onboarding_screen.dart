import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/common_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  final _pages = const [
    (Icons.shopping_bag_outlined, 'Discover Premium Products', 'Browse curated collections from top brands with a seamless, modern shopping experience.'),
    (Icons.local_offer_outlined, 'Deals You’ll Love', 'Get flash deals, personalized recommendations, and exclusive offers tailored for you.'),
    (Icons.local_shipping_outlined, 'Fast & Secure Checkout', 'Track orders in real time and enjoy a smooth, trustworthy checkout every time.'),
  ];

  @override Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(child: Column(children: [
        Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => context.go('/welcome'), child: const Text('Skip'))),
        Expanded(child: PageView.builder(
          controller: _controller, itemCount: _pages.length,
          onPageChanged: (i) => setState(() => _page = i),
          itemBuilder: (_, i) {
            final p = _pages[i];
            return Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(height: 180, width: 180, decoration: BoxDecoration(color: cs.primaryContainer, shape: BoxShape.circle), child: Icon(p.$1, size: 80, color: cs.primary)),
              const SizedBox(height: 40),
              Text(p.$2, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              Text(p.$3, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, height: 1.5)),
            ]));
          },
        )),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_pages.length, (i) => AnimatedContainer(duration: const Duration(milliseconds: 250), margin: const EdgeInsets.all(4), height: 8, width: _page == i ? 24 : 8, decoration: BoxDecoration(color: _page == i ? cs.primary : Colors.grey.shade300, borderRadius: BorderRadius.circular(8))))),
        Padding(padding: const EdgeInsets.all(24), child: PrimaryButton(label: _page == _pages.length - 1 ? 'Get Started' : 'Next', onPressed: () {
          if (_page == _pages.length - 1) { context.go('/welcome'); } else { _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut); }
        })),
      ])),
    );
  }
}
