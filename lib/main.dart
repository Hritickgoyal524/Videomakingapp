import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:videomalingapp/CameraScreen.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:videomalingapp/authenticate.dart';
import 'package:videomalingapp/help.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
runApp(MyApp());
}


class MyApp extends StatefulWidget {
  
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isuserloggedin;
 List<CameraDescription> camera;
  void initState() {
    getLoggedInfo();
    
         availableCameras().then((value) {
camera=value;});
    super.initState();
  }

  getLoggedInfo() async {
    await Helperfunction.getuserLoggingsharedprefence().then((value) {
      setState(() {
        isuserloggedin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  isuserloggedin != null
          ? isuserloggedin ? CameraScreen(camera:camera) :Container() //Authenticate()
          : Container(
              child: Center(
                child: Authenticate(),
                //child: MyHome(),
              ),
            ),
    
    );
  }
}

