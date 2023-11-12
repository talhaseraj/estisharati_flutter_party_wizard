import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_wizard/screens/product_details_screen.dart';
import 'package:party_wizard/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  var selectedCategoryId = (-1).obs;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          backgroundColor: AppColors.bgColor,
          elevation: 0,
          leadingWidth: 60,
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu),
            ),
          ),
          title: Text(
            "home".tr,
            style: const TextStyle(color: AppColors.c_212326, fontSize: 16),
          ),
          actions: [
            Container(
              width: 40,
              margin: const EdgeInsets.only(right: 20),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.search),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SizedBox(
              height: 45,
              child: ListView(
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  SizedBox(
                    width: 120,
                    child: MaterialButton(
                      elevation: 0,
                      color: Colors.white,
                      onPressed: () {
                        selectedCategoryId(-1);
                      },
                      height: 45,
                      // width: 120,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.grid_view,
                                  color: selectedCategoryId.value == -1
                                      ? AppColors.primaryColor
                                      : AppColors.c_77838f,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "all".tr,
                                  style: TextStyle(
                                      color: selectedCategoryId.value == -1
                                          ? AppColors.primaryColor
                                          : AppColors.c_77838f,
                                      fontSize: 18),
                                )
                              ])),
                    ),
                  ),
                  ...List.generate(
                      3,
                      (index) => categoryWidget(
                            "Section$index",
                            () {
                              selectedCategoryId(index);
                            },
                            selectedCategoryId.value == index,
                          ))
                ],
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: size.height,
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
            },
            child: GridView.builder(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                shrinkWrap: true,
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4.8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final discount = index % 2 == 1;

                  return InkWell(
                    onTap: () {
                      Get.to(() => ProductDetailsScreen(
                            price: 49.00,
                            productId: index,
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              discount
                                  ? Container(
                                      height: 42,
                                      width: 42,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: AppColors.c_5965b1,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              bottomRight:
                                                  Radius.circular(18))),
                                      child: const Text(
                                        "%25",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_outline_rounded,
                                  color: AppColors.c_77838f,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: AspectRatio(
                                aspectRatio: 2 / 1.25,
                                child: Hero(
                                  tag: index,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://picsum.photos/id/${index * 10}/300/220",
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, text, progress) {
                                      return Center(
                                          child: Text(
                                              "${progress.downloaded} / ${progress.totalSize}"));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "Lobortis fermentum",
                            style: TextStyle(
                                color: AppColors.c_1e2022, fontSize: 14),
                          ),
                          const Text(
                            "\$49.00",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColors.c_fdd546,
                                    ),
                                    Text(
                                      "(4.8)",
                                      style:
                                          TextStyle(color: AppColors.c_77838f),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 35,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: 35,
                                    padding: EdgeInsets.zero,
                                    elevation: 0,
                                    color: AppColors.primaryColor,
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

Widget categoryWidget(text, onTap, bool selected) {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    width: 120,
    child: MaterialButton(
      elevation: 0,
      color: Colors.white,
      onPressed: () => onTap(),
      height: 45,
      // width: 120,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Text(
        text,
        style: TextStyle(
          color: selected ? AppColors.primaryColor : AppColors.c_77838f,
          fontSize: 18,
        ),
      ),
    ),
  );
}
