import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import '../mock/models.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;
  const PrimaryButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.icon,
      this.expanded = true});
  @override
  Widget build(BuildContext context) {
    final btn = FilledButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      style: FilledButton.styleFrom(
          minimumSize: const Size(44, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
    );
    return expanded ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool expanded;
  const SecondaryButton(
      {super.key, required this.label, this.onPressed, this.expanded = true});
  @override
  Widget build(BuildContext context) {
    final btn = OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            minimumSize: const Size(44, 48),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))),
        child: Text(label));
    return expanded ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? prefix;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int maxLines;
  const CustomTextField(
      {super.key,
      required this.label,
      this.hint,
      this.prefix,
      this.suffix,
      this.obscure = false,
      this.keyboard,
      this.validator,
      this.controller,
      this.maxLines = 1});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: prefix != null ? Icon(prefix) : null,
            suffixIcon: suffix));
  }
}

class PriceText extends StatelessWidget {
  final double price;
  final double? original;
  final int? discount;
  final double size;
  const PriceText(
      {super.key,
      required this.price,
      this.original,
      this.discount,
      this.size = 18});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          Text('\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: size,
                  fontWeight: FontWeight.w800,
                  color: cs.primary)),
          if (original != null && original! > price)
            Text('\$${original!.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: size - 4,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey)),
          if (discount != null && discount! > 0)
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8)),
                child: Text('-$discount%',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 12))),
        ]);
  }
}

class RatingStars extends StatelessWidget {
  final double rating;
  final int? count;
  final double size;
  const RatingStars(
      {super.key, required this.rating, this.count, this.size = 14});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      RatingBarIndicator(
          rating: rating,
          itemBuilder: (_, __) =>
              const Icon(Icons.star_rounded, color: Colors.amber),
          itemCount: 5,
          itemSize: size),
      const SizedBox(width: 4),
      Text(rating.toStringAsFixed(1),
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: size - 1)),
      if (count != null)
        Text(' ($count)',
            style: TextStyle(color: Colors.grey, fontSize: size - 2)),
    ]);
  }
}

class QuantityStepper extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const QuantityStepper(
      {super.key, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
            onPressed: value > 1 ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove),
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44)),
        Text('$value', style: const TextStyle(fontWeight: FontWeight.w700)),
        IconButton(
            onPressed: () => onChanged(value + 1),
            icon: const Icon(Icons.add),
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44)),
      ]),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;
  const SectionHeader(
      {super.key, required this.title, this.action, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(children: [
          Expanded(
              child: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800))),
          if (action != null)
            TextButton(onPressed: onTap, child: Text(action!)),
        ]));
  }
}

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  const EmptyState(
      {super.key,
      required this.icon,
      required this.title,
      required this.message,
      this.actionLabel,
      this.onAction});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon, size: 72, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(message,
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center),
              if (actionLabel != null) ...[
                const SizedBox(height: 16),
                PrimaryButton(
                    label: actionLabel!, onPressed: onAction, expanded: false)
              ],
            ])));
  }
}

class LoadingSkeleton extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;
  const LoadingSkeleton(
      {super.key, required this.height, this.width, this.radius = 12});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius))),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BoxFit fit;
  final BorderRadius? radius;
  const ProductImage(
      {super.key,
      required this.url,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.radius});
  @override
  Widget build(BuildContext context) {
    final img = CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        placeholder: (_, __) =>
            LoadingSkeleton(height: height ?? 120, width: width, radius: 0),
        errorWidget: (_, __, ___) => Container(
            color: Colors.grey.shade200,
            child: const Icon(Icons.image_not_supported_outlined,
                color: Colors.grey)));
    return radius != null ? ClipRRect(borderRadius: radius!, child: img) : img;
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;
  const ProductCard(
      {super.key,
      required this.product,
      required this.onTap,
      this.onFavorite,
      this.isFavorite = false});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Card(
            clipBehavior: Clip.antiAlias,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Stack(fit: StackFit.expand, children: [
              ProductImage(url: product.imageUrl, fit: BoxFit.cover),
              Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text('-${product.discount}%',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 11)))),
              Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                      onPressed: onFavorite,
                      icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey),
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          minimumSize: const Size(44, 44)))),
            ]),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.brand,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, height: 1.2)),
                    const SizedBox(height: 4),
                    RatingStars(
                        rating: product.rating,
                        count: product.reviewCount,
                        size: 13),
                    const SizedBox(height: 4),
                    PriceText(
                        price: product.price,
                        original: product.originalPrice,
                        discount: null,
                        size: 16),
                  ])),
        ])));
  }
}
