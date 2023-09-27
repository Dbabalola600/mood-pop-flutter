import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/displays/user_search_result.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';

class FindUsersPage extends StatefulWidget {
  final String find;
  const FindUsersPage(
    this.find, {
    Key? key,
  }) : super(key: key);
  @override
  State<FindUsersPage> createState() => _FindUsersPageState();
}

class UserIn {
  dynamic id;
  dynamic UserName;
  dynamic email;
  dynamic image;

  UserIn({
    this.id,
    this.UserName,
    this.email,
    this.image,
  });
}

class _FindUsersPageState extends State<FindUsersPage> {
  bool _isLoading = false;

  List<UserIn> userList = [];
  List<Map<String, String>> userData = [];
  @override
  void initState() {
    super.initState();
    showInfo();
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });

    var response = await searchUser(widget.find);
// print(response);
    if (response != null) {
      var userData = response;
      // print("here"+postData);
      userList = (userData as List).map((user) {
        return UserIn(
          UserName: user["UserName"],
          email: user["email"],
          id: user["_id"],
          image: user['image'],
        );
      }).toList();
    }
    setState(() {
      _isLoading = false;
    });

    // print(userList[0].UserName);
  }

  @override
  Widget build(BuildContext context) {
    void userButtonClick(dynamic newRec) async {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var response =
          await newRequests(fromId: prefs.getString("userId"), toId: newRec);

      print(response["status"]);
      if (response["status"] == 200) {
        Get.to(DashBoardPage());
      }
      if (response["status"] == 202) {
        Get.to(DashBoardPage());
      } else {
        print("error");
      }
      setState(() {
        _isLoading = false;
      });
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: backButtonAppbar(() {}, widget.find, secondaryColor),
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: userList.length.toInt() == 0
                            ? [
                                const Center(
                                  child: Text(
                                    "No User Found",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]
                            : [
                                ListView.builder(
                                  itemCount: userList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final info = userList[index];
                                    return UserSearchResult(
                                      props: UserSearchProps(
                                          image: info.image,
                                          name: info.UserName,
                                          clicky: () =>
                                              userButtonClick(info.id),
                                          cilckyText: _isLoading
                                              ? "Loading"
                                              : "Request"),
                                    );
                                  },
                                ),
                              ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
