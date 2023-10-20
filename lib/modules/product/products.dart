import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_application/constant.dart';
import 'package:my_application/modules/product/products_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class product extends StatelessWidget {
  final f = DateFormat('yyyy-MM-dd ');

  ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[50],
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   height: 60,
            //   color: Colors.black45,
            //   child: Row(
            //     children: [
            //       const Padding(
            //         padding: EdgeInsets.only(left: 8.0),
            //         child: CircleAvatar(
            //           backgroundImage:
            //               AssetImage('assets/images/default_user_photo.png'),
            //         ),
            //       ),
            //       Obx(
            //         () => Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: Text(
            //             controller.owner.value,
            //             style: defaultTextStyle,
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: ClipRRect(
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(40),
                //     bottomRight: Radius.circular(40)),
                child: Image(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  image: MemoryImage(
                    base64Decode(
                      controller.info.img,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: Obx(
                          () => LikeButton(
                            size: 35,
                            onTap: (_) {
                              return controller
                                  .makeLike(controller.info.id.toString());
                            },
                            likeCount: controller.likes.value,
                            isLiked: controller.isLiked,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        child: IconButton(
                            color: Colors.black54,
                            onPressed: () {
                              Get.toNamed('/comments',
                                  arguments: controller.productId);
                            },
                            icon: const Icon(
                              Icons.comment,
                              size: 30,
                            )),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye,
                            color: Colors.black54,
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(controller.views.value.toString(),
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.11),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(right: 5.0),
                                    //   child: IconButton(
                                    //     onPressed: () {
                                    //       try {
                                    //         launch(controller.facebook.value);
                                    //       } catch (error) {
                                    //         print(error);
                                    //         Get.snackbar('Error', 'Unvalid link');
                                    //       }
                                    //     },
                                    //     icon: Icon(Icons.facebook_outlined),
                                    //     iconSize: 30,
                                    //   ),
                                    // ),
                                    const Icon(Icons.phone),
                                    SelectableText(
                                      controller.phone.value,
                                      style: const TextStyle(
                                          color: black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            controller.info.name,
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.info.price.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
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
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      'amount'.tr + ' : ' + controller.info.quantity.toString(),
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      'des'.tr + ' : ' + controller.info.description,
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      'expdate'.tr + ' : ' + f.format(controller.info.expDate),
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black45),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () {
                        launch(controller.facebook.value);
                      },
                      child: Text(
                        'facebookaccount'.tr,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
