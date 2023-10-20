import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_application/component/custom_button.dart';
import 'package:my_application/component/custom_checkbox.dart';
import 'package:my_application/component/custom_text_field.dart';
import 'package:my_application/component/password_text_field.dart';
import 'package:my_application/constant.dart';
import 'package:my_application/modules/login/login_controller.dart';

class login extends StatelessWidget {
  LoginController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: gradiantBackround,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Image(
                image: AssetImage('assets/images/i1.png'),
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Column(
              children: [
                customTextField(
                  keyboard: TextInputType.emailAddress,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.95,
                  hintText: 'email'.tr,
                  onChanged: (value) {
                    controller.email = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                passwordTextField(
                  keyboard: TextInputType.visiblePassword,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.95,
                  hintText: 'pass'.tr,
                  onChanged: (value) {
                    controller.password = value;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() {
                          return CustomCheckbox(
                            size: 25,
                            iconSize: 20,
                            isSelected: controller.checkBoxStatus.value,
                            onTap: () {
                              controller.changeCheckBox();
                            },
                          );
                        }),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          "keep".tr,
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Acaslon Regular",
                              color: white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'forgot'.tr,
                    style: const TextStyle(
                        color: white,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                customButton(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.075,
                  buttonName: 'signin'.tr,
                  onTab: () async {
                    onClicklogin();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onClicklogin() async {
    EasyLoading.show(status: 'loading'.tr);
    await controller.loginOnClick();
    if (controller.loginStatus == true) {
      EasyLoading.showSuccess('loginsucces'.tr);
      await Get.offAllNamed('/appage', arguments: controller.userRes.user);
    } else {
      EasyLoading.showError(controller.message);
    }
  }
}
