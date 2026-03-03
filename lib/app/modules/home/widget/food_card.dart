import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double? rating;
  final double? price;
  final VoidCallback? onAdd;

  final double? cardHeight;
  final bool showRating;
  final bool showPrice;
  final bool showAddButton;
  final bool showFullImage;
  final bool isFullWidth;
  final double borderRadiusValue = 10.0;
  const FoodCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.rating,
    this.price,
    this.onAdd,
    this.cardHeight,
    this.showRating = true,
    this.showPrice = true,
    this.showAddButton = true,
    this.showFullImage = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = isFullWidth ? screenWidth : screenWidth * 0.45;
    double imageHeight = cardHeight ?? cardWidth * 0.55;

    return SizedBox(
      width: cardWidth,
      child: Card(
        elevation: 0.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadiusValue),
                  child: Image.network(
                    imageUrl,
                    height: showFullImage ? cardHeight ?? 200 : imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (showAddButton && onAdd != null)
                  Positioned(
                    right: 6,
                    bottom: 6,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: onAdd,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (showRating && rating != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                            (index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: cardWidth * 0.05,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "(${rating!.toStringAsFixed(1)})",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: cardWidth * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
            if (showPrice && price != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Tk ${price!.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
