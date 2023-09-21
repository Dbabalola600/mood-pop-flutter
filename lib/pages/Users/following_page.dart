import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mood_pop/components/displays/user_search_result.dart';

import '../../utils/colours.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);
  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SvgPicture.asset(
              "assets/Empty/People2.svg",
              alignment: Alignment.center,
              width: 100,
              height: 200,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                UserSearchResult(
                    image: null, name: "name", cilckyText: "Remove"),
                UserSearchResult(
                    image: null, name: "name", cilckyText: "Remove"),
                UserSearchResult(
                    image: null, name: "name", cilckyText: "Remove"),
                UserSearchResult(
                    image: null, name: "name", cilckyText: "Remove"),
                UserSearchResult(
                    image: null, name: "name", cilckyText: "Remove"),
                UserSearchResult(
                    image: null, name: "name", cilckyText: "Remove"),
                UserSearchResult(
                    image: null, name: "name", cilckyText: "Remove"),
                UserSearchResult(
                    image: null, name: "name", cilckyText: "Remove"),
                UserSearchResult(
                    image: null, name: "name", cilckyText: "Remove"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
