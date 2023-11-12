import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class SeeMoreTextWidget extends StatefulWidget {
  const SeeMoreTextWidget({super.key});

  @override
  _SeeMoreTextWidgetState createState() => _SeeMoreTextWidgetState();
}

class _SeeMoreTextWidgetState extends State<SeeMoreTextWidget> {
  bool _showMoreText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Maecenas interdum lorem effendi orci aliquam mollis. Aliquam non rhoncus magna. Suspendisse aliquet tincidunt enim, ut commodo elit feugiat et. Maecenas nec enim quis diam faucibus tristique. Nam fermentum, ipsum in suscipit pharetra, mi odio aliquet neque, non iaculis augue elit et libero. Phasellus tempor faucibus faucibus. Sed eu mauris sem. Etiam et varius felis. Donec et libero vitae mauris consectetur egestas. Fusce aliquet, augue non efficitur sodales, turpis nisl consectetur sem, at rutrum lectus libero quis elit. Suspendisse cursus laoreet sapien, in lobortis justo posuere vitae. Aliquam commodo posuere tellus in lacinia. Nullam ac eleifend odio. Donec aliquam semper tellus a condimentum.',
          style: const TextStyle(color: AppColors.c_77838f, fontSize: 14),
          maxLines: _showMoreText ? 3 : null,
          textAlign: TextAlign.justify,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _showMoreText = !_showMoreText;
            });
          },
          child: Text(
            !_showMoreText ? 'See Less' : 'See More',
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
