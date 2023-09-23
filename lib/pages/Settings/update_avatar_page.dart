import 'package:flutter/material.dart';



import '../../components/displays/app_button.dart';

import '../../components/displays/back_appbar.dart';
import '../../components/inputs/app_textfield.dart';
import '../../utils/colours.dart';

class UpdateAvatarPage extends StatefulWidget {
  const UpdateAvatarPage({Key? key}) : super(key: key);

  @override
  State<UpdateAvatarPage> createState() => _UpdateAvatarPageState();
}

class _UpdateAvatarPageState extends State<UpdateAvatarPage> {
 
  final avatarController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar( (){}, "Update Avatar", secondaryColor),
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                 
                   
                    AppTextField(
                      label: "Avatar",
                      hint: "Avatar",
                      key: Key(1.toString()),
                      textController: avatarController,
                      // onChanged: isTextFieldBlankValidation,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                     AppButton(
                      text: "Update",
                      onPress: (){},
                      buttonColour: primaryColor,
                      // onPress: () => Get.to(const DashBoardPage()),
                      // isDisabled: isButtonDisabled,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
