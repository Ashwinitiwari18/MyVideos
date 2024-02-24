import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/controller/search_controller.dart';
import 'package:getx_tutorial/model/user_model.dart';
import 'package:getx_tutorial/view/screen/profile_screen.dart';
import 'package:getx_tutorial/view/screen/search_screen_feed.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchedController searchController = Get.put(SearchedController());
  final TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextField(
            decoration: const InputDecoration(
              filled: false,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            controller: searchTextController,
            onSubmitted: (value) => searchController.searchUser(value),
          ),
        ),
        body: searchController.searchUsers.isEmpty &&
                searchTextController.text.isEmpty
            ? Center(
                // child: Text(
                //   "Search for User",
                //   style: TextStyle(
                //       fontSize: 25,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold),
                // ),
                child: SearchScreenFeed(),
              )
            : searchController.searchUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: searchController.searchUsers.length,
                    itemBuilder: (context, index) {
                      User user = searchController.searchUsers[index];
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(uid: user.userId))),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePhoto),
                          ),
                          title: Text(
                            user.name,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "User not found",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
      ),
    );
  }
}
