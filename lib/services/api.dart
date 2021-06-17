import 'package:cloud_functions/cloud_functions.dart';

class API {

  FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;

  Future<Map<String, String>> getTempToken() {
      return _firebaseFunctions.httpsCallable("getTempToken").call().then((value) {
        Map<String, dynamic> data = (value.data as Map<String, dynamic>);
        return {
          "token": data["token"] as String,
          "uid": data["uid"] as String
        };
      }).catchError((error) {
        print(error);
        return Future.value({
          "token": "",
          "uid": ""
        });
      });
  }

  Future<Map<String, String>> login(String email) {
      return _firebaseFunctions.httpsCallable("login").call().then((value) {
        Map<String, dynamic> data = (value.data() as Map<String, dynamic>);
        return {
          "token": data["token"] as String,
          "uid": data["uid"] as String
        };
      }).catchError((error) {
        print(error);
        return Future.value({
          "token": "",
          "uid": ""
        });
      });
  }
}