import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'package:get/get.dart';

import '../utils/helpers.dart';

class SeeMoreTextWidget extends StatefulWidget {
  final String text;
  const SeeMoreTextWidget({super.key, required this.text});

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
          Helpers.stripHtmlIfNeeded(widget.text),
          style: const TextStyle(
            color: AppColors.brownishGrey,
            fontSize: 14,
          ),
          maxLines: _showMoreText ? 3 : null,
          textAlign: TextAlign.justify,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _showMoreText = !_showMoreText; // Toggle visibility
            });
          },
          child: Text(
            !_showMoreText ? 'see_less'.tr : 'see_more'.tr,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
