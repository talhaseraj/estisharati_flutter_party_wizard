import 'package:get/get.dart';

class ProductDetailsScreenController extends GetxController {
  final currentPage = 0.obs;
  final quantity = 1.obs;
  final isFavourite = true.obs;

  RxDouble totalPrice = 49.0.obs;
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}
