import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/auth_screens.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/catalog/presentation/catalog_screen.dart';
import '../../features/product/presentation/product_detail_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/checkout/presentation/checkout_screens.dart';
import '../../features/orders/presentation/orders_screens.dart';
import '../../features/account/presentation/account_screens.dart';
import '../../features/wishlist/presentation/wishlist_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});
  int _index(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/catalog')) return 1;
    if (loc.startsWith('/cart')) return 2;
    if (loc.startsWith('/orders')) return 3;
    if (loc.startsWith('/account')) return 4;
    return 0;
  }
  @override Widget build(BuildContext context) {
    final i = _index(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        onDestinationSelected: (idx) {
          switch (idx) { case 0: context.go('/home'); break; case 1: context.go('/catalog'); break; case 2: context.go('/cart'); break; case 3: context.go('/orders'); break; case 4: context.go('/account'); break; }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Shop'),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

GoRouter createRouter() => GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/onboarding',
  routes: [
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(path: '/welcome', builder: (_, __) => const WelcomeScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),
    GoRoute(path: '/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),
    GoRoute(path: '/otp', builder: (_, __) => const OtpScreen()),
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (_, __, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/catalog', builder: (_, st) => CatalogScreen(category: st.uri.queryParameters['category'])),
        GoRoute(path: '/cart', builder: (_, __) => const CartScreen()),
        GoRoute(path: '/orders', builder: (_, __) => const OrdersScreen()),
        GoRoute(path: '/account', builder: (_, __) => const AccountScreen()),
      ],
    ),
    GoRoute(path: '/product/:id', builder: (_, st) => ProductDetailScreen(productId: st.pathParameters['id']!)),
    GoRoute(path: '/checkout', builder: (_, __) => const CheckoutScreen()),
    GoRoute(path: '/order-confirmation/:id', builder: (_, st) => OrderConfirmationScreen(orderId: st.pathParameters['id']!)),
    GoRoute(path: '/order-detail/:id', builder: (_, st) => OrderDetailScreen(orderId: st.pathParameters['id']!)),
    GoRoute(path: '/order-tracking/:id', builder: (_, st) => OrderTrackingScreen(orderId: st.pathParameters['id']!)),
    GoRoute(path: '/wishlist', builder: (_, __) => const WishlistScreen()),
    GoRoute(path: '/search', builder: (_, __) => const SearchScreen()),
    GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    GoRoute(path: '/addresses', builder: (_, __) => const AddressesScreen()),
    GoRoute(path: '/payments', builder: (_, __) => const PaymentsScreen()),
  ],
);
