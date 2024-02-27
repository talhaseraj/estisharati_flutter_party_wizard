import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:party_wizard/constants/theme.dart';
import 'package:party_wizard/widgets/select_rating_star_row.dart';

import '../../../../utils/app_colors.dart';
import '../../../../widgets/more_loading_widget.dart';
import '../constants/assets.dart';
import '../controllers/product_details_controller.dart';
import '../controllers/product_review_controller.dart';
import '../screens/shimmer.dart';
import 'rating_star_row_widget.dart';
import 'see_more_widget.dart';

class ShowReviewsWidget extends StatefulWidget {
  final int productId;
  const ShowReviewsWidget({super.key, required this.productId});

  @override
  State<ShowReviewsWidget> createState() => _ShowReviewsWidgetState();
}

class _ShowReviewsWidgetState extends State<ShowReviewsWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<ProductReviewController>(
        init: ProductReviewController(productId: widget.productId),
        builder: (_) {
          return Obx(() => Container(
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
                              'reviews'
                                  .tr
                                  .replaceAll("(@count ", "")
                                  .replaceAll(")", ""),
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
                      _.isLoading.value
                          ? loadingShimmer(size)
                          : Container(
                              height: size.width * 1.25,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .05),
                              child: NotificationListener<ScrollNotification>(
                                onNotification: (notification) {
                                  if (notification is ScrollEndNotification &&
                                      notification.metrics.extentAfter == 0) {
                                    _.loadMoreData();
                                  }
                                  return false;
                                },
                                child: ListView.separated(
                                  itemCount:
                                      _.productReviewsResponse!.data!.length,
                                  itemBuilder: (context, index) {
                                    final review =
                                        _.productReviewsResponse!.data![index];
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
                                          fontSize: 12),
                                      title: Row(
                                        children: [
                                          Text("${review.name}"),
                                          SizedBox(
                                            width: size.width * .025,
                                          ),
                                          RatingStarRow(
                                              showRating: true,
                                              rating: double.parse(
                                                  review.rate ?? "0.0"),
                                              size: 20)
                                        ],
                                      ),
                                      subtitle: Text("${review.review}"),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      thickness: 1,
                                    );
                                  },
                                ),
                              ),
                            ),
                      MoreLoadingWidget(isLoadingMore: _.isLoadingMoreData),
                      SizedBox(
                        height: size.width * .1,
                      ),
                      Container(
                        height: 60,
                        margin: const EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        child: MaterialButton(
                          elevation: 0,
                          color: AppColors.primaryColor,
                          height: 60,
                          minWidth: double.infinity,
                          shape: const RoundedRectangleBorder(
                              borderRadius: CustomTheme.borderRadius),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showAddReviewSheet(
                                context: context, productId: widget.productId);
                          },
                          child: Text(
                            'add_review'.tr,
                            style: TextStyle(
                                fontSize: size.width * .06,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  void _showAddReviewSheet({
    required BuildContext context,
    required productId,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AddReviewsWidget(productId: productId);
      },
    );
  }

  Widget loadingShimmer(Size size) {
    return ShimmerLoading(
      child: Container(
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
                  fontSize: 12),
              title: Row(
                children: [
                  const Text("Name"),
                  SizedBox(
                    width: size.width * .025,
                  ),
                  RatingStarRow(
                    rating: index + 1,
                    size: 20,
                    showRating: true,
                  )
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
    );
  }
}

class AddReviewsWidget extends StatefulWidget {
  final int productId;
  const AddReviewsWidget({super.key, required this.productId});

  @override
  State<AddReviewsWidget> createState() => _AddReviewsWidgetState();
}

class _AddReviewsWidgetState extends State<AddReviewsWidget> {
  @override
  void initState() {
    final _ = ProductDetailsController(productId: widget.productId);
    _.selectedRate = 1;
    _.reiviewTextController.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<ProductDetailsController>(builder: (_) {
      final product = _.productDetailsResponse!.data;
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: product!.images!.first,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .025,
                        ),
                        SizedBox(
                          height: size.width * .2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product!.title}",
                                style: const TextStyle(
                                    color: AppColors.c_3e3e3e, fontSize: 14),
                              ),
                              Text(
                                "${product.currency} ${product.price}",
                                style: const TextStyle(
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
                    Container(
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: SeeMoreTextWidget(
                            text: "${product.description}",
                          ),
                        ),
                      ),
                    ),
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
                    SelectRatingStarRow(
                      onChanged: (rate) {
                        _.selectedRate = rate;
                      },
                    ),
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
                      controller: _.reiviewTextController,
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
              Container(
                margin: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                child: MaterialButton(
                  color: AppColors.primaryColor,
                  elevation: 0,
                  height: 60,
                  minWidth: double.infinity,
                  shape: const RoundedRectangleBorder(
                      borderRadius: CustomTheme.borderRadius),
                  onPressed: () {
                    _.addReview(context);
                  },
                  child: Obx(() => _.isAddingReview.value
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'add_review'.tr,
                          style: TextStyle(
                              fontSize: size.width * .06,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
