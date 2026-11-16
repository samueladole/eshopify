class Product {
  final String id;
  final String title;
  final String brand;
  final double price;
  final double originalPrice;
  final int discount;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final List<String> images;
  final List<String> colors;
  final List<String> sizes;
  final bool inStock;
  final String description;
  final String deliveryEstimate;
  final String category;
  final String returnPolicy;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.inStock,
    required this.description,
    required this.deliveryEstimate,
    required this.category,
    this.returnPolicy = 'Free 30-day returns',
    this.specs = const {},
  });
}

class Category {
  final String id;
  final String name;
  final String icon;
  final String imageUrl;

  const Category({required this.id, required this.name, required this.icon, required this.imageUrl});
}

class Review {
  final String id;
  final String user;
  final double rating;
  final String comment;
  final String date;

  const Review({required this.id, required this.user, required this.rating, required this.comment, required this.date});
}

class CartItem {
  final Product product;
  int quantity;
  final String color;
  final String size;

  CartItem({required this.product, this.quantity = 1, required this.color, required this.size});
}

class Address {
  final String id;
  final String label;
  final String name;
  final String line1;
  final String city;
  final String zip;
  final String phone;
  bool isDefault;

  Address({required this.id, required this.label, required this.name, required this.line1, required this.city, required this.zip, required this.phone, this.isDefault = false});
}

class PaymentMethod {
  final String id;
  final String type;
  final String label;
  final String details;
  final String icon;

  const PaymentMethod({required this.id, required this.type, required this.label, required this.details, required this.icon});
}

class OrderItem {
  final Product product;
  final int quantity;
  final String color;
  final String size;

  const OrderItem({required this.product, required this.quantity, required this.color, required this.size});
}

class Order {
  final String id;
  final DateTime date;
  final double total;
  final String status; // Active, Completed, Cancelled, Returned
  final String trackingStatus;
  final List<OrderItem> items;
  final String addressSummary;

  const Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.trackingStatus,
    required this.items,
    required this.addressSummary,
  });
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final String type; // order, promo, price
  final DateTime time;
  bool read;

  AppNotification({required this.id, required this.title, required this.message, required this.type, required this.time, this.read = false});
}

class Promo {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String code;

  const Promo({required this.id, required this.title, required this.subtitle, required this.imageUrl, required this.code});
}
