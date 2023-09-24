import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../components/displays/app_button.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../components/displays/back_appbar.dart';

import '../../requests/auth_request.dart';
import '../../utils/colours.dart';
import 'dart:convert';
import 'dart:typed_data';

import '../DashBoard/dash_board_page.dart';

class UpdateAvatarPage extends StatefulWidget {
  const UpdateAvatarPage({Key? key}) : super(key: key);

  @override
  State<UpdateAvatarPage> createState() => _UpdateAvatarPageState();
}

class _UpdateAvatarPageState extends State<UpdateAvatarPage> {
  final avatarController = TextEditingController();

  File? _image;
  String? compressedBase64Image;
  bool isButtonDisabled = true;
  bool _isLoading = false;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      } else {
        print('No image selected.');
      }
    });
  }

  void userUpdateOnClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    if (_image != null) {
      List<int> imageBytes = await _image!.readAsBytes();
      Uint8List uint8ImageBytes = Uint8List.fromList(imageBytes);
      String base64Image = base64Encode(imageBytes);

      // Compress the image
      List<int> compressedImage = await FlutterImageCompress.compressWithList(
        uint8ImageBytes, // Pass Uint8List here
        minHeight: 100,
        minWidth: 100,
      );

      // Convert compressed image to base64
      Uint8List uint8CompressedImage = Uint8List.fromList(compressedImage);
      String compressedBase64Image = base64Encode(compressedImage);

      var newPhoto = 'data:image/jpeg;base64,$compressedBase64Image';
      var response =
          await updateAvatar(id: prefs.getString("userId"), image: newPhoto);

      prefs.setString("image", newPhoto);

      Get.to(const DashBoardPage());

      setState(() {
        _isLoading = false;
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButtonAppbar(() {}, "Update Avatar", secondaryColor),
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
                    _image == null
                        ? Text('No image selected.')
                        : Image.file(_image!),
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor)),
                      child: Text('Select Image'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppButton(
                      text: _isLoading ? "Loading..." : "Update",
                      buttonColour: primaryColor,
                      onPress: userUpdateOnClick,
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
