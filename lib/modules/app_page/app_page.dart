import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_application/component/custom_button.dart';
import 'package:my_application/constant.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_application/modules/account/account_page.dart';
import 'package:my_application/modules/add_product/add_product.dart';
import 'package:my_application/modules/app_page/app_page_controller.dart';
import 'package:my_application/modules/app_page/localization_service.dart';
import 'package:my_application/modules/home/home_page.dart';
import 'package:my_application/modules/search/search_page.dart';

class appPage extends StatelessWidget {
  String _selectedLang = LocalizationService.langs.first;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            elevation: 0,
          ),
          drawer: Drawer(
            child: Container(
              color: Colors.indigo[50],
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/default_user_photo.png'),
                      ),
                      SizedBox(width: 30),
                      Text(
                        '',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 5),
                        const Icon(Icons.translate, size: 40),
                        const SizedBox(width: 20),
                        DropdownButton(
                          icon: const Icon(Icons.arrow_drop_down),
                          value: _selectedLang,
                          items: LocalizationService.langs.map((String lang) {
                            return DropdownMenuItem(
                                value: lang, child: Text(lang));
                          }).toList(),
                          onChanged: (value) {
                            _selectedLang = value.toString();
                            LocalizationService()
                                .changeLocale(value.toString());
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/about');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 5),
                        const Icon(Icons.announcement, size: 40),
                        const SizedBox(width: 20),
                        Container(
                          child: Text('about'.tr,
                              style: const TextStyle(fontSize: 25)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        middleText: '',
                        title: 'sure'.tr,
                        cancel: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                          child: customButton(
                            width: 100,
                            height: 50,
                            buttonName: 'cancel'.tr,
                            onTab: () {
                              Get.close(1);
                            },
                            color: Colors.redAccent,
                          ),
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                            child: customButton(
                              color: cyan,
                              width: 100,
                              height: 50,
                              buttonName: 'yes'.tr,
                              onTab: () async {
                                EasyLoading.show(status: 'loading..');
                                await controller.logout();
                                if (controller.logoutState == true) {
                                  EasyLoading.showSuccess(controller.message);
                                  Get.offAllNamed('/landing');
                                } else {
                                  EasyLoading.showError('Error');
                                }
                              },
                            ),
                          )
                        ],
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5),
                        Icon(Icons.logout, size: 40),
                        SizedBox(width: 20),
                        Text(
                          'logout'.tr,
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                homePage(),
                searchPage(),
                AddProductPage(),
                accountPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.indigo,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 5,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.search,
                label: 'Search',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.bag_badge_plus,
                label: 'Add Product',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person,
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
