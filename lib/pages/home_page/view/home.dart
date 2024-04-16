import 'dart:io';

import 'package:blog_app/pages/home_page/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:blog_app/pages/home_page/view/add_edit_post.dart';
import 'package:blog_app/pages/home_page/view/details.dart';
import '../../../routes/utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.find<HomeController>();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 33, 243, 215),
          title: TextField(
            //autofocus: true,
            controller: searchController,
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
              fillColor: Colors.amber,
              hintText: 'Search',
              focusColor: Colors.amber,
              hintStyle: TextStyle(
                color: Colors.amber,
              ),
            ),
            onChanged: (value) => homeController.findPosts(value),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(const AddPost());
              },
              icon: const FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
        body: homeController.obx(
          (postMap) {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                homeController.getPosts();
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                ),
                itemCount: postMap!.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> element = postMap[index];
                  return ListTile(
                    tileColor: Colors.white,
                    leading: SizedBox(
                      width: 50, // Adjust the width as needed
                      
                      child:homeController. imagePath.value == ""
              ? Image.asset(
                  'assets/images/noimage.png',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(homeController.imagePath.value),
                  fit: BoxFit.cover,
                ),
                    ),
                    title: Text(
                      element["title"] ?? '',
                      style: const TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      element["content"] ?? '',
                      style: const TextStyle(fontSize: 10),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        homeController.deletePost(element["id"]);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () {
                      Get.to(() => const HomeDetails(), arguments: element);
                    },
                  );
                },
              ),
            );
          },
          onLoading: const Center(child: CircularProgressIndicator()),
          //  onEmpty: Utils.toastMessage('No posts found'),
          onError: (error) => Utils.toastMessage(error!),
        ),
      ),
    );
  }
}
