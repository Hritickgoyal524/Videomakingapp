
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:toast/toast.dart';
import 'package:videomalingapp/CameraScreen.dart';
import 'package:videomalingapp/auth.dart';
import 'package:videomalingapp/help.dart';


class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({this.toggle});
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isloading = false;
  AuthMethods authMethods = new AuthMethods();
  //DatabaseAuth databaseAuth = new DatabaseAuth();
  final formkey = GlobalKey<FormState>();
  TextEditingController usernameTexteditingcontroller =  new TextEditingController();
  TextEditingController emailTexteditingcontroller = new TextEditingController();
  TextEditingController passwordTexteditingcontroller = new TextEditingController();
   List<CameraDescription> camera;
  void initState(){
    super.initState();
   
         availableCameras().then((value) {
camera=value;});
  }
  signMeUp() {
    if (formkey.currentState.validate()) {
     
      Helperfunction.savedUsernamesharedprefence(
          usernameTexteditingcontroller.text);
      Helperfunction.savedUseremailsharedprefence(
          emailTexteditingcontroller.text);
      setState(() {
        isloading = true;
      });
      authMethods.signUpWithEmailAndPassword(emailTexteditingcontroller.text,
              passwordTexteditingcontroller.text).then((value) {
        print("$value");
        print("mail");
        if(value==null){
          Toast.show("NOT Added", context,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER);
        }
      //  databaseAuth.uploadUserName(userMap);
        else{
          
          Helperfunction.saveduserLoggingsharedprefence(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CameraScreen(camera:camera)));}
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Video Making App"),
          centerTitle: true,
         backgroundColor: Colors.grey,
),
        body: isloading
            ? Container(child: Center(child: CircularProgressIndicator()))
            : SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height - 50,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/bg.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.dstATop),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                              key: formkey,
                              child: Column(children: <Widget>[
                                TextFormField(
                                  validator: (value) {
                                    return value.length < 2 || value.isEmpty
                                        ? "Please probide a valid user name"
                                        : null;
                                  },
                                  controller: usernameTexteditingcontroller,
                                  style: TextStyle(fontSize: 17,
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: 'USER NAME',
                                    labelStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.verified_user,
                                      color: Colors.white,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)
                                        ? null
                                        : "Please provide a valid mail";
                                  },
                                  controller: emailTexteditingcontroller,
                                  style: TextStyle(fontSize: 17,
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: 'E-MAIL',
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: (value) {
                                    return value.length > 6
                                        ? null
                                        : "Please provide password 6+ character";
                                  },
                                  controller: passwordTexteditingcontroller,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: 'PASSWORD',
                                    labelStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                )
                              ])),
                          SizedBox(height: 17),
                          Container(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: Text(
                                  "Forgot Password ??",
                                  style:TextStyle(color: Colors.amber,fontSize: 18,fontWeight: FontWeight.w500),
                                ),
                              )),
                          SizedBox(
                            height: 17,
                          ),
                          GestureDetector(
                              onTap: () {
                                signMeUp();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 30),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        const Color(0xff007EF4),
                                        const Color(0xff2A75BC)
                                      ]),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ))),
                          SizedBox(
                            height: 13,
                          ),
                         
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Already have account?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17,fontWeight: FontWeight.w600)),
                              GestureDetector(
                                onTap: () {
                                  widget.toggle();
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text("Sign In Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500))),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 95,
                          )
                        ],
                      ),
                    ))));
  }
}