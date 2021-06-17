// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  print("Mapping json to object");
  if (json == null || json.length == 0) {
    return UserModel(uid: "", name: "", email: "", createdDate: DateTime.now(), bio: "", fcmToken: "");
  }
  print(json.entries.map((e) => e.key + e.value).fold("", (previousValue, element) => "$previousValue,\n$element"));
  return UserModel(
    uid: json['uid'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    createdDate:
        UserModel._dateTimeFromMilliseconds(json['createdDate'] as String?),
    bio: json['bio'] as String,
    fcmToken: json['fcmToken'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'bio': instance.bio,
      'fcmToken': instance.fcmToken,
      'createdDate': UserModel._dateTimeToMilliseconds(instance.createdDate),
    };
