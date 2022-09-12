// ignore_for_file: non_constant_identifier_names, null_check_always_fails

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> ApiConnection(Type, String URL, Body) async {
  Response? response;
  // perubahan
  var client = http.Client();
  try {
    var url = Uri.parse(URL);
    var headers = {
      "Content-Type": "application/json",
    };
    if (Type == "POST") {
      response = await client
          .post(url, body: Body, headers: headers)
          .timeout(const Duration(seconds: 60), onTimeout: () {
        return null!;
      });
    } else {
      response = await client
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 60), onTimeout: () {
        return null!;
      });
    }

    return response;
  } catch (e) {
    return response!;
  } finally {
    client.close();
  }
}
