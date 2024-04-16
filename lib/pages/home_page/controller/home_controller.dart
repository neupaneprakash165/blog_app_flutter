import 'dart:io';
import 'dart:typed_data';
import 'package:blog_app/app/sql_helper.dart';
import 'package:blog_app/routes/route_names.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController with StateMixin<dynamic> {
  RxBool loading = false.obs;
  RxString imagePath = "".obs;

  @override
  void onInit() {
    getPosts();
    super.onInit();
  }

  void getPosts() async {
    change(value, status: RxStatus.loading());
    await SQLHelper.getPosts().then((value) {
      change(value, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change(
        null,
        status: RxStatus.error(error.toString()),
      );
    });
  }

  void createPost(Map<String, dynamic> data) async {
    await SQLHelper.createPost(data).then((value) {
      getPosts();
      Get.back();
    }).onError((error, stackTrace) {
      change(
        null,
        status: RxStatus.error(error.toString()),
      );
    });
  }

  void updatePost(int id, Map<String, dynamic> data) async {
    await SQLHelper.updatePost(id, data).then((value) {
      getPosts();
      Get.toNamed(RoutesName.home);
    }).onError((error, stackTrace) {
      change(
        null,
        status: RxStatus.error(error.toString()),
      );
    });
  }

  void deletePost(int id) async {
    await SQLHelper.deletePost(id).then((value) {
      getPosts();
    }).onError((error, stackTrace) {
      change(
        null,
        status: RxStatus.error(error.toString()),
      );
    });
  }

  void findPosts(String value) async {
    change(value, status: RxStatus.loading());
    await SQLHelper.findPosts(value).then((value) {
      change(value, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change(
        null,
        status: RxStatus.error(error.toString()),
      );
    });
  }

  Future<Uint8List?> getBytesFromImage(File? image) async {
    Uint8List? bytes;
    if (image != null) {
      bytes = await image.readAsBytes();
    }
    return bytes;
  }

  Future<String> saveImage(Uint8List? imageData) async {
    final directory = await getApplicationDocumentsDirectory();
    String imagePath =
        '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
    final File imageFile = File(imagePath);
    await imageFile.writeAsBytes(imageData!);
    return imagePath;
  }

  void pickImageFromCamera() async {
    ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File image = File(photo.path);
      Uint8List? uint8list = await getBytesFromImage(image);
       imagePath.value = await saveImage(uint8list);
    }
  }

  void pickImageFromGallary() async {
    ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      File image = File(photo.path);
      Uint8List? uint8list = await getBytesFromImage(image);
       imagePath.value = await saveImage(uint8list);
    }
  }
}
