import 'package:myapp/screens/home/ui_home.dart';
import 'package:myapp/screens/register/ui_register.dart';
import 'package:myapp/screens/root/ui_root.dart';
import 'package:myapp/services/api.dart';
import 'package:myapp/services/auth.dart';
import 'package:flutter/material.dart';

class UiLogin extends StatefulWidget {
  @override
  _UiLoginState createState() => new _UiLoginState();
}

class _UiLoginState extends State<UiLogin> {
  final uiLoginKey = GlobalKey<ScaffoldState>();
  bool busy = false;

  TextEditingController email = TextEditingController();
  final loginEmail = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: uiLoginKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(),
          SizedBox(
            height: 20,
          ),
          Text("Login", style: Theme.of(context).textTheme.headline3,),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            key: loginEmail,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Email",
                labelText: "Email"
            ),
            controller: email,
            enableSuggestions: true,
            autofillHints: [AutofillHints.email],
          ),
          SizedBox(
            height: 40,
          ),
          MaterialButton(
            color: Colors.green,
            onPressed: () async {
              if(busy) {
                return;
              }
              setState(() {
                busy = true;
              });
              API().login(email.text.trim()).then((value) async {
                String token = value["token"] ?? "";

                String login = await Auth().loginToFirebase(token);
                if (login == "success") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UiRoot(),
                      ),
                      (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(login),
                    duration: Duration(seconds: 2),
                  ));
                }
              }).catchError((error) {
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
                ? CircularProgressIndicator(backgroundColor: Colors.black54,)
                : Text("Login"),
          ),
          MaterialButton(
            color: Colors.red,
            child: Text("Don't have an account? Sign up here"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UiRegister(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
