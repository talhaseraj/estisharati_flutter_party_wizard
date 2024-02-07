import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/report_categories_response_model.dart';
import '../services/auth_services.dart';

class ReportProblemController extends GetxController {
  ReportCategoriesResponse? response;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final problemControler = TextEditingController();

  late ReportCategory selectedValue;
  final isLoading = true.obs;
  final box = GetStorage();
  @override
  void onInit() {
    initilizeData();
    super.onInit();
  }

  initilizeData() async {
    isLoading(true);
    try {
      response = await AuthServices.getReportCategories(
          token: box.read(Constants.accessToken));
      selectedValue = response!.data!.first;
    } catch (e) {}
    isLoading(false);
  }

  Future submitReport(catId) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      AuthServices.submitReport(params: {
        "rep_cat_id": "$catId",
        "message": problemControler.text,
      }, token: box.read(Constants.accessToken));
    } catch (e) {}
    return;
  }
}
