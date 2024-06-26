import 'package:flutter/material.dart';

import '../../components/displays/back_appbar.dart';
import '../../utils/colours.dart';

class ResourceMaterialPage extends StatefulWidget {
  const ResourceMaterialPage({Key? key}) : super(key: key);
  @override
  State<ResourceMaterialPage> createState() => _ResourceMaterialPageState();
}

class _ResourceMaterialPageState extends State<ResourceMaterialPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            appBar: backButtonAppbar(() {}, "Resource Materials", secondaryColor),
            backgroundColor: secondaryColor,
            body: const SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              "Coming Soon",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Icon(
                            Icons.warning_amber_outlined,
                            color: primaryColor,
                            size: 150,
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
