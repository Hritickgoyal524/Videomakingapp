
import "package:flutter/material.dart";
import 'package:videomalingapp/Signin.dart';
import 'package:videomalingapp/Signup.dart';
class Authenticate extends StatefulWidget{
  _AuthenticateState createState()=> _AuthenticateState();

}
class _AuthenticateState extends State<Authenticate>{
  bool showSignIn=true;
  void toggle(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  void initState(){
    super.initState();  }

Widget build(BuildContext context){
  if (showSignIn){
  return Signin(toggle: toggle,);
  }
  else{
return SignUp(toggle: toggle,);
  }
}
}