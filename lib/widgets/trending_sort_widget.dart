// import 'package:flutter/material.dart';

// import '../../../utils/app_colors.dart';

// class TrendingSortWidget extends StatefulWidget {
//   final Function onPressed;

//   final String title;
//   final bool isSelected;

//   const TrendingSortWidget(
//       {super.key,
//       required this.onPressed,
//       required this.title,
//       required this.isSelected});

//   @override
//   State<TrendingSortWidget> createState() => _TrendingSortWidgetState();
// }

// class _TrendingSortWidgetState extends State<TrendingSortWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 500),
//       margin: EdgeInsets.only(
//           top: size.width * .025,
//           bottom: size.width * .025,
//           right: size.width * .025),
//       width: 100,
//       decoration: BoxDecoration(
//         gradient: widget.isSelected
//             ? AppColors.appThemeGradient
//             : const LinearGradient(colors: [Colors.white, Colors.white]),
//         borderRadius: BorderRadius.circular(15.0),
//         border: Border.all(
//           color: AppColors.c_f9f7f5, // Set the border color here
//           width: 1, // Set the border width
//         ),
//       ),
//       child: InkWell(
//         onTap: () => widget.onPressed(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//               widget.title,
//               style: TextStyle(
//                   color: widget.isSelected ? Colors.white : AppColors.c_707070),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
