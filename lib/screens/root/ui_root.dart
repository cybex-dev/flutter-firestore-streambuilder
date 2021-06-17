import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/dto/auth_model.dart';
import 'package:myapp/models/dto/user_model.dart';
import 'package:myapp/screens/home/ui_home.dart';
import 'package:myapp/screens/login/ui_login.dart';
import 'package:myapp/screens/splashscreen/ui_splashscreen.dart';
import 'package:myapp/services/api.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus { unknown, notLoggedIn, loggedIn }

class UiRoot extends StatefulWidget {
  @override
  _UiRootState createState() => new _UiRootState();
}

class _UiRootState extends State<UiRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;
  String currentUid = "";
  final uiRootKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AuthModel? _authStream = Provider.of<AuthModel?>(context);
    print("AuthModel state changed");
    if (_authStream != null) {
      setState(() {
        print("AuthModel logged in state");
        _authStatus = AuthStatus.loggedIn;
        currentUid = _authStream.uid;
        Firestore().getCurrentUser(currentUid).listen((data) {
          print("Firestore Data Changed");
          print("Firestore change value: $data");
        });
      });
    } else {
      setState(() {
        print("AuthModel logged out state");
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (currentUid.isNotEmpty) {
    //   return Scaffold(
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           MaterialButton(
    //             onPressed: () async {
    //               var future = await FirebaseFirestore.instance
    //                   .collection('users')
    //                   .doc(currentUid)
    //                   .get();
    //               var data = future.data();
    //               var userModel = UserModel.fromJson(data ?? {});
    //               print(userModel);
    //             },
    //             child: Text("GET"),
    //           ),
    //           SizedBox(
    //             height: 12,
    //           ),
    //           MaterialButton(
    //             color: Colors.blue,
    //             onPressed: () async {
    //               await FirebaseAuth.instance.signOut();
    //             },
    //             child: Text("LOGOUT"),
    //           )
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        print("not logged in");
        retVal = UiLogin();
        break;
      case AuthStatus.loggedIn:
        print("checking logged in");
        retVal = StreamProvider<UserModel?>.value(
          value: Firestore().getCurrentUser(currentUid),
          initialData: UserModel.fromJson({}),
          child: LoggedIn(),
        );
        break;
      case AuthStatus.unknown:
      default:
        print("unknown login status");
        retVal = UiSplashScreen();
    }
    return retVal;
  }
}

class LoggedIn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<UserModel?>(
      builder: (context, snapshot) {
        print("Checking UserModel from stream provider");
        if (snapshot.data == null) {
          print("UserModel is null");
          return UiLogin();
        }

        print("UserModel is NOT null");
        return UiHome();
      },
    );
  }
}