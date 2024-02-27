import 'package:flutter/material.dart';

class SelectRatingStarRow extends StatefulWidget {
  final Function(int) onChanged;
  const SelectRatingStarRow({super.key, required this.onChanged});

  @override
  State<SelectRatingStarRow> createState() => _SelectRatingStarRowState();
}

class _SelectRatingStarRowState extends State<SelectRatingStarRow> {
  int rating = 1;

  void changeRating(int newRating) {
    setState(() {
      rating = newRating;
    });

    widget.onChanged(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () {
              changeRating(i);
            },
            child: Icon(
              i <= rating ? Icons.star_rounded : Icons.star_border_rounded,
              size: 40.0,
              color: i <= rating ? Colors.amber : Colors.grey.shade300,
            ),
          ),
      ],
    );
  }
}
