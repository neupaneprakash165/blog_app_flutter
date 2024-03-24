import 'package:blog_app_flutter/pages/home_page/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  HomeController homeController = Get.find<HomeController>();
  final dynamic postMap = Get.arguments;

  @override
  void initState() {
    if (postMap != null) {
      titleController.text = postMap["title"];
      contentController.text = postMap["content"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Post'),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Map<String, dynamic> data = {
                'title': titleController.text,
                'content': contentController.text,
                'imagePath': '',
              };
              if (postMap == null) {
                homeController.createPost(data);
              } else {
                homeController.updatePost(postMap["id"], data);
              }
            },
            child: Text(
              postMap != null ? 'Update Post' : 'Add Post',
            ),
          )
        ]));
  }
}
