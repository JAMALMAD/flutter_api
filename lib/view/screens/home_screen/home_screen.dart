import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:task_manager/core/app_routes.dart';
import 'package:task_manager/utils/app_colors/app_colors.dart';
import 'package:task_manager/utils/static_strings/static_strings.dart';
import 'package:task_manager/view/widget/custom_button.dart';
import 'package:task_manager/view/widget/custom_text_field.dart';
import 'package:task_manager/view/widget/network_image.dart';

import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: AppColors.blackyDark,
              context: context,
              builder: (_) {
                return Container(
                  padding: EdgeInsets.all(20.w),
                  height: Get.size.height,
                  width: Get.size.width,
                  child: Column(
                    children: [
                      //======================= Title ====================
                      CustomTextField(
                        inputTextStyle:
                            const TextStyle(color: AppColors.blackyDark),
                        fillColor: AppColors.blueLightActive,

                        textInputAction: TextInputAction.next,
                         textEditingController: homeController.titleController.value,
                        hintText: AppStaticStrings.title,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),

                      //======================= Description ====================

                      CustomTextField(
                        inputTextStyle:
                            const TextStyle(color: AppColors.blackyDark),
                        fillColor: AppColors.blueLightActive,
                        textEditingController: homeController.descController.value,
                        textInputAction: TextInputAction.next,

                        hintText: AppStaticStrings.description,
                      ),

                      SizedBox(
                        height: 16.h,
                      ),

                      //======================= Add Button ====================

                      CustomButton(
                        fillColor: AppColors.blueNormalHover,
                        onTap: () {
                         // navigator?.pop();
                          homeController.postTask();
                        },
                        title: AppStaticStrings.save,
                      )
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(
         () {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.profileScreen);
                },
                child: CustomNetworkImage(
                    boxShape: BoxShape.circle,
                    imageUrl: "", height: 80.r, width: 80.r),
              ),

            SizedBox(height: 8.h,),
            
            Expanded(
              child: ListView.builder(
              //padding: EdgeInsets.all(20),
              itemCount: homeController.taskModel.value.data?.myTasks?.length,
                itemBuilder: (context, index) {
                  var data = homeController.taskModel.value.data?.myTasks?[index];
              
                  return ListTile(
                    title: Text(
                      data?.title ?? "",
                      style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(data?.description ?? "",
                        style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            )
            ],),
          );
        }
      ),
    );
  }
}
