import 'package:flutter/material.dart';

import '../../components/displays/app_button.dart';
import '../../components/displays/back_appbar.dart';
import '../../components/navigation/app_drawer.dart';

import '../../utils/colours.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: backButtonAppbar(() {}, " ", secondaryColor),
        backgroundColor: secondaryColor,
        drawer: AppDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AppButton(
                            text: "Update Username",
                            onPress: () => {},
                            buttonColour: disabledColor),
                        const SizedBox(
                          height: 20,
                        ),
                        AppButton(
                            text: "Update Password",
                            onPress: () => {},
                            buttonColour: disabledColor),
                        const SizedBox(
                          height: 20,
                        ),
                        AppButton(
                            text: "Update Email",
                            onPress: () => {},
                            buttonColour: disabledColor),
                        const SizedBox(
                          height: 20,
                        ),
                        AppButton(
                            text: "Update Profile Picture",
                            onPress: () => {},
                            buttonColour: disabledColor),
                        const SizedBox(
                          height: 20,
                        ),
                        AppButton(
                            text: "Contact Support",
                            onPress: () => {},
                            buttonColour: disabledColor),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
