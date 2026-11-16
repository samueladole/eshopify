import 'models.dart';

class MockData {
  static const _img = 'https://images.unsplash.com';

  static final categories = <Category>[
    Category(id: 'c1', name: 'Electronics', icon: 'headphones', imageUrl: '$_img/photo-1498049794561-7780e7231661?w=400'),
    Category(id: 'c2', name: 'Fashion', icon: 'checkroom', imageUrl: '$_img/photo-1445205170230-053b83016050?w=400'),
    Category(id: 'c3', name: 'Home', icon: 'chair', imageUrl: '$_img/photo-1484101403633-562f891dc89a?w=400'),
    Category(id: 'c4', name: 'Beauty', icon: 'spa', imageUrl: '$_img/photo-1596462502278-27bfdc403348?w=400'),
    Category(id: 'c5', name: 'Sports', icon: 'fitness_center', imageUrl: '$_img/photo-1517836357463-d25dfeac3438?w=400'),
    Category(id: 'c6', name: 'Accessories', icon: 'watch', imageUrl: '$_img/photo-1523275335684-37898b6baf30?w=400'),
  ];

  static final brands = ['Sony', 'Apple', 'Nike', 'Samsung', 'Breville', 'CeraVe', 'IKEA', 'Spigen'];

  static final products = <Product>[
    Product(
      id: 'p1', title: 'Wireless Noise-Cancelling Headphones', brand: 'Sony',
      price: 249.99, originalPrice: 349.99, discount: 29, rating: 4.7, reviewCount: 2841,
      imageUrl: '$_img/photo-1505740420928-5e560c06d30e?w=800',
      images: ['$_img/photo-1505740420928-5e560c06d30e?w=800','$_img/photo-1484704849700-f032a568e944?w=800','$_img/photo-1583394838336-acd977736f90?w=800'],
      colors: ['Black', 'Silver', 'Blue'], sizes: ['Standard'], inStock: true,
      description: 'Premium over-ear headphones with industry-leading noise cancellation, 30-hour battery life, and crystal-clear call quality. Perfect for travel, work, and everyday listening.',
      deliveryEstimate: 'Delivery by Thu, Nov 19', category: 'Electronics',
      specs: {'Battery': '30 hours', 'Connectivity': 'Bluetooth 5.2', 'Weight': '250g', 'Driver': '40mm'},
    ),
    Product(
      id: 'p2', title: 'Smartwatch Series Pro', brand: 'Apple',
      price: 399.00, originalPrice: 449.00, discount: 11, rating: 4.8, reviewCount: 5120,
      imageUrl: '$_img/photo-1523275335684-37898b6baf30?w=800',
      images: ['$_img/photo-1523275335684-37898b6baf30?w=800','$_img/photo-1546868871-7041f2a55e12?w=800'],
      colors: ['Midnight', 'Starlight', 'Red'], sizes: ['41mm', '45mm'], inStock: true,
      description: 'Advanced health tracking, always-on display, and seamless connectivity. Track workouts, monitor heart health, and stay connected on the go.',
      deliveryEstimate: 'Delivery by Wed, Nov 18', category: 'Electronics',
      specs: {'Display': 'Always-On Retina', 'Water Resistance': '50m', 'Battery': '18 hours'},
    ),
    Product(
      id: 'p3', title: 'Air Zoom Running Shoes', brand: 'Nike',
      price: 119.95, originalPrice: 150.00, discount: 20, rating: 4.6, reviewCount: 1934,
      imageUrl: '$_img/photo-1542291026-7eec264c27ff?w=800',
      images: ['$_img/photo-1542291026-7eec264c27ff?w=800','$_img/photo-1606107557195-0e29a4b5b4aa?w=800'],
      colors: ['Red/White', 'Black', 'Blue'], sizes: ['7','8','9','10','11','12'], inStock: true,
      description: 'Responsive cushioning and breathable mesh upper designed for daily runs and all-day comfort.',
      deliveryEstimate: 'Delivery by Fri, Nov 20', category: 'Fashion',
      specs: {'Material': 'Mesh upper', 'Sole': 'Rubber', 'Support': 'Neutral'},
    ),
    Product(
      id: 'p4', title: 'Everyday Laptop Backpack', brand: 'Samsonite',
      price: 64.00, originalPrice: 89.00, discount: 28, rating: 4.5, reviewCount: 876,
      imageUrl: '$_img/photo-1553062407-98eeb64c6a62?w=800',
      images: ['$_img/photo-1553062407-98eeb64c6a62?w=800','$_img/photo-1622560480605-d83c853bc5c3?w=800'],
      colors: ['Charcoal', 'Navy'], sizes: ['One Size'], inStock: true,
      description: 'Durable water-resistant backpack with padded laptop compartment, USB pass-through, and organized pockets for work and travel.',
      deliveryEstimate: 'Delivery by Sat, Nov 21', category: 'Accessories',
      specs: {'Capacity': '24L', 'Laptop Fit': 'Up to 15.6"', 'Material': 'Polyester'},
    ),
    Product(
      id: 'p5', title: 'Precision Drip Coffee Maker', brand: 'Breville',
      price: 179.95, originalPrice: 229.95, discount: 22, rating: 4.4, reviewCount: 642,
      imageUrl: '$_img/photo-1495474472287-4d71bcdd2085?w=800',
      images: ['$_img/photo-1495474472287-4d71bcdd2085?w=800','$_img/photo-1517668808822-9ebb02f2a0e6?w=800'],
      colors: ['Stainless Steel', 'Black'], sizes: ['12 Cup'], inStock: true,
      description: 'Brew cafe-quality coffee at home with precise temperature control, programmable timer, and keep-warm function.',
      deliveryEstimate: 'Delivery by Mon, Nov 23', category: 'Home',
      specs: {'Capacity': '12 cups', 'Power': '1100W', 'Programmable': 'Yes'},
    ),
    Product(
      id: 'p6', title: 'Hydrating Skincare Set', brand: 'CeraVe',
      price: 42.50, originalPrice: 55.00, discount: 23, rating: 4.9, reviewCount: 3210,
      imageUrl: '$_img/photo-1556228720-195a672e8a03?w=800',
      images: ['$_img/photo-1556228720-195a672e8a03?w=800','$_img/photo-1571781926291-c477ebfd024b?w=800'],
      colors: ['Default'], sizes: ['Full Size', 'Travel Size'], inStock: true,
      description: 'Dermatologist-developed routine with cleanser, moisturizer, and serum for healthy, hydrated skin.',
      deliveryEstimate: 'Delivery by Thu, Nov 19', category: 'Beauty',
      specs: {'Skin Type': 'All', 'Fragrance': 'Free', 'Items': '3-piece set'},
    ),
    Product(
      id: 'p7', title: 'Minimalist LED Desk Lamp', brand: 'IKEA',
      price: 34.99, originalPrice: 49.99, discount: 30, rating: 4.3, reviewCount: 418,
      imageUrl: '$_img/photo-1507473885765-e6ed057f782c?w=800',
      images: ['$_img/photo-1507473885765-e6ed057f782c?w=800','$_img/photo-1513506003901-1e6a229e2d15?w=800'],
      colors: ['White', 'Black'], sizes: ['Standard'], inStock: true,
      description: 'Adjustable brightness and color temperature with a sleek design for focused work and cozy ambience.',
      deliveryEstimate: 'Delivery by Fri, Nov 20', category: 'Home',
      specs: {'Brightness': '5 levels', 'Color Temp': '2700K-6500K', 'USB': 'Yes'},
    ),
    Product(
      id: 'p8', title: 'MagSafe Smartphone Case', brand: 'Spigen',
      price: 29.99, originalPrice: 39.99, discount: 25, rating: 4.6, reviewCount: 7540,
      imageUrl: '$_img/photo-1601784551446-20c9e07cdbdb?w=800',
      images: ['$_img/photo-1601784551446-20c9e07cdbdb?w=800','$_img/photo-1592899677977-9c10ca588bbd?w=800'],
      colors: ['Clear', 'Black', 'Green'], sizes: ['iPhone 15', 'iPhone 15 Pro', 'iPhone 15 Pro Max'], inStock: true,
      description: 'Slim protective case with MagSafe compatibility, raised edges, and military-grade drop protection.',
      deliveryEstimate: 'Delivery by Wed, Nov 18', category: 'Accessories',
      specs: {'Protection': 'Military-grade', 'MagSafe': 'Compatible', 'Material': 'TPU + PC'},
    ),
  ];

  static final reviews = <Review>[
    const Review(id: 'r1', user: 'Ava M.', rating: 5, comment: 'Amazing quality and fast delivery. Exceeded expectations!', date: 'Nov 10, 2026'),
    const Review(id: 'r2', user: 'Liam K.', rating: 4, comment: 'Great product overall. Packaging was excellent.', date: 'Nov 8, 2026'),
    const Review(id: 'r3', user: 'Sophia R.', rating: 5, comment: 'Worth every penny. I would definitely buy again.', date: 'Nov 5, 2026'),
  ];

  static final addresses = <Address>[
    Address(id: 'a1', label: 'Home', name: 'Samuel Lee', line1: '221B Market Street', city: 'San Francisco, CA', zip: '94105', phone: '+1 415 555 0199', isDefault: true),
    Address(id: 'a2', label: 'Office', name: 'Samuel Lee', line1: '500 Mission St, Suite 200', city: 'San Francisco, CA', zip: '94105', phone: '+1 415 555 0199'),
  ];

  static final paymentMethods = <PaymentMethod>[
    const PaymentMethod(id: 'pm1', type: 'card', label: 'Visa ending 4242', details: 'Expires 08/28', icon: 'credit_card'),
    const PaymentMethod(id: 'pm2', type: 'paypal', label: 'PayPal', details: 'samuel@email.com', icon: 'account_balance_wallet'),
    const PaymentMethod(id: 'pm3', type: 'apple_pay', label: 'Apple Pay', details: 'Default device', icon: 'apple'),
    const PaymentMethod(id: 'pm4', type: 'google_pay', label: 'Google Pay', details: 'Available', icon: 'g_mobiledata'),
    const PaymentMethod(id: 'pm5', type: 'cod', label: 'Cash on Delivery', details: 'Pay when you receive', icon: 'payments'),
  ];

  static final promos = <Promo>[
    const Promo(id: 'pr1', title: 'Black Friday Early Access', subtitle: 'Up to 50% off electronics', imageUrl: '$_img/photo-1607082348824-0a96f2a4b9da?w=1200', code: 'BF50'),
    const Promo(id: 'pr2', title: 'Fresh Styles, Fresh Deals', subtitle: 'New fashion arrivals from \$29', imageUrl: '$_img/photo-1483985988355-763728e1935b?w=1200', code: 'STYLE20'),
    const Promo(id: 'pr3', title: 'Home Comfort Week', subtitle: 'Save on essentials for every room', imageUrl: '$_img/photo-1493663284031-b7e3aefcae8e?w=1200', code: 'HOME15'),
  ];

  static final notifications = <AppNotification>[
    AppNotification(id: 'n1', title: 'Order shipped', message: 'Your order #ORD-1024 is on the way.', type: 'order', time: DateTime.now().subtract(const Duration(hours: 2))),
    AppNotification(id: 'n2', title: 'Price drop alert', message: 'Smartwatch Series Pro is now \$399.00.', type: 'price', time: DateTime.now().subtract(const Duration(hours: 5))),
    AppNotification(id: 'n3', title: 'Weekend deals', message: 'Extra 15% off home essentials with code HOME15.', type: 'promo', time: DateTime.now().subtract(const Duration(days: 1)), read: true),
  ];

  static final recentSearches = ['headphones', 'running shoes', 'coffee maker', 'skincare'];
  static final trendingSearches = ['smartwatch deals', 'wireless earbuds', 'desk lamp', 'nike air zoom'];

  static List<Order> sampleOrders() {
    final p1 = products[0]; final p2 = products[2]; final p5 = products[4];
    return [
      Order(id: 'ORD-1024', date: DateTime.now().subtract(const Duration(days: 1)), total: 313.99, status: 'Active', trackingStatus: 'Shipped',
        items: [OrderItem(product: p1, quantity: 1, color: 'Black', size: 'Standard')],
        addressSummary: '221B Market Street, San Francisco'),
      Order(id: 'ORD-1018', date: DateTime.now().subtract(const Duration(days: 7)), total: 119.95, status: 'Completed', trackingStatus: 'Delivered',
        items: [OrderItem(product: p2, quantity: 1, color: 'Red/White', size: '10')],
        addressSummary: '221B Market Street, San Francisco'),
      Order(id: 'ORD-1009', date: DateTime.now().subtract(const Duration(days: 14)), total: 179.95, status: 'Completed', trackingStatus: 'Delivered',
        items: [OrderItem(product: p5, quantity: 1, color: 'Stainless Steel', size: '12 Cup')],
        addressSummary: '500 Mission St, San Francisco'),
      Order(id: 'ORD-0991', date: DateTime.now().subtract(const Duration(days: 20)), total: 64.00, status: 'Cancelled', trackingStatus: 'Cancelled',
        items: [OrderItem(product: products[3], quantity: 1, color: 'Charcoal', size: 'One Size')],
        addressSummary: '221B Market Street, San Francisco'),
    ];
  }
}
