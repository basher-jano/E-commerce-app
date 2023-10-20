import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_application/component/custom_button.dart';
import 'package:my_application/component/custom_checkbox.dart';
import 'package:my_application/component/custom_text_field.dart';
import 'package:my_application/constant.dart';
import 'package:my_application/modules/edit_product/edit_controller.dart';

class edit extends StatelessWidget {
  EditController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'editproduct'.tr,
          style: defaultTextStyle,
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              firstBackColor,
              firstBackColor,
            ],
          ),
        ),
        child: ListView(
          children: [
            Row(
              children: [
                customTextField(
                  textcolor: Colors.white,
                  height: 60,
                  hintText: controller.info.name,
                  onChanged: (Value) {
                    controller.name = Value;
                  },
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            Row(
              children: [
                customTextField(
                  keyboard: TextInputType.text,
                  textcolor: Colors.white,
                  height: 60,
                  hintText: controller.info.description,
                  onChanged: (Value) {
                    controller.description = Value;
                  },
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            Row(
              children: [
                customTextField(
                  keyboard: TextInputType.phone,
                  textcolor: Colors.white,
                  height: 60,
                  hintText: controller.info.quantity.toString(),
                  onChanged: (Value) {
                    controller.amount = Value;
                  },
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            Row(
              children: [
                customTextField(
                  keyboard: TextInputType.number,
                  textcolor: Colors.white,
                  height: 60,
                  hintText: controller.info.price.toString() + 'sp'.tr,
                  onChanged: (Value) {
                    controller.price = Value;
                  },
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: controller.fetchImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'selectimg'.tr + ' :',
                            style: defaultTextStyle,
                          ),
                        ),
                        Obx(
                          () => controller.imageName.value == ''
                              ? Text('noimgselected'.tr,
                                  style: TextStyle(color: white, fontSize: 15))
                              : Expanded(
                                  child: Text(
                                    controller.imageName.value,
                                    style: defaultTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: white.withAlpha(40),
                      border: Border(
                        bottom: BorderSide(color: white.withAlpha(60)),
                        top: BorderSide(color: white.withAlpha(60)),
                        left: BorderSide(color: white.withAlpha(60)),
                        right: BorderSide(color: white.withAlpha(60)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  customButton(
                    buttonName: 'edit'.tr,
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.90,
                    onTab: () async {
                      controller.creatBody();
                      print(' body: ${controller.body}');
                      if (controller.body.isEmpty) {
                        EasyLoading.showError('noedit'.tr);
                      } else {
                        EasyLoading.show(status: 'loading'.tr);
                        await controller.edit();
                        if (controller.EditProductStatus == true) {
                          EasyLoading.showSuccess(controller.message);
                        } else {
                          EasyLoading.showError('error'.tr);
                        }
                      }
                    },
                    color: white,
                    fontColor: black,
                    fontSize: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
