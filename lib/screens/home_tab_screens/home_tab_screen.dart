// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:party_wizard/screens/home_tab_screens/cart_screen.dart';
import 'package:party_wizard/screens/home_tab_screens/home_screen.dart';
import 'package:party_wizard/screens/home_tab_screens/menu_screen.dart';
import 'package:party_wizard/utils/app_colors.dart';
import 'package:collection/collection.dart';

class HomeTabScreen extends StatelessWidget {
  HomeTabScreen({super.key});
  final pageController = PageController(
    initialPage: 0,
  ).obs;

  var currentIndex = 0.obs;
  var bottomTabIconsList = [
    Icons.home_outlined,
    Icons.person_outline,
    Icons.shopping_bag_outlined,
    Icons.grid_view
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController.value,
        children: [
          HomeScreen(),
          const Center(child: Text("page 2")),
          const CartScreen(),
           MenuScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        // height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), // Adjust the radius as needed
            topRight: Radius.circular(30.0), // Adjust the radius as needed
          ),
        ),
        child: Obx(
          () => SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...bottomTabIconsList
                    .mapIndexed(
                      (index, icon) => BottomBarItemCustom(
                          selected: currentIndex.value == index,
                          icon: icon,
                          onTap: () {
                            pageController.value.jumpToPage(index);
                            currentIndex(index);
                          }),
                    )
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBarItemCustom extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function onTap;

  const BottomBarItemCustom({
    super.key,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: selected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(18)),
        child: Icon(
          icon,
          size: 30,
          color: selected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
