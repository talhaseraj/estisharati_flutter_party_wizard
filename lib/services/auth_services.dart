import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/urls.dart';
import '../models/general_api_response_model.dart';
import '../models/google_login_response_model.dart';
import '../models/login_response_model.dart';
import '../models/report_categories_response_model.dart';
import '../models/singup_response_model.dart';

class AuthServices {
  static Future<LoginResponse> loginWithEmail(Map<String, String> body) async {
    var request = http.MultipartRequest('POST', Uri.parse(Urls.loginUrl));
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    final responseString = await response.stream.bytesToString();

    if (kDebugMode) {
      print("loginWithEmail url ${Urls.loginUrl}");
      print("loginWithEmail response $responseString}");
    }
    return loginResponseFromJson(responseString);
  }

  static Future<SignupResponse> signupWithEmail(
      Map<String, String> body) async {
    var request = http.MultipartRequest('POST', Uri.parse(Urls.signupUrl));
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    final responseString = await response.stream.bytesToString();

    if (kDebugMode) {
      print("signupWithEmail url ${Urls.signupUrl}");
      print("signupWithEmail response $responseString}");
    }
    return signupResponseFromJson(responseString);
  }

  static Future<GoogleSigninResponse> googleLogin(
      Map<String, String> body) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.userGoogleLoginUrl));
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    final responseString = await response.stream.bytesToString();

    if (kDebugMode) {
      print("googleLogin url ${Urls.userGoogleLoginUrl}");
      print("googleLogin response $responseString}");
    }
    return googleSigninResponseFromJson(responseString);
  }

  static Future<String> getUserProfile({required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    final response =
        await http.get(Uri.parse(Urls.userProfileUrl), headers: headers);
    if (kDebugMode) {
      print("getUserProfile url ${Urls.userProfileUrl}");
      print("getUserProfile response ${response.body}");
    }
    return response.body;
  }

  static Future<GeneralApiResponse> updateProfile({
    required Map<String, String> params,
    required token,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.userUpdateProfileUrl),
    );
    request.fields.addAll(params);
    var headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("updateProfile url ${Urls.userUpdateProfileUrl}");
      print("updateProfile response $body");
    }
    return generalApiResponseFromJson(body);
  }

  static Future<GeneralApiResponse> requestOtp(Map<String, String> body) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.userRequestOtpUrl));
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    final responseString = await response.stream.bytesToString();

    if (kDebugMode) {
      print("requestOtp url ${Urls.userRequestOtpUrl}");
      print("requestOtp response $responseString}");
    }
    return generalApiResponseFromJson(responseString);
  }

  static Future<GeneralApiResponse> verifyOtp(Map<String, String> body) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.userVerifyOtpUrl));
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    final responseString = await response.stream.bytesToString();

    if (kDebugMode) {
      print("verifyOtp url ${Urls.userVerifyOtpUrl}");
      print("verifyOtp response $responseString}");
    }
    return generalApiResponseFromJson(responseString);
  }

  static Future<GeneralApiResponse> createPassword(
      Map<String, String> body) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.userCreatePasswordUrl));
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();

    final responseString = await response.stream.bytesToString();

    if (kDebugMode) {
      print("createPassword url ${Urls.userCreatePasswordUrl}");
      print("createPassword response $responseString}");
    }
    return generalApiResponseFromJson(responseString);
  }

  static Future<GeneralApiResponse> constactUs({
    required Map<String, String> params,
    required token,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.userContactUsUrl));
    request.fields.addAll(params);
    var headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("constactUs url ${Urls.userContactUsUrl}");
      print("constactUs response $body");
    }
    return generalApiResponseFromJson(body);
  }

  static Future<ReportCategoriesResponse> getReportCategories(
      {required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    final response =
        await http.get(Uri.parse(Urls.reportCategoriesUrl), headers: headers);
    if (kDebugMode) {
      print("getReportCategories url ${Urls.reportCategoriesUrl}");
      print("getReportCategories response ${response.body}");
    }
    return reportCategoriesResponseFromJson(response.body);
  }

  static Future<GeneralApiResponse> submitReport({
    required Map<String, String> params,
    required token,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.reportMessageUrl));
    request.fields.addAll(params);
    var headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("submitReport url ${Urls.reportMessageUrl}");
      print("submitReport response $body");
    }
    return generalApiResponseFromJson(body);
  }

  static Future<GeneralApiResponse> deleteUserAccount({required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    final response =
        await http.get(Uri.parse(Urls.userAccountDeleteUrl), headers: headers);
    if (kDebugMode) {
      print("deleteUserAccount url ${Urls.userAccountDeleteUrl}");
      print("deleteUserAccount response ${response.body}");
    }
    return generalApiResponseFromJson(response.body);
  }
}
