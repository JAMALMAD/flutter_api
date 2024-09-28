import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/app_routes.dart';
import 'package:task_manager/service/api_url.dart';
import 'package:task_manager/view/screens/profile_screen/profile_controller/profile_controller.dart';
import 'package:task_manager/view/widget/custom_text.dart';
import 'package:task_manager/view/widget/network_image.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [

        IconButton(onPressed: (){
          Get.toNamed(AppRoute.editProfileScreen);
        }, icon: Icon(Icons.edit))
      ],),


      body: Obx(
         () {
          return SafeArea(
            child: profileController.isLoading.value
                ?const CircularProgressIndicator()
                : Column(
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
                        height: 10.h,
                      ),
                      CustomText(
                        text:
                            "User Name: ${profileController.profileModel.value.data?.firstName} ${profileController.profileModel.value.data?.lastName}",
                        bottom: 10,
                        fontSize: 14.w,
                      ),
                      CustomText(
                          text:
                              "User email: ${profileController.profileModel.value.data?.email}",
                          bottom: 10,
                          fontSize: 14.w),
                      CustomText(
                          text:
                              "User Address: ${profileController.profileModel.value.data?.address}",
                          bottom: 10,
                          fontSize: 14.w),
                    ],
                  ),
          );
        }
      ),
    );
  }
}
