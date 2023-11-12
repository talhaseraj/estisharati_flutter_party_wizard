import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class RatingStarRow extends StatelessWidget {
  final double rating; // The rating value, typically from 1 to 5.
  final double size;

  const RatingStarRow({super.key, required this.rating, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(5, (index) {
            return Icon(
              Icons.star_rounded,
              color: index < rating ? AppColors.c_ffc640 : Colors.grey.shade300,
              size: size,
            );
          }),
        ),
        Text(
          "($rating)",
          style: const TextStyle(color: AppColors.c_77838f),
        )
      ],
    );
  }
}
