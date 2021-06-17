import 'package:myapp/models/dto/auth_model.dart';
import 'package:myapp/models/dto/user_model.dart';
import 'package:myapp/services/api.dart';
import 'package:myapp/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  API api = API();
  Firestore firestore = Firestore();

  Stream<UserModel?>? get user => _auth.currentUser == null ? null : null;//firestore.getCurrentUser(_auth.currentUser!.uid);

  Stream<AuthModel?> get authUserListener => FirebaseAuth.instance.authStateChanges().map((event) => event == null ? null : AuthModel.fromFirebaseUser(user: event));

  Future<String> loginToFirebase(String token) async {
    String retVal = "error";

    try {
      await _auth.signInWithCustomToken(token);
      return "success";
    } on PlatformException catch (e) {
      retVal = e.message!;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(String name, String email, String bio) async {
    String retVal = "error";
    try {
      var tempToken = await api.getTempToken();
      UserCredential userCredential = await _auth.signInWithCustomToken(tempToken["token"]!);

      String fcmToken = (await _fcm.getToken()) ?? "";
      UserModel _user = UserModel(
        uid: userCredential.user!.uid,
        email: email.trim(),
        name: name.trim(),
        createdDate: DateTime.now(),
        bio: bio,
        fcmToken: fcmToken,
      );
      await Firestore().createUser(_user);
      retVal = "success";
    } on PlatformException catch (e) {
      retVal = e.message!;
    } catch (e) {
      print(e);
    }

    return retVal;
  }

}