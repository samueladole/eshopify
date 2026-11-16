import 'package:flutter/material.dart';
import '../mock/models.dart';
import '../mock/mock_data.dart';

class AppState extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  final List<CartItem> cart = [];
  final Set<String> wishlist = {};
  final List<Order> orders = MockData.sampleOrders();
  final List<Address> addresses = List.from(MockData.addresses);
  final List<AppNotification> notifications = List.from(MockData.notifications);
  String selectedAddressId = MockData.addresses.first.id;
  String selectedPaymentId = MockData.paymentMethods.first.id;
  String deliveryMethod = 'Standard (Free, 3-5 days)';
  String language = 'English';
  String currency = 'USD';
  bool promoNotifications = true;
  bool orderNotifications = true;

  int get cartCount => cart.fold(0, (s, i) => s + i.quantity);
  bool isFavorite(String id) => wishlist.contains(id);

  void toggleTheme(ThemeMode mode) { themeMode = mode; notifyListeners(); }
  void toggleFavorite(String id) { wishlist.contains(id) ? wishlist.remove(id) : wishlist.add(id); notifyListeners(); }

  void addToCart(Product p, {String? color, String? size, int qty = 1}) {
    final c = color ?? (p.colors.isNotEmpty ? p.colors.first : 'Default');
    final s = size ?? (p.sizes.isNotEmpty ? p.sizes.first : 'One Size');
    final idx = cart.indexWhere((i) => i.product.id == p.id && i.color == c && i.size == s);
    if (idx >= 0) { cart[idx].quantity += qty; } else { cart.add(CartItem(product: p, quantity: qty, color: c, size: s)); }
    notifyListeners();
  }
  void updateQty(CartItem item, int qty) { item.quantity = qty.clamp(1, 99); notifyListeners(); }
  void removeFromCart(CartItem item) { cart.remove(item); notifyListeners(); }

  double get subtotal => cart.fold(0.0, (s, i) => s + i.product.price * i.quantity);
  double get shipping => cart.isEmpty ? 0 : (subtotal > 100 ? 0 : 7.99);
  double get discount => subtotal > 150 ? 15.0 : 0.0;
  double get tax => (subtotal - discount).clamp(0, double.infinity) * 0.08;
  double get total => (subtotal - discount).clamp(0, double.infinity) + shipping + tax;

  void selectAddress(String id) { selectedAddressId = id; notifyListeners(); }
  void addAddress(Address a) { addresses.add(a); notifyListeners(); }
  void selectPayment(String id) { selectedPaymentId = id; notifyListeners(); }

  Order placeOrder() {
    final order = Order(
      id: 'ORD-${1000 + orders.length + 25}',
      date: DateTime.now(),
      total: total,
      status: 'Active',
      trackingStatus: 'Ordered',
      items: cart.map((c) => OrderItem(product: c.product, quantity: c.quantity, color: c.color, size: c.size)).toList(),
      addressSummary: addresses.firstWhere((a) => a.id == selectedAddressId).line1,
    );
    orders.insert(0, order);
    cart.clear();
    notifyListeners();
    return order;
  }

  void markAllRead() { for (final n in notifications) n.read = true; notifyListeners(); }
  int get unreadCount => notifications.where((n) => !n.read).length;
  void setLanguage(String v){ language = v; notifyListeners(); }
  void setCurrency(String v){ currency = v; notifyListeners(); }
  void setOrderNotifications(bool v){ orderNotifications = v; notifyListeners(); }
  void setPromoNotifications(bool v){ promoNotifications = v; notifyListeners(); }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({super.key, required AppState notifier, required super.child}) : super(notifier: notifier);
  static AppState of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.notifier!;
  static AppState read(BuildContext context) => context.getInheritedWidgetOfExactType<AppStateScope>()!.notifier!;
}
