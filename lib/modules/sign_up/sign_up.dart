import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_application/component/custom_button.dart';
import 'package:my_application/component/custom_text_field.dart';
import 'package:my_application/component/password_text_field.dart';
import 'package:my_application/constant.dart';
import 'package:my_application/modules/sign_up/sign_up_controller.dart';
import 'package:my_application/modules/sign_up/sign_up_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class signUp extends StatelessWidget {
  SignUpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: gradiantBackround,
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Image(
                image: AssetImage('assets/images/i1.png'),
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.height * 0.1,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: const Divider(
                    color: Colors.white38,
                    thickness: 2,
                  ),
                ),
                Text(
                  'signup'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    color: white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: const Divider(
                    color: Colors.white38,
                    thickness: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Column(
              children: [
                customTextField(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.95,
                  hintText: 'username'.tr,
                  onChanged: (value) {
                    controller.userName = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                customTextField(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.95,
                  hintText: 'email'.tr,
                  keyboard: TextInputType.emailAddress,
                  onChanged: (value) {
                    controller.email = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                passwordTextField(
                  height: MediaQuery.of(context).size.height * 0.07,
                  hintText: 'pass'.tr,
                  onChanged: (value) {
                    controller.password = value;
                  },
                  width: MediaQuery.of(context).size.width * 0.95,
                  keyboard: TextInputType.visiblePassword,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                customTextField(
                  keyboard: TextInputType.number,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.95,
                  hintText: 'phone'.tr,
                  onChanged: (value) {
                    controller.phone = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                customTextField(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.95,
                  hintText: 'facebook'.tr,
                  onChanged: (value) {
                    controller.facebook = value;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Text(SignUpService.signUpResponsebody),
                // const SizedBox(height: 20),
                customButton(
                  color: cyan,
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.07,
                  buttonName: 'signup'.tr,
                  onTab: () {
                    onClickSignup();
                  },
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'already'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    color: white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/login');
                  },
                  child: Text(
                    'signin'.tr,
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        color: white,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void onClickSignup() async {
    EasyLoading.show(status: 'loading..');
    await controller.signupOnClick();
    if (controller.signUpStatus == true) {
      EasyLoading.showSuccess(controller.message);
      Get.offAllNamed('/login');
    } else {
      EasyLoading.showError(controller.message);
      print('error');
    }
  }
}
