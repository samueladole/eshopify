import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/mock/mock_data.dart';
import '../../../core/mock/models.dart';
import '../../../core/state/app_state.dart';
import '../../../core/widgets/common_widgets.dart';

class CheckoutScreen extends StatefulWidget { const CheckoutScreen({super.key}); @override State<CheckoutScreen> createState() => _CheckoutScreenState(); }
class _CheckoutScreenState extends State<CheckoutScreen> {
  String _delivery = 'Standard (Free, 3-5 days)';
  bool _addingAddress = false;
  bool _addingCard = false;
  final _addrForm = GlobalKey<FormState>();
  final _cardForm = GlobalKey<FormState>();

  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    return Scaffold(appBar: AppBar(title: const Text('Checkout')), body: ListView(padding: const EdgeInsets.all(16), children: [
      _title('Delivery Address'),
      ...app.addresses.map((a) => Card(child: RadioListTile<String>(value: a.id, groupValue: app.selectedAddressId, onChanged: (v) => app.selectAddress(v!), title: Text('${a.label} · ${a.name}', style: const TextStyle(fontWeight: FontWeight.w600)), subtitle: Text('${a.line1}, ${a.city} ${a.zip}\n${a.phone}')))),
      TextButton.icon(onPressed: () => setState(() => _addingAddress = !_addingAddress), icon: const Icon(Icons.add), label: const Text('Add new address')),
      if (_addingAddress) Card(child: Padding(padding: const EdgeInsets.all(12), child: Form(key: _addrForm, child: Column(children: [
        CustomTextField(label: 'Label (Home/Office)', validator: (v)=>v!.isEmpty?'Required':null), const SizedBox(height: 8),
        CustomTextField(label: 'Full Name', validator: (v)=>v!.isEmpty?'Required':null), const SizedBox(height: 8),
        CustomTextField(label: 'Address Line', validator: (v)=>v!.isEmpty?'Required':null), const SizedBox(height: 8),
        CustomTextField(label: 'City, State', validator: (v)=>v!.isEmpty?'Required':null), const SizedBox(height: 8),
        CustomTextField(label: 'ZIP Code', validator: (v)=>v!.isEmpty?'Required':null), const SizedBox(height: 8),
        CustomTextField(label: 'Phone', validator: (v)=>v!.isEmpty?'Required':null), const SizedBox(height: 8),
        PrimaryButton(label: 'Save Address', onPressed: () { if (_addrForm.currentState!.validate()) { app.addAddress(Address(id: 'a${app.addresses.length+1}', label: 'New', name: 'Samuel Lee', line1: '123 New St', city: 'San Francisco, CA', zip: '94107', phone: '+1 415 555 0000')); setState(()=>_addingAddress=false); } })
      ])))),
      const SizedBox(height: 16),
      _title('Delivery Method'),
      ...['Standard (Free, 3-5 days)', 'Express (\$9.99, 1-2 days)', 'Same Day (\$19.99)'].map((m) => Card(child: RadioListTile<String>(value: m, groupValue: _delivery, onChanged: (v) => setState(() => _delivery = v!), title: Text(m)))),
      const SizedBox(height: 16),
      _title('Payment Method'),
      ...MockData.paymentMethods.map((pm) => Card(child: RadioListTile<String>(value: pm.id, groupValue: app.selectedPaymentId, onChanged: (v) => app.selectPayment(v!), title: Text(pm.label), subtitle: Text(pm.details), secondary: Icon(_icon(pm.type))))),
      TextButton.icon(onPressed: () => setState(() => _addingCard = !_addingCard), icon: const Icon(Icons.credit_card), label: const Text('Add card')),
      if (_addingCard) Card(child: Padding(padding: const EdgeInsets.all(12), child: Form(key: _cardForm, child: Column(children: [
        CustomTextField(label: 'Cardholder Name', validator: (v)=>v!.isEmpty?'Required':null), const SizedBox(height: 8),
        CustomTextField(label: 'Card Number', hint: '4242 4242 4242 4242', keyboard: TextInputType.number, validator: (v)=>(v?.length??0)<12?'Invalid':null), const SizedBox(height: 8),
        Row(children: [Expanded(child: CustomTextField(label: 'Expiry', hint: 'MM/YY', validator: (v)=>v!.isEmpty?'Required':null)), const SizedBox(width: 8), Expanded(child: CustomTextField(label: 'CVV', hint: '123', validator: (v)=>v!.isEmpty?'Required':null))]),
        const SizedBox(height: 8), PrimaryButton(label: 'Save Card', onPressed: () { if (_cardForm.currentState!.validate()) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Card saved (mock)'))); setState(()=>_addingCard=false);} })
      ])))),
      const SizedBox(height: 16),
      _title('Order Summary'),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        _row('Subtotal', app.subtotal), _row('Shipping', app.shipping), _row('Discount', -app.discount), _row('Tax', app.tax), const Divider(), _row('Total', app.total, bold: true),
      ]))),
      const SizedBox(height: 20),
      PrimaryButton(label: 'Place Order', icon: Icons.lock_outline, onPressed: () { if (app.cart.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your cart is empty'))); return; } final o = app.placeOrder(); context.go('/order-confirmation/${o.id}'); }),
      const SizedBox(height: 8), const Center(child: Text('Secure checkout · Your data is protected', style: TextStyle(color: Colors.grey))),
      const SizedBox(height: 24),
    ]));
  }
  Widget _title(String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)));
  Widget _row(String l, double v, {bool bold=false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children:[Text(l), const Spacer(), Text('${v<0?'-':''}\$${v.abs().toStringAsFixed(2)}', style: TextStyle(fontWeight: bold?FontWeight.w800:FontWeight.w600, fontSize: bold?18:14))]));
  IconData _icon(String t) { switch(t){case 'paypal': return Icons.account_balance_wallet; case 'apple_pay': return Icons.apple; case 'google_pay': return Icons.g_mobiledata; case 'cod': return Icons.payments_outlined; default: return Icons.credit_card;} }
}

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;
  const OrderConfirmationScreen({super.key, required this.orderId});
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final order = app.orders.firstWhere((o) => o.id == orderId, orElse: () => app.orders.first);
    return Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [
      const Spacer(),
      Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle), child: const Icon(Icons.check_circle, color: Colors.green, size: 72)),
      const SizedBox(height: 24),
      const Text('Order Placed!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      Text('Order ${order.id}', style: const TextStyle(color: Colors.grey, fontSize: 16)),
      const SizedBox(height: 16),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        _row('Estimated delivery', 'Thu, Nov 19, 2026'), _row('Items', '${order.items.length}'), _row('Total', '\$${order.total.toStringAsFixed(2)}'),
      ]))),
      const Spacer(),
      PrimaryButton(label: 'Track Order', onPressed: () => context.push('/order-tracking/$orderId')),
      const SizedBox(height: 12),
      SecondaryButton(label: 'Continue Shopping', onPressed: () => context.go('/home')),
    ]))));
  }
  Widget _row(String l, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children:[Text(l, style: const TextStyle(color: Colors.grey)), const Spacer(), Text(v, style: const TextStyle(fontWeight: FontWeight.w700))]));
}
