import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager/helper/sharepre.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/service/api_url.dart';
import 'package:task_manager/view/screens/profile_screen/model/profile_model.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  getProfile() async {
    isLoading.value = true;
    String token =
        await SharePrefsHelper.getString(SharedPreferenceValue.token);

    var response = await http
        .get(Uri.parse("${ApiUrl.baseUrl}${ApiUrl.getProfile}"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    var decodedBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      profileModel.value = ProfileModel.fromJson(decodedBody);
      getvalues(profileModel: profileModel.value);
      print("Success==================>>>>>>>>>>>>");
    } else {
      print("Failed==================>>>>>>>>>>>>");
    }

    isLoading.value = false;
  }

  //================================ Edit Profile =========================
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;

  RxBool editLoading =false.obs;
  editProfile() async {
    editLoading.value =true;
    String token =
        await SharePrefsHelper.getString(SharedPreferenceValue.token);
    var body = {
      "firstName": firstName.value.text,
      "lastName": lastName.value.text,
      "address": address.value.text,
    };

    var response = await http.patch(
        Uri.parse("${ApiUrl.baseUrl}${ApiUrl.editProfile}"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    var decodedBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
     // ScaffoldMessenger.of();
      Get.snackbar("Success", decodedBody["message"]);
      getProfile();
      navigator?.pop();
    } else {
      print("Failed==============>>>>>>>>>>>>>>>>>>>${response.statusCode}");
    }
    editLoading.value =false;


  }

  //================== Get Values =======================
  getvalues({required ProfileModel profileModel}) {
    firstName.value =
        TextEditingController(text: profileModel.data?.firstName ?? "");
    lastName.value =
        TextEditingController(text: profileModel.data?.lastName ?? "");
    address.value =
        TextEditingController(text: profileModel.data?.address ?? "");
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
