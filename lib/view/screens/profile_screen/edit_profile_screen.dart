import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_manager/service/api_url.dart';
import 'package:task_manager/utils/app_colors/app_colors.dart';
import 'package:task_manager/view/screens/profile_screen/profile_controller/profile_controller.dart';
import 'package:task_manager/view/widget/custom_text_field.dart';
import 'package:task_manager/view/widget/network_image.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl:
                          "${ApiUrl.baseUrl}/${profileController.profileModel.value.data?.image ?? ""}",
                      height: 80.r,
                      width: 80.r),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              //================== First Name ====================

              CustomTextField(
                fillColor: Colors.white,
                inputTextStyle: TextStyle(color: AppColors.blackyDark),
                textEditingController: profileController.firstName.value,
              ),
              SizedBox(
                height: 8.h,
              ),

              //================== Last Name ====================

              CustomTextField(
                fillColor: Colors.white,
                inputTextStyle: TextStyle(color: AppColors.blackyDark),
                textEditingController: profileController.lastName.value,
              ),
              SizedBox(
                height: 8.h,
              ),

              //================== Address ====================

              CustomTextField(
                fillColor: Colors.white,
                inputTextStyle: TextStyle(color: AppColors.blackyDark),
                textEditingController: profileController.address.value,
              ),

              SizedBox(
                height: 44.h,
              ),

              //================== Save Button ====================
              profileController.editLoading.value
                  ? CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        profileController.editProfile();
                      },
                      child: Text("Update"))
            ],
          );
        }),
      ),
    );
  }
}
