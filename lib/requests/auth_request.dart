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

//user

Future createUserAccount({UserName, password, email}) async {
  Map loginInfo = {"UserName": UserName, "password": password, "email": email};

  var body = loginInfo;

  String uri = "$baseUrl/users/create";

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

Future loginUserWithUsernameAndPassword(UserName, password) async {
  Map loginInfo = {
    "UserName": UserName,
    "password": password,
  };

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

Future getUserInformation(_id) async {
  Map info = {"_id": _id};
  String uri = "$baseUrl/users/getUser";
  var body = info;
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

Future searchUser(find) async {
//  var body = info;
  String uri = "$baseUrl/users/search?Username=$find";

  var url = Uri.parse(uri);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"]["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

Future contactSupport({email, title, details}) async {
  Map info = {"title": title, "email": email, "details": details};
  String uri = "$baseUrl/users/contactSupport";
  var body = info;
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

//updates
Future updateUsername({id, UserName}) async {
  Map info = {"_id": id, "UserName": UserName};
  String uri = "$baseUrl/users/UpdateUsername";
  var body = info;
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

Future updateAvatar({id, image}) async {
  Map info = {"_id": id, "image": image};
  String uri = "$baseUrl/users/UpdateImage";
  var body = info;
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

Future updatePassword({id, password}) async {
  Map info = {"_id": id, "password": password};
  String uri = "$baseUrl/users/UpdatePassword";
  var body = info;
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

Future updateEmail({id, email}) async {
  Map info = {"_id": id, "email": email};
  String uri = "$baseUrl/users/UpdateEmail";
  var body = info;
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

//posts

Future createPost({userId, title, content}) async {
  Map info = {"userId": userId, "post": content, "category": title};
  var body = info;

  String uri = "$baseUrl/post/create";

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

Future getUserposts(userId) async {
  Map info = {"userId": userId};

  String uri = "$baseUrl/post/getPosts";
  var body = info;
  var url = Uri.parse(uri);

  final response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

Future newUserpost(userId, post, content) async {
  Map info = {"userId": userId, "post": post, "category": content};

  String uri = "$baseUrl/post/create";
  var body = info;
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

Future getfollowingposts(userId) async {
//  var body = info;
  String uri = "$baseUrl/post/getFollowingPost?userId=$userId";

  var url = Uri.parse(uri);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

//journal

Future createJournal({userId, title, content}) async {
  Map info = {"userId": userId, "title": title, "content": content};
  var body = info;

  String uri = "$baseUrl/journal/create";

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

Future getJournal(userId) async {
  Map info = {"userId": userId};
  var body = info;

  String uri = "$baseUrl/journal/getjournal";

  var url = Uri.parse(uri);

  final response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

Future getNote({userId, noteId}) async {

  String uri = "$baseUrl/journal/getNote?userId=$userId&Nid=$noteId";

  var url = Uri.parse(uri);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

Future deleteNote({userId, noteId}) async {
  Map info = {"userId": userId, "Nid": noteId};
  var body = info;

  String uri = "$baseUrl/journal/DelNote";

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

//audio journal

Future getAudioJournal(userId) async {
  Map info = {"userId": userId};
  var body = info;

  String uri = "$baseUrl/audio/getjournal";

  var url = Uri.parse(uri);

  final response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

Future createAudioJournal({userId, title, content}) async {
  Map info = {"userId": userId, "title": title, "content": content};
  var body = info;

  String uri = "$baseUrl/audio/create";

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

Future getAudioNote({userId, noteId}) async {
  // Map info = {"userId": userId , "Nid": noteId};
  // var body = info;

  String uri = "$baseUrl/audio/getNote?userId=$userId&Nid=$noteId";

  var url = Uri.parse(uri);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}


Future deleteAudioNote({userId, noteId}) async {
  Map info = {"userId": userId, "Nid": noteId};
  var body = info;

  String uri = "$baseUrl/audio/DelNote";

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

//notifications

Future countNotification(userId) async {
  // Map info = {"userId": userId , "Nid": noteId};
  // var body = info;

  String uri = "$baseUrl/notification/count?userId=$userId";

  var url = Uri.parse(uri);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

//requests
Future getAllRequests(userId) async {
  Map info = {"userId": userId};
  var body = info;

  String uri = "$baseUrl/request/getAll";

  var url = Uri.parse(uri);

  final response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

Future newRequests({fromId, toId}) async {
  Map info = {"fromId": fromId, "toId": toId};
  var body = info;
//  print(body);

  String uri = "$baseUrl/request/newRequest";

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

Future acceptRequests({userId, newFollow, reqId}) async {
  Map info = {"userId": userId, "newFollowId": newFollow, "RequiD": reqId};
  var body = info;

  // print(body);

  String uri = "$baseUrl/request/AcceptRequest";

  var url = Uri.parse(uri);

  // print(await http.put(url, body:body));

  final response = await http.post(url, body: body);
  // print(response.body);
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

//followers

Future getFollowing(userId) async {
  String uri = "$baseUrl/follow/getFollowing?Id=$userId";

  var url = Uri.parse(uri);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

Future getFollowers(userId) async {
  String uri = "$baseUrl/follow/getFollowers?Id=$userId";

  var url = Uri.parse(uri);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["data"];
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

//token

Future resetPasswordTokenSend(email) async {
  Map tokenInfo = {"email": email};

  var body = tokenInfo;

  String uri = "$baseUrl/token/resetPassEmail";
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

Future validateResetPasswordToken({token, userId}) async {
  Map tokenInfo = {"token": token, "userId": userId};

  var body = tokenInfo;

  String uri = "$baseUrl/token/VerifyEmail";
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

// void main() async {
//   print(await resetPasswordTokenSend("dami600bab@gmail.com"));
// }

// void main() async {
//   print(await newRequests(fromId:  "650320061837f590a3b6652c",toId: "6503204a1837f590a3b6653a"));
// }
