import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/helper/sharepre.dart';
import 'package:task_manager/service/api_url.dart';
import 'package:task_manager/view/screens/home_screen/taskmodel/taskmodel.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  //=============== Get Tasks =====================
  Rx<TaskModel> taskModel = TaskModel().obs;

  getTask() async {
    isLoading.value = true;
    String token =
        await SharePrefsHelper.getString(SharedPreferenceValue.token);

    var response = await http
        .get(Uri.parse("${ApiUrl.baseUrl}${ApiUrl.getTask}"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    var decodedBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      taskModel.value = TaskModel.fromJson(decodedBody);

      taskModel.refresh();

      print(
          "============>>>>>>>>>>>>>${taskModel.value.data?.myTasks?.length}");
    } else {
      print(" ${decodedBody}============>>>>>>>>>>>>>Failed");
    }

    isLoading.value = false;
  }

  //=============== Post Tasks =====================
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> descController = TextEditingController().obs;

  RxBool addTaskLoader = false.obs;
  postTask() async {
    addTaskLoader.value = true;
    String token =
        await SharePrefsHelper.getString(SharedPreferenceValue.token);

    var body = {
      "title": titleController.value.text,
      "description": descController.value.text
    };

    var response = await http.post(
        Uri.parse("${ApiUrl.baseUrl}${ApiUrl.createTask}"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    var decodedBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getTask();
      navigator?.pop();
      print("Success>>>>>>>>>>>>>>>>>>>>>>>$decodedBody");
    } else {
      print("Failed>>>>>>>>>>>>>>>>>>>>>>>$decodedBody");
    }
  }

  @override
  void onInit() {
    getTask();
    super.onInit();
  }
}
