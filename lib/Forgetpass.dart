import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:videomalingapp/auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
 bool isloading = false;
  final formkey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  TextEditingController emailTexteditingcontroller =new TextEditingController();
   reset() async{ if (formkey.currentState.validate()) {
setState(() {
        isloading = true;
      });
    await authMethods.resetPass(emailTexteditingcontroller.text);
    Toast.show("Reset Link is send to your given email id", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
     Navigator.pop(context);
   }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
title:Text("Video Uploading App"),
centerTitle: true,
      ),
        body: SingleChildScrollView(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Form(
                        key: formkey,
                        child: Column(children: [
                          Container(
                            height: 65,
                            width: 375,
                            //color: Colors.deepOrange,
                            decoration: BoxDecoration(
                              //color: Colors.lightBlue.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? null
                                    : "Please provide a valid mail";
                              },
                              controller: emailTexteditingcontroller,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'REG E-MAIL',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                          ),
                         
                         
                     
                      SizedBox(
                        height: 28,
                      ),
                      GestureDetector(
                          onTap: () {
                            reset();
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
                                "Reset Password",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ))),
                      
                      SizedBox(
                        height: 12,
                      ),
                     
                      
                    ],
                  ),
                )])))));
  }
}





