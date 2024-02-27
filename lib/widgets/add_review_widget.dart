import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_wizard/widgets/see_more_widget.dart';
import 'package:party_wizard/widgets/select_rating_star_row.dart';

import '../../../../utils/app_colors.dart';
import '../controllers/product_details_controller.dart';

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
              InkWell(
                onTap: () {
                  _.addReview(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * .05),
                  height: size.width * .125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    // Same as the button's shape
                    gradient: const LinearGradient(
                      colors: [AppColors.c_ecc89c, AppColors.c_76644e],
                      // Define your gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
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
              ),
            ],
          ),
        ),
      );
    });
  }
}
