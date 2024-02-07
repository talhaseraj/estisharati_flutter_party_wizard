import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

Widget ShimmerLoading({required Widget child}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: child,
  );
}
