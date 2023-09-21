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

//posts

Future getUserposts(userId) async {
  Map info = {"userId": userId};

  String uri = "$baseUrl/post/getPosts";
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
  Map info = {"userId": userId};
//  var body = info;
  String uri = "$baseUrl/post/getFollowingPost?userId=$userId";



  var url = Uri.parse(uri);

  final response = await http.get(url);

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

//journal

Future createJournal(userId, title, content) async {
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
    return data;
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized: Invalid credentials");
  } else {
    throw Exception(
        "Failed to make the request. Status code: ${response.statusCode}");
  }
}

Future getNote(userId, noteId) async {
  // Map info = {"userId": userId , "Nid": noteId};
  // var body = info;

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


Future deleteNote(userId, noteId) async {
  Map info = {"userId": userId , "Nid": noteId};
  var body = info;

  String uri = "$baseUrl/journal/DelNote";

  var url = Uri.parse(uri);

  final response = await http.post(url, body:body);

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
  Map info = {"userId": userId };
  var body = info;

  String uri = "$baseUrl/request/getAll";

  var url = Uri.parse(uri);

  final response = await http.post(url, body:body);

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


Future newRequests(fromId, toId) async {
  Map info = {"fromId":  fromId, "toId":toId };
  var body = info;

  String uri = "$baseUrl/request/newRequest";

  var url = Uri.parse(uri);

  final response = await http.post(url, body:body);

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



Future acceptRequests(userId, newFollowId, ReqId) async {
  Map info = {"userId": userId, "newFollowId": newFollowId, "ReqiD": ReqId};
  var body = info;

  String uri = "$baseUrl/request/AcceptRequest";

  var url = Uri.parse(uri);

  final response = await http.post(url, body:body);

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



void main() async {
  print(await getUserposts(
      "6503204a1837f590a3b6653a"));
}
