import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/dto/user_model.dart';
import 'package:myapp/screens/login/ui_login.dart';
import 'package:myapp/services/api.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UiRegister extends StatefulWidget {
  @override
  _UiRegisterState createState() => new _UiRegisterState();
}

class _UiRegisterState extends State<UiRegister> {
  bool busy = false;
  final uiRegisterKey = GlobalKey<ScaffoldState>();
  final emailKey = GlobalKey<FormFieldState>();
  final nameKey = GlobalKey<FormFieldState>();
  final bioKey = GlobalKey<FormFieldState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: uiRegisterKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(),
          SizedBox(
            height: 20,
          ),
          Text(
            "Register",
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            key: emailKey,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Email",
                labelText: "Email"),
            controller: email,
            enableSuggestions: true,
            autofillHints: [AutofillHints.email],
          ),
          TextFormField(
            key: nameKey,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Name",
                labelText: "Name"),
            controller: name,
            enableSuggestions: true,
            autofillHints: [AutofillHints.email],
          ),
          TextFormField(
            key: bioKey,
            decoration: InputDecoration(hintText: "Bio", labelText: "Bio"),
            controller: bio,
            minLines: 3,
            maxLines: 3,
          ),
          SizedBox(
            height: 40,
          ),
          MaterialButton(
            color: Colors.green,
            onPressed: () async {
              if (busy) {
                return;
              }
              setState(() {
                busy = true;
              });
              Auth()
                  .signUpUser(
                      name.text.trim(), email.text.trim(), bio.text.trim())
                  .then((value) => {
                        print(
                            "registered successfully with uid [${FirebaseAuth.instance.currentUser!.uid}]")
                      })
                  .catchError((error) {
                print(error);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Critical error"),
                  duration: Duration(seconds: 2),
                ));
              }).whenComplete(() {
                setState(() {
                  busy = false;
                });
              });
            },
            child: busy
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      backgroundColor: Colors.black54,
                    ),
                  )
                : Text("Register"),
          ),
          MaterialButton(
            color: Colors.red,
            child: Text("Got an account, login..."),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UiLogin(),
                ),
              );
            },
          ),
          MaterialButton(
            onPressed: () async {
              var currentUser = Firestore().getCurrentUser(FirebaseAuth.instance.currentUser!.uid);
    currentUser.last.then((value) {
      print("Got user model");
      print(value!.toJson());
    }).catchError((error) {
      print(error);
    }).whenComplete(() {
      print("complete");
    });
              // FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get.snapshots().map((value) {
              //   print(value);
              // });
              // print("done");
            },
            child: Text("GET"),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Text("LOGOUT"),
          )
        ],
      ),
    );
  }
}
