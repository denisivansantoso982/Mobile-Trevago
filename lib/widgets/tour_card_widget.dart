import 'package:flutter/material.dart';
import 'package:trevago_app/utils/utils.dart';

class TourCardWidget extends StatelessWidget {
  const TourCardWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.location,
    this.price,
    this.label,
  });

  final String imageUrl;
  final String title;
  final String location;
  final String? price;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            blurRadius: 4,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyleUtils.semiboldDarkGray(16),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.place,
                            color: ColourUtils.gray,
                            size: 14,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            location,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyleUtils.regularGray(14),
                          ),
                        ],
                      ),
                      (price == null
                          ? const SizedBox()
                          : Text(
                              price!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyleUtils.semiboldBlue(18),
                            )),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: label == null
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: const BoxDecoration(
                        color: ColourUtils.blue,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(8)),
                      ),
                      child: Text(
                        label!,
                        style: TextStyleUtils.regularWhite(12),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}