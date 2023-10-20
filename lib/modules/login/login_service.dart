import 'dart:convert';

import 'package:my_application/config/server_config.dart';
import 'package:http/http.dart' as http;
import 'package:my_application/config/user_information.dart';
import 'package:my_application/models/user.dart';
import 'package:my_application/models/user_response.dart';
import 'package:my_application/native_service/secure_storage.dart';

class LoginService {
  var message;
  var token;
  var userRes;

  var url = Uri.parse(ServerConfig.DNS + ServerConfig.login);

  Future<bool> login(Userreq user, bool checkBox) async {
    var response = await http.post(
      url,
      body: {
        'email': user.email,
        'password': user.password,
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['message'];
      token = jsonResponse['token'];
      userRes = userResponseFromJson(response.body);
      print(userRes.user.email);
      print(message);
      UserInformation.USER_TOKEN = token;
      if (checkBox) {
        // save token to device
        SecureStorage storage = SecureStorage();
        await storage.save('token', UserInformation.USER_TOKEN);
      }

      return true;
    } else if (response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['errors'];

      return false;
    } else {
      return false;
    }
  }
}

// ///////////////////////////////////////////////////

class LoginService {
  var msg;
  var token;
  var url = Uri.parse(ServerConfig.domainNameServer + ServerConfig.login);
  Future<bool> login(User user, bool checkbox) async {
    var response = await http.post(url, body: {
      'phone': user.phone,
      'password': user.password,
    });
    print(response.statusCode);
    print(response.body);
    var jesonresponse = jsonDecode(response.body);
    if (jesonresponse['isOk'] == true &&
        jesonresponse['result']['token'] != null) {
      msg = jesonresponse['result']['resultText'];
      token = jesonresponse['result']['token'];
      UserInformation.User_token = token;
      print('token ${token}');
      if (checkbox) {
        SecureStorage storage = new SecureStorage();
        print(UserInformation.User_token);
        await storage.save('token', UserInformation.User_token);
      }
      print('test');
      print(UserInformation.User_token);
      return true;
    } else if (jesonresponse['isOk'] == false) {
      msg = jesonresponse['message']['content'];
      return false;
    } else {
      msg = jesonresponse['result']['resultText'];
      return false;
    }
  }
}
