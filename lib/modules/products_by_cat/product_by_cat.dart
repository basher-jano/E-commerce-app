import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:my_application/constant.dart';
import 'package:my_application/modules/products_by_cat/product_by_cat_controller.dart';

class productByCat extends StatelessWidget {
  ProductByCatController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(controller.category.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: white,
              fontSize: 20,
            )),
      ),
      body: Column(
        children: [
          Obx(
            () {
              if (controller.isLoadingProducts.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigo,
                    strokeWidth: 5,
                  ),
                );
              }
              return Container(
                  height: MediaQuery.of(context).size.height * 0.894,
                  child: LiquidPullToRefresh(
                    color: white,
                    backgroundColor: Colors.indigo,
                    height: 30,
                    springAnimationDurationInMilliseconds: 500,
                    showChildOpacityTransition: false,
                    onRefresh: () async {
                      controller.refresh();
                    },
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      children: List.generate(controller.productsList.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/product',
                                arguments: controller.productsList[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          0.86,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.7,
                                      image: MemoryImage(
                                        base64Decode(
                                          controller.productsList[index].img,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            child: Text(
                                              controller
                                                  .productsList[index].name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: black,
                                                fontSize: 25,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                controller
                                                    .productsList[index].price
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 2.0),
                                                child: Text(
                                                  'sp'.tr,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ), // scroll view
                  ));
            },
          ),
        ],
      ),
    );
  }
}
