import 'package:blog_app_flutter/app/sql_helper.dart';
import 'package:blog_app_flutter/routes/route_names.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<dynamic> {
  RxBool loading = false.obs;

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
}
