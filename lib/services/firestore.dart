import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/dto/user_model.dart';

class Firestore {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserModel?> getCurrentUser(String uid) {
    // print("Getting UserModel for [$uid]");
    // var instance = FirebaseFirestore.instance;
    // print("[Firestore#getCurrentUser] got firestore instance");
    // var collection = instance.collection('users');
    // print("[Firestore#getCurrentUser] got users collection reference");
    // var doc = collection.doc(uid);
    // print("[Firestore#getCurrentUser] got doc reference for [$uid]");
    // var snapshots = doc.snapshots();
    // print("[Firestore#getCurrentUser] got doc snapshots stream for [$uid]");
    // var map = snapshots.map((event) => UserModel.fromJson(event.data() ?? {}));
    // print("[Firestore#getCurrentUser] got UserModel map stream for document [$uid]");
    // map.length.then((value) {
    //     print("collection > doc [$uid] > snapshots length is $value");
    // }).catchError((error) {
    //   print("Error getting collection > doc [$uid] > snapshots length");
    //   print(error);
    // });
    // return map;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots().map((event) => event.data()).map((event) => event == null ? null : UserModel.fromJson(event));
  }

  Future<void> createUser(UserModel userModel) {
    return _firestore
        .collection('users')
        .doc(userModel.uid)
        .set(userModel.toJson());
  }
}
