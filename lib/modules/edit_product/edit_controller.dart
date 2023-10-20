import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_application/modules/edit_product/edit_service.dart';

class EditController extends GetxController {
  var name = '';
  var description = '';
  var amount = '';
  var imageName = ''.obs;
  var imageCode = '';
  var price = '';
  var info;

  Map<String, dynamic> body = {};
  bool EditProductStatus = false;
  var message;

  @override
  void onInit() async {
    info = Get.arguments;
    super.onInit();
  }

  void creatBody() {
    // body.addIf(checkName.value == true, 'name', name);
    // body.addIf(checkPrice.value == true, 'price', price);
    // body.addIf(checkDes.value == true, 'description', description);
    // body.addIf(checkAmount.value == true, 'quantity', amount);
    // body.addIf(checkImage.value == true, 'img', imageCode);

    body.addIf(name != '', 'name', name);
    body.removeWhere((key, value) => key == 'name' && name == '');
    body.addIf(price != '', 'price', price);
    body.removeWhere((key, value) => key == 'price' && price == '');
    body.addIf(description != '', 'description', description);
    body.removeWhere((key, value) => key == 'description' && description == '');
    body.addIf(amount != '', 'quantity', amount);
    body.removeWhere((key, value) => key == 'quantity' && amount == '');
    body.addIf(imageCode != '', 'img', imageCode);
    body.removeWhere((key, value) => key == 'img' && imageCode == '');
  }

  EditService service = EditService();

  Future<bool> edit() async {
    EditProductStatus = await service.edit(info.id.toString(), body);
    message = service.message;
    if (message is List) {
      String temp = '';
      for (String s in message) {
        temp += s + '\n';
        message = temp;
      }
    }
    if (EditProductStatus == true) {
      return true;
    } else
      return false;
  }

  Uint8List? imageBytes;
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;
  fetchImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    pickedImage = File(image.path);
    imageCode = base64Encode(pickedImage!.readAsBytesSync());
    imageName.value = pickedImage!.path.split('/').last;
  }
}
