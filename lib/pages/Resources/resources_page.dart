import 'package:flutter/material.dart';
import 'package:get/get.dart';




import '../../components/displays/app_button.dart';
import '../../components/displays/logged_appbar.dart';
import '../../components/navigation/app_drawer.dart';
import '../../components/navigation/bottom_navbar.dart';
import '../../utils/colours.dart';
import '../DashBoard/dash_board_page.dart';
import '../Feed/feed_page.dart';
import '../Journal/journal_page.dart';
import '../Notifications/notifications_page.dart';
import 'resource_material_page.dart';
import 'seek_help_page.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({Key? key}) : super(key: key);
  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    const DashBoardPage(),
    const JournalPage(), // Replace with your dashboard content widget
    const ResourcesContent(),
    const FeedPage(),
    const NotificationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
       appBar: LoggedAppBar(alertButtonHandler: (){}, appBarTitle: "Resources"),
          backgroundColor: secondaryColor,
        drawer: AppDrawer(),
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
                child: _pages[_currentIndex], // Display the selected page
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

class ResourcesContent extends StatelessWidget {
  const ResourcesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: [
              AppButton(
                iconic: Icons.handshake,
                text: "Seek Help",
                 onPress:()=>{Get.to(const SeekHelpPage())},
               
                buttonColour: disabledColor,
              ),
              const SizedBox(
                height: 30,
              ),
              AppButton(
                iconic: Icons.menu_book,
                text: "Resource Materials",
                onPress:()=> {Get.to(const ResourceMaterialPage())},
                buttonColour: disabledColor,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
