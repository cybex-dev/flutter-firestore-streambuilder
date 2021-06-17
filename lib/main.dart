import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:myapp/models/dto/auth_model.dart';
import 'package:myapp/models/dto/user_model.dart';
import 'package:myapp/screens/root/ui_root.dart';
import 'package:myapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

bool emulator = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (emulator) {
    await FirebaseAuth.instance.useEmulator('http://10.0.2.2:9099');
    FirebaseFirestore.instance.settings = Settings(
        host: '10.0.2.2:8080', sslEnabled: false, persistenceEnabled: true);
    FirebaseFunctions.instance
        .useFunctionsEmulator(origin: 'http://10.0.2.2:5001');
    FirebaseStorage.instance.useEmulator(host: '10.0.2.2', port: 9199);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthModel?>.value(
      value: Auth().authUserListener,
      initialData: null,
      child: MaterialApp(
        title: 'CozyUp Test',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: UiRoot(),
      ),
    );
  }
}
