import 'package:myapp/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends Object {

  final String uid;
  final String name;
  final String email;
  final String bio;
  final String fcmToken;
  @JsonKey(fromJson: _dateTimeFromMilliseconds, toJson: _dateTimeToMilliseconds)
  final DateTime createdDate;

  UserModel({required this.uid, required this.name, required this.email, required this.createdDate, required this.bio, required this.fcmToken});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) =>
      UserModel.fromJson(doc.data() ?? {});

  static DateTime _dateTimeFromMilliseconds(String? timeformat) => timeformat == null ? DateTime.now() : DateTime.parse(timeformat);

  static String _dateTimeToMilliseconds(DateTime? dateTime) => dateTime == null ? DateTime.now().toIso8601String() : dateTime.toIso8601String();

  static fromFirebaseUser({required User user}) {
    return Firestore().getCurrentUser(user.uid);
  }

  // listen to profile document snapshots as stream, map to user model
}