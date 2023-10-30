import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_wizard/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  var selectedCategoryId = (-1).obs;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.search),
            ),
          ],
        ),
        body: Obx(
          () => SizedBox(
              height: size.height,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
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

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.grid_view,
                                    color: selectedCategoryId.value == -1
                                        ? AppColors.primaryColor
                                        : AppColors.c_77838f,
                                  ),
                                  SizedBox(
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
                                ]),
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
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(color: Colors.white),
                        );
                      })
                ],
              )),
        ));
  }
}

Widget categoryWidget(text, onTap, bool selected) {
  return Container(
    margin: EdgeInsets.only(left: 10),
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
            fontSize: 18),
      ),
    ),
  );
}
