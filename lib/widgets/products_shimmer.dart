import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../screens/shimmer.dart';

Widget ProductsShimmer(size) {
  return ShimmerLoading(
    child: GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 6,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5),
      itemBuilder: (ctx, index) {
        return Card(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Hero(
                        tag: "$index random", child: const Icon(Icons.image)),
                  ),
                  const Divider(),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        left: size.width * .05, right: size.width * .05),
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Urna mauris",
                          style: TextStyle(
                              color: AppColors.c_707070,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "\$99.00",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              Positioned(
                top: size.width * .025,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * .025,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        alignment: Alignment.center,
                        height: size.width * .065,
                        width: size.width * .125,
                        color: Colors.black,
                        child: const Text(
                          "-30%",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
