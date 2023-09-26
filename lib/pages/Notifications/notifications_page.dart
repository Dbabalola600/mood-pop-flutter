import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/displays/logged_appbar.dart';
import '../../components/displays/user_notification.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
import '../Feed/feed_page.dart';
import '../Journal/journal_page.dart';

import '../Resources/resources_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class RequestsNotif {
  final String reqId;
  final String userName;
  final String userId;
  final String userImage;

  RequestsNotif({
    required this.reqId,
    required this.userName,
    required this.userId,
    required this.userImage,
  });
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _currentIndex = 4;

  final List<Widget> _pages = [
    const DashBoardPage(), // Replace with your dashboard content widget
    const JournalPage(),
    const ResourcesPage(),
    const FeedPage(),

    // NotificationContent(),
  ];

  bool _isLoading = false;

  List<RequestsNotif> requestList = [];
  List<Map<String, String>> requestData = [];

  @override
  void initState() {
    super.initState();
    showInfo();
  }

  Future<void> showInfo() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the user ID from SharedPreferences
    String? userId = prefs.getString("userId");

    if (userId != null) {
      var response = await getAllRequests(userId);

      // print(response);
      if (response != null) {
        var requestData = response;

        requestList = (requestData as List).map((request) {
          return RequestsNotif(
              reqId: request["peep"]["_id"],
              userName: request["user"]["UserName"],
              userImage: request["user"]["image"],
              userId: request["user"]["_id"]);
        }).toList();
      }
      // print(response);
      setState(() {
        _isLoading = false;
      });
    } else {
      // Handle the case where userId is null

      setState(() {
        _isLoading = false;
      });
    }
  }

  void acceptClick({required dynamic followId, required dynamic reqId}) async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(reqId);
    var response = await acceptRequests(
        userId: prefs.getString("userId"), newFollow: followId, reqId: reqId);

    print(response);
    if (response["status"] == 200) {
      Get.to(const DashBoardPage());
    } else {
      print("error");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: LoggedAppBar(
            alertButtonHandler: () {}, appBarTitle: "Notifications"),
        drawer: const AppDrawer(),
        backgroundColor: secondaryColor,
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: requestList.length.toInt() == 0
                          ? [
                              const Center(
                                child: Text(
                                  "NO NEW NOTIFICATIONS",
                                  style: TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ),
                            ]
                          : [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      itemCount: requestList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, int index) {
                                        final info = requestList[index];

                                        return UserNotification(
                                          props: UserNotificationProps(
                                              name: info.userName,
                                              Acceptclicky: () => acceptClick(
                                                  followId: info.userId,
                                                  reqId: info.reqId),
                                              Declineclicky: () {},
                                              image: info.userImage),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                    ),
                  ],
                ), // Display the selected page
              ),
            ), // Display the selected page
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class RequestsNotif {
//   final String reqId;
//   final String userName;
//   final String userImage;

//   RequestsNotif({
//     required this.reqId,
//     required this.userName,
//     required this.userImage,
//   });
// }

// class NotificationContent extends StatefulWidget {
//   @override
//   NotificationContentState createState() => NotificationContentState();
// }

// class NotificationContentState extends State<NotificationContent> {
//   bool _isLoading = false;

//   List<RequestsNotif> requestList = [];
//   List<Map<String, String>> requestData = [];

//   @override
//   void initState() {
//     super.initState();
//     showInfo();
//   }

//   Future<void> showInfo() async {
//     setState(() {
//       _isLoading = true;
//     });
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     // Get the user ID from SharedPreferences
//     String? userId = prefs.getString("userId");

//     if (userId != null) {
//       var response = await getAllRequests(userId);

//       if (response != null) {
//         var requestData = response;

//         requestList = (requestData as List).map((request) {
//           return RequestsNotif(
//               reqId: request["peep"]["_id"],
//               userName: request["user"]["UserName"],
//               userImage: request["user"]["image"]);
//         }).toList();
//       }
//       print(response);
//       setState(() {
//         _isLoading = false;
//       });
//     } else {
//       // Handle the case where userId is null

//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           const Center(
//             child: Text(
//               "NO NEW NOTIFICATIONS",
//               style: TextStyle(
//                   color: blackColor, fontWeight: FontWeight.w400, fontSize: 20),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 UserNotification(
//                   props: UserNotificationProps(
//                       name: requestList[0].userName,
//                       Acceptclicky: () {},
//                       Declineclicky: () {},
//                       image: requestList[0].userImage),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
