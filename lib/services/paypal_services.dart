import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {
  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
  //String domain = "https://api.paypal.com"; // for production mode

  // Live
  String clientId =
      'AbplNcwidvB6x_lk8ryQpiOfFBAqsg0qRk91UHmiLrlUYk1UosgDefh_qfmLHfs3jJ51vHAulGUkLr_p';
  String secret =
      'EJaonU6Gbtfk2_Q5ySptL59L9CGAkpbrl6n_xv-mwVNQXZENdAelJR5nZOPej09x06zYOxNlu6LZMfH8';

  // testing sandbox
  // String clientId =
  //   'ASB5t-9IaSePghJFURLGI0M6q0_wE9-xxfls4xTcCzd1AHRmy53tkUjoM0TRLvGyWTvrST-qlGBwNiOJ';
  // String secret =
  //   'ENb4T7-9HfVUzpi8I3AWzLg--KnVkNbsTjSDPeQgIVoRsZ6ck8IGC3KI6M5XignPLJOaF4P2qoElPAj0';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return {};
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(Uri url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("executePayment response: $body");
        }
        return body["payer"]["payer_info"]["email"];
      }
      return "";
    } catch (e) {
      rethrow;
    }
  }
}
