import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mood_pop/pages/Users/find_users_page.dart';

import '../../utils/colours.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  CustomSearchBar({required this.onSearch});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController
        .clear(); // Clear the text field when the widget is initialized
  }
  void onSearch(String query) {
      Get.to(FindUsersPage(query));
    }

  @override
  Widget build(BuildContext context) {
    

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.transparent,
          border: Border.all(color: greyColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: SvgPicture.asset("assets/icons/Searchbutton.svg"),
              // onPressed: () {
              //   widget.onSearch(_searchController.text);
              // },
              onPressed: () => onSearch(_searchController.text),
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                // onSubmitted: (query) {
                //   widget.onSearch(query);
                // },

                onSubmitted: (query) {
                  onSearch(query); // Call onSearch function with the query
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                });
                widget.onSearch('');
              },
            ),
          ],
        ),
      ),
    );
  }
}
