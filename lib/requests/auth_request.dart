import 'dart:convert';
import 'package:http/http.dart' as http;

import 'request_settings.dart';



String xformurlencoder(Map<dynamic, dynamic> bodyFields) {
  String encodedStr = "";

  for (String field in bodyFields.keys) {
    if (encodedStr.isNotEmpty) {
      encodedStr += "&";
    }
    encodedStr += (field + "=" + bodyFields[field]);
  }

  return encodedStr;
}




Future loginUserWithUsernameAndPassword(
     UserName,  password) async {
  Map loginInfo = {
    "UserName": UserName,
    "password": password,
  };
//  String body = xformurlencoder(loginInfo);
  // var body = json.encode(loginInfo);
  var body = loginInfo;

  String uri = "$baseUrl/users/login";

  var url = Uri.parse(uri);

  final response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data;
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

void main() async {
  print(await loginUserWithUsernameAndPassword(
      "dami600bab@gmail.com", "password"));
}
