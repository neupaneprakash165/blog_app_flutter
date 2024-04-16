import 'package:blog_app/pages/home_page/controller/home_controller.dart';
import 'package:blog_app/pages/home_page/view/add_edit_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  final dynamic postMap = Get.arguments;
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Post Details',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
              tileColor: Colors.white,
              title: Text(
                postMap["title"],
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                postMap["content"],
                style: const TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                onPressed: () {
                  Map<String, dynamic> element = {
                    "id": postMap["id"],
                    "title": postMap["title"],
                    "content": postMap["content"],
                  };
                  Get.to(const AddPost(), arguments: element);
                },
                icon: const Icon(Icons.edit),
              ),
            ),
            Image.asset('assets/images/noimage.png'),
            IconButton(
              onPressed: () {
                String shareText = postMap['title'];
                String shareContent = postMap['content'];
                Share.share("$shareText: $shareContent");
              },
              icon: const Icon(Icons.share),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
