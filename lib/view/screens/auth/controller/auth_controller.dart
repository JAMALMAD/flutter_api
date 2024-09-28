import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/core/app_routes.dart';
import 'package:task_manager/helper/sharepre.dart';
import 'package:task_manager/service/api_url.dart';

class AuthenticationController extends GetxController {
  ///========================= Sign In =========================

  Rx<TextEditingController> emailController = TextEditingController(text: kDebugMode?"xojob34120@obisims.com":"" ).obs;
  Rx<TextEditingController> passwordController = TextEditingController(text: kDebugMode?"1234567Rr":"").obs;

  ///========================= Sign Up =========================

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> signupEmailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> signupPasswordController =
      TextEditingController().obs;

  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  Rx<TextEditingController> newPasswordController = TextEditingController().obs;

  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;

  RxString activationCode = "".obs;

  Rx<File> pickedImage = File("").obs;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final response = await picker.pickImage(source: ImageSource.camera);
    if (response == null) {
      return;
    }
    pickedImage.value = File(response.path);
    debugPrint(
        "Picked Image======================>>>>>>> ${pickedImage.value.path}");
    pickedImage.refresh();
  }

  signIn() async {
    var body = {
      "email": emailController.value.text,
      "password": passwordController.value.text
    };

    // var url = Uri.https('example.com', 'whatsit/create');
    var response = await http.post(
        Uri.parse("${ApiUrl.baseUrl}${ApiUrl.login}"),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var encodedBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Token==============${encodedBody["data"]["token"]}");

      SharePrefsHelper.setString(
          SharedPreferenceValue.token, encodedBody["data"]["token"] ?? '');

      Get.snackbar("Success", encodedBody["message"]);

      Get.offAllNamed(AppRoute.homeScreen);
    } else {
      print("Failed==============${response.body}");
      print("Failed==============$body");
      Get.snackbar("Error", encodedBody["error"]);
    }
  }

  //================== Sign Up =======================

  signUpUser() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("${ApiUrl.baseUrl}${ApiUrl.signUp}"));

    request.files
        .add(await http.MultipartFile.fromPath('file', pickedImage.value.path));

    request.fields['password'] = confirmPasswordController.value.text;
    request.fields['email'] = emailController.value.text;
    request.fields['lastName'] = lastNameController.value.text;
    request.fields['firstName'] = firstNameController.value.text;
    request.fields['address'] = addressController.value.text;

    var response = await request.send();
    print("Status Code=============>>>>>${response.statusCode}");
    // print(response.stream.bytesToString());

    if (response.statusCode == 200) {
      debugPrint("Success====>>>>>>>>${response.statusCode}");
      Get.toNamed(AppRoute.varifyOTP);
    } else {
      debugPrint("Some went Worng====>>>>>>>>${response.statusCode}");
    }
  }

  //============== Varify Code =================

  varifyOTP() async {
    var body = {
      "code": activationCode.value,
      "email": emailController.value.text
    };
    var response = await http.post(
        Uri.parse("${ApiUrl.baseUrl}${ApiUrl.varifyOTP}"),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoute.homeScreen);
    } else {
      debugPrint("Some went Worng====>>>>>>>>${response.statusCode}");
    }
  }
}
