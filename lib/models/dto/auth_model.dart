import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  String uid;
  User? user;
  bool loggedIn;

  AuthModel({
    required this.uid,
    required this.user,
    required this.loggedIn,
  });

  factory AuthModel.fromFirebaseUser({User? user}) => AuthModel(
      uid: user == null ? "" : user.uid, user: user, loggedIn: user != null);
}
