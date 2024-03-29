// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_wizard/screens/404_screen.dart';
import 'package:party_wizard/screens/home_tab_screens/cart_screen.dart';
import 'package:party_wizard/screens/home_tab_screens/home_screen.dart';
import 'package:party_wizard/screens/home_tab_screens/menu_screen.dart';
import 'package:party_wizard/screens/profile_menu_screens/account_screen.dart';
import 'package:party_wizard/screens/profile_menu_screens/profile_menu_screen.dart';
import 'package:party_wizard/utils/app_colors.dart';
import 'package:collection/collection.dart';

import '../../constants/constants.dart';
import '../../widgets/login_popup.dart';

class HomeTabScreen extends StatelessWidget {
  HomeTabScreen({super.key});
  final box = GetStorage();
  final pageController = PageController(
    initialPage: 0,
  ).obs;

  var currentIndex = 0.obs;
  var bottomTabIconsList = [
    Icons.home_outlined,
    Icons.shopping_bag_outlined,
    Icons.grid_view,
    Icons.person_outline,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController.value,
          children: [
            HomeScreen(),
            CartScreen(),
            CategoryMenuScreen(),
            const ProfileMenuScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        // height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), // Adjust the radius as needed
            // Adjust the radius as needed
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
                            if (index == 1 || index == 3) {
                              if (box.read(Constants.accessToken) == null) {
                                loginDialog(context);
                                return;
                              }
                            }
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
        ),
        child: Icon(
          icon,
          size: 30,
          color: selected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
