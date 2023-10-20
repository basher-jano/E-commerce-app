import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_application/component/custom_button.dart';
import 'package:my_application/component/custom_text_field.dart';
import 'package:my_application/constant.dart';
import 'package:my_application/modules/add_product/add_product_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddProductPage extends StatelessWidget {
  AddProductController controller = Get.find();
  final f = DateFormat('yyyy-MM-dd ');
  var time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
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
      child: Container(
        child: ListView(
          children: [
            customTextField(
              textcolor: Colors.white,
              height: 60,
              hintText: 'pname'.tr,
              onChanged: (Value) {
                controller.name = Value;
              },
              width: MediaQuery.of(context).size.width * 0.80,
            ),
            customTextField(
              keyboard: TextInputType.text,
              textcolor: Colors.white,
              height: 60,
              hintText: 'des'.tr,
              onChanged: (Value) {
                controller.description = Value;
              },
              width: MediaQuery.of(context).size.width * 95,
            ),
            customTextField(
              keyboard: TextInputType.phone,
              textcolor: Colors.white,
              height: 60,
              hintText: 'amount'.tr,
              onChanged: (Value) {
                controller.amount = Value;
              },
              width: MediaQuery.of(context).size.width * 95,
            ),
            // category
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: white.withAlpha(40),
                border: Border(
                  bottom: BorderSide(color: white.withAlpha(60)),
                  top: BorderSide(color: white.withAlpha(60)),
                  left: BorderSide(color: white.withAlpha(60)),
                  right: BorderSide(color: white.withAlpha(60)),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownSearch(
                    mode: Mode.MENU,
                    items: controller.categoriesNames,
                    dropdownSearchDecoration: InputDecoration(
                      hintStyle: defaultTextStyle,
                      counterStyle: defaultTextStyle,
                      prefixStyle: defaultTextStyle,
                      suffixStyle: defaultTextStyle,
                      labelStyle: defaultTextStyle,
                      fillColor: white,
                      hoverColor: white,
                      border: null,
                      focusColor: white,
                      hintText: 'category'.tr,
                    ),
                    showSearchBox: true,
                    popupBackgroundColor: white,
                    onChanged: (a) => controller.setCategory(a as String),
                  )
                  // DropDown(
                  //   customWidgets: List.generate(
                  //       controller.categoriesNames.length,
                  //       (index) => Text(controller.categoriesNames[index],
                  //           style:
                  //               TextStyle(color: Colors.blueGrey, fontSize: 20))),
                  //   items: controller.categoriesNames,
                  //   hint: const Text(
                  //     'select category',
                  //     style: defaultTextStyle,
                  //   ),
                  //   icon: const Icon(
                  //     Icons.arrow_drop_down,
                  //     size: 40,
                  //     color: white,
                  //   ),
                  //   showUnderline: false,
                  //   onChanged: (a) => controller.setCategory(a as String),
                  // ),
                  ),
            ),
            GestureDetector(
              onTap: () async {
                time = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 5)) ??
                    DateTime.now();
                controller.exp_date_datetime = time;
                controller.exp_date.value = f.format(time);
              },
              child: Container(
                height: 60,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 15, 2),
                    child: Obx(
                      () => Text(
                        'expdate'.tr + ': ${controller.exp_date.value}',
                        style: defaultTextStyle,
                      ),
                    )),
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
            GestureDetector(
              onTap: controller.fetchImage,
              child: Container(
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
                          ? Text(
                              'noimgselected'.tr,
                              style: defaultTextStyle,
                            )
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
            customTextField(
              keyboard: TextInputType.number,
              textcolor: Colors.white,
              height: 60,
              hintText: 'price'.tr,
              onChanged: (Value) {
                controller.price = Value;
              },
              width: MediaQuery.of(context).size.width * 95,
            ),
            Container(
              child: Row(
                children: [
                  buildSale1DropdownButton(),
                  const SizedBox(width: 10),
                  Text(
                    'before'.tr + ' : ',
                    style: defaultTextStyle,
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () async {
                      if (controller.exp_date == '') {
                        Get.snackbar(
                          'error',
                          'you shoule field the expiration date !',
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: black,
                          colorText: white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }

                      time = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: controller.exp_date_datetime,
                          ) ??
                          DateTime.now();
                      controller.date1_datetime = time;
                      controller.date_1.value = f.format(time);
                    },
                    child: Obx(
                      () => controller.date_1.value == ''
                          ? Container(
                              child: Text(
                                "selectdate".tr,
                                style: defaultTextStyle,
                              ),
                            )
                          : Text(
                              controller.date_1.value,
                              style: defaultTextStyle,
                            ),
                    ),
                  ),
                ],
              ),
              height: 60,
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
            Container(
              child: Row(
                children: [
                  buildSale2DropdownButton(),
                  const SizedBox(width: 10),
                  Text(
                    'before'.tr + ' : ',
                    style: defaultTextStyle,
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () async {
                      if (controller.date_1 == '') {
                        Get.snackbar(
                          'error',
                          'you should field the date 1 !',
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: black,
                          colorText: white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }

                      time = await showDatePicker(
                            context: context,
                            initialDate: controller.date1_datetime,
                            firstDate: controller.date1_datetime,
                            lastDate: controller.exp_date_datetime,
                          ) ??
                          DateTime.now();
                      controller.date_2.value = f.format(time);
                    },
                    child: Obx(
                      () => controller.date_2.value == ''
                          ? Container(
                              child: Text(
                                "selectdate".tr,
                                style: defaultTextStyle,
                              ),
                            )
                          : Text(
                              controller.date_2.value,
                              style: defaultTextStyle,
                            ),
                    ),
                  ),
                ],
              ),
              height: 60,
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
            Container(
              child: Row(
                children: [
                  buildSale3DropdownButton(),
                  SizedBox(width: 10),
                  Text(
                    'before'.tr + ' : ',
                    style: defaultTextStyle,
                  ),
                  SizedBox(width: 5),
                  Obx(() =>
                      Text(controller.exp_date.value, style: defaultTextStyle))
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  customButton(
                    buttonName: 'addproduct'.tr,
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.90,
                    onTab: () {
                      onClickadd();
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
    ));
  }

  void onClickadd() async {
    EasyLoading.show(status: 'loading..');
    await controller.AddProductClick();
    if (controller.AddProductStatus == true) {
      EasyLoading.showSuccess(controller.message);
    } else {
      EasyLoading.showError(controller.message);
    }
  }

  Widget buildSale1DropdownButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 2, 15, 2),
          child: Text(
            'sale'.tr + ' 1 : %',
            style: TextStyle(fontSize: 20, color: white),
          ),
        ),
        Obx(() {
          return Container(
            width: 70,
            height: 60,
            child: DropdownButton(
              dropdownColor: Colors.cyan,
              alignment: Alignment.bottomLeft,
              style: TextStyle(color: white, fontSize: 20),
              iconSize: 40,
              iconDisabledColor: white,
              iconEnabledColor: white,
              value: controller.sale_1.value,
              items: controller.saleList.map((String item) {
                return DropdownMenuItem(
                  child: Text(item),
                  value: item,
                );
              }).toList(),
              onChanged: (newVal) {
                controller.sale_1.value = newVal.toString();
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildSale2DropdownButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 2, 15, 2),
          child: Text(
            'sale'.tr + ' 2 : %',
            style: TextStyle(fontSize: 20, color: white),
          ),
        ),
        Obx(() {
          return Container(
            width: 70,
            height: 60,
            child: DropdownButton(
              dropdownColor: Colors.cyan,
              alignment: Alignment.bottomLeft,
              style: TextStyle(color: white, fontSize: 20),
              iconSize: 40,
              iconDisabledColor: white,
              iconEnabledColor: white,
              value: controller.sale_2.value,
              items: controller.saleList2.map((String item) {
                return DropdownMenuItem(
                  child: Text(item),
                  value: item,
                );
              }).toList(),
              onChanged: (newVal) {
                controller.sale_2.value = newVal.toString();
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildSale3DropdownButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 2, 15, 2),
          child: Text(
            'sale'.tr + ' 3 : %',
            style: TextStyle(fontSize: 20, color: white),
          ),
        ),
        Obx(() {
          return Container(
            width: 70,
            height: 60,
            child: DropdownButton(
              dropdownColor: Colors.cyan,
              alignment: Alignment.bottomLeft,
              style: TextStyle(color: white, fontSize: 20),
              iconSize: 40,
              iconDisabledColor: white,
              iconEnabledColor: white,
              value: controller.sale_3.value,
              items: controller.saleList2.map((String item) {
                return DropdownMenuItem(
                  child: Text(item),
                  value: item,
                );
              }).toList(),
              onChanged: (newVal) {
                controller.sale_3.value = newVal.toString();
              },
            ),
          );
        }),
      ],
    );
  }
}
