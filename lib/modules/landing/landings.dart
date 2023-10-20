import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_application/component/custom_button.dart';
import 'package:my_application/modules/app_page/localization_service.dart';

import '../../constant.dart';

class Landing extends StatelessWidget {
  String _selectedLang = LocalizationService.langs.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: gradiantBackround,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: const Image(
                  image: AssetImage('assets/images/i1.png'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Text(
                  'welcome'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, color: white, fontWeight: FontWeight.w100),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                child: DropdownButton(
                  style: TextStyle(
                      color: white,
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                  dropdownColor: Colors.indigo,
                  icon: const Icon(Icons.translate_rounded, color: white),
                  value: _selectedLang,
                  items: LocalizationService.langs.map((String lang) {
                    return DropdownMenuItem(value: lang, child: Text(lang));
                  }).toList(),
                  onChanged: (value) {
                    _selectedLang = value.toString();
                    LocalizationService().changeLocale(value.toString());
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.37,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customButton(
                        onTab: () {
                          Get.toNamed('/login');
                        },
                        buttonName: 'signin'.tr,
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customButton(
                        onTab: () {
                          Get.toNamed('/signup');
                        },
                        buttonName: 'signup'.tr,
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: cyan,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
