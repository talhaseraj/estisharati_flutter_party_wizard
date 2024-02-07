import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:party_wizard/constants/assets.dart';
import 'package:party_wizard/widgets/rating_star_row_widget.dart';

import '../../../../utils/app_colors.dart';
import 'add_review_widget.dart';

class ShowReviewsWidget extends StatefulWidget {
  const ShowReviewsWidget({
    super.key,
  });

  @override
  State<ShowReviewsWidget> createState() => _ShowReviewsWidgetState();
}

class _ShowReviewsWidgetState extends State<ShowReviewsWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
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
                    'reviews'.tr.replaceAll("(@count ", "").replaceAll(")", ""),
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
            Container(
              height: size.width * 1.25,
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SvgPicture.asset(
                      Assets.assetsSvgProfilePaceholder,
                    ),
                    titleTextStyle: const TextStyle(
                        color: AppColors.c_202124,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                    subtitleTextStyle: const TextStyle(
                      color: AppColors.c_75787a,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    title: Row(
                      children: [
                        const Text("Matt"),
                        const Spacer(),
                        RatingStarRow(
                            rating: index + 1, size: 20, showRating: false)
                      ],
                    ),
                    subtitle: const Text(
                        "Aenean sed lorem est. Sed quis neque ut nibh suscipit imperdiet ac non augue. Aenean ornare sit amet lectus non tristique. Nunc ut volutpat lectus. Nulla velit augue, pulvinar sed nisi sit amet, eleifend fermentum est. Quisque nibh justo, congue ut erat at, aliquet efficitur purus. Integer venenatis odio vitae orci efficitur mollis. Donec ultrices diam dictum dignissim vestibulum. Proin eleifend nunc nunc. Sed non arcu eget lorem viverra sodales."),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1,
                  );
                },
              ),
            ),
            SizedBox(
              height: size.width * .1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showAddReviewSheet(context: context);
                },
                elevation: 0,
                height: 60,
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
    );
  }

  void _showAddReviewSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const AddReviewsWidget(
          imageUrl: '',
        );
      },
    );
  }
}
