import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_application/constant.dart';
import 'package:my_application/modules/home/home_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class homePage extends StatelessWidget {
  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        children: [
          //categories part
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: const Divider(
                        color: white,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    Text('categories'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: white,
                          fontSize: 20,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: const Divider(
                        color: white,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                Obx(
                  () {
                    if (controller.isLoadingCategories.isTrue) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 5,
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                          vertical: MediaQuery.of(context).size.height * 0.018),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            controller.categoriesList.length,
                            (index) => Obx(
                              () {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[100],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                            '/productbycat',
                                            arguments: controller
                                                .categoriesList[index],
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                              ),
                                              child: Text(
                                                controller
                                                    .categoriesList[index].name,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                    fontWeight: FontWeight.bold,
                                                    color: black),
                                              ),
                                            ),
                                            Image(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.09,
                                                image: NetworkImage(controller
                                                    .categoriesList[index].img))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          //products part
          Container(
            height: MediaQuery.of(context).size.height * 0.573,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: const Divider(
                              color: black,
                              thickness: 1,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.21,
                            child: Text('products'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                  fontSize: 20,
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: const Divider(
                              color: black,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      // sort icon
                      Container(
                        width: MediaQuery.of(context).size.width * 0.19,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(() => IconButton(
                                  onPressed: () {
                                    if (controller.isSorted.value == 3) {
                                      controller.isSorted.value = 1;
                                    } else {
                                      controller.isSorted.value++;
                                    }
                                    print(controller.isSorted.value);
                                    if (controller.isSorted.value == 1) {
                                      controller.icon.value =
                                          const Icon(Icons.date_range_outlined);
                                      controller.productsList.sort((a, b) =>
                                          a.expDate.compareTo(b.expDate));
                                    }
                                    if (controller.isSorted.value == 2) {
                                      controller.icon.value =
                                          const Icon(Icons.sort_by_alpha);
                                      controller.productsList.sort(
                                          (a, b) => a.name.compareTo(b.name));
                                    }
                                    if (controller.isSorted.value == 3) {
                                      controller.icon.value = const Icon(
                                          Icons.price_change_outlined);
                                      controller.productsList.sort(
                                          (a, b) => a.price.compareTo(b.price));
                                    }
                                  },
                                  icon: controller.icon.value,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
                        height: MediaQuery.of(context).size.height * 0.51,
                        child: LiquidPullToRefresh(
                            color: white,
                            backgroundColor: Colors.indigo,
                            height: MediaQuery.of(context).size.height * 0.02,
                            springAnimationDurationInMilliseconds: 500,
                            showChildOpacityTransition: false,
                            onRefresh: () async {
                              controller.refresh();
                            },
                            child: Obx(
                              () => ListView(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                children: List.generate(
                                    controller.productsList.length, (index) {
                                  return Obx(() => GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/product',
                                              arguments: controller
                                                  .productsList[index]);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  child: Image(
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.86,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    image: MemoryImage(
                                                      base64Decode(
                                                        controller
                                                            .productsList[index]
                                                            .img,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                        child: Text(
                                                          controller
                                                              .productsList[
                                                                  index]
                                                              .name,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.06,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            controller
                                                                .productsList[
                                                                    index]
                                                                .price
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.green,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 2.0),
                                                            child: Text(
                                                              'sp'.tr,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .green,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                }),
                              ),
                            ) // scroll view
                            ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
