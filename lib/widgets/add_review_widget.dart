import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_wizard/widgets/see_more_widget.dart';

import '../../../../utils/app_colors.dart';
import '../constants/assets.dart';
import 'select_rating_star_row.dart';

class AddReviewsWidget extends StatefulWidget {
  final String imageUrl;
  const AddReviewsWidget({super.key, required this.imageUrl});

  @override
  State<AddReviewsWidget> createState() => _AddReviewsWidgetState();
}

class _AddReviewsWidgetState extends State<AddReviewsWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: size.width * .0125,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CloseButton(
                    color: Colors.transparent,
                  ),
                  Center(
                    child: Text(
                      'add_review'.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const CloseButton(),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .05,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: size.width * .2,
                          width: size.width * .2,
                          child: Card(
                            child:
                                CachedNetworkImage(imageUrl: widget.imageUrl),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .025,
                        ),
                        SizedBox(
                          height: size.width * .2,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pary Balloons",
                                style: TextStyle(
                                    color: AppColors.c_3e3e3e, fontSize: 14),
                              ),
                              Text(
                                "\$49.00",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                     SeeMoreTextWidget(text: "",),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              SizedBox(
                height: size.width * .05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "overall_rating".tr,
                          style: const TextStyle(
                              color: AppColors.brownishGrey, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * .025,
                    ),
                    SelectRatingStarRow(),
                    SizedBox(
                      height: size.width * .025,
                    ),
                    Row(
                      children: [
                        Text(
                          "written_review".tr,
                          style: const TextStyle(
                              color: AppColors.brownishGrey, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * .025,
                    ),
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.width * .1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  height: 60,
                  elevation: 0,
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    // Same as the button's shape
                  ),
                  child: Center(
                    child: Text(
                      'add_review'.tr,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
