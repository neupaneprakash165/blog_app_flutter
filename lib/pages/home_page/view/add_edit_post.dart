 
import 'dart:io';

import 'package:blog_app/pages/home_page/controller/home_controller.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  HomeController homeController = Get.find<HomeController>();
  final dynamic postMap = Get.arguments;
 // final _formKey = GlobalKey<FormState>();
 

  @override
  void initState() {
    if (postMap != null) {
      titleController.text = postMap["title"];
      contentController.text = postMap["content"];
     
    }
    super.initState();
  }


    Widget _imagePickerButtons(  BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () async {
              homeController.pickImageFromGallary();
            },
            child: Text(
              'Pick Galary',
              style: TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            '|',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          InkWell(
            onTap: () async {
               homeController.pickImageFromCamera();
            },
            child: Row(
              children: [
                const Icon(
                  Icons.camera_enhance_outlined,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Text(
                  'Camera',
                  style: TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Column(
        children: [
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

          _imagePickerButtons(context),
                  const SizedBox(height: 20),
                Container(
                  width: size.width,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: size.width,
                      height: size.height * 0.3,
                      // ignore: unnecessary_null_comparison
                      child: homeController.imagePath == null
                          ? Image.asset(
                              'assets/images/noimage.jpg',
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(homeController.imagePath.value),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),

          
         
          ElevatedButton(
            onPressed: () {
              Map<String, dynamic> data = {
                'title': titleController.text,
                'content': contentController.text,
                'imagePath':homeController.imagePath.value,
                
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
          ),
        ],
      ),
    );
  }
}
