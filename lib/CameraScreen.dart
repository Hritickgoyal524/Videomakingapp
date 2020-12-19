import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:videomalingapp/Constant.dart';
import 'package:videomalingapp/help.dart';
// ignore: must_be_immutable
class CameraScreen extends StatefulWidget{
  List<CameraDescription> camera;
  CameraScreen({this.camera});
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  
 
  CameraController controller;
  int cameraindex;
  bool isrecording=false;
  String filepath;
void initState(){
  print("cameraScreen");
  getuser();
  print(Constants.mystring);
  super.initState();
  
if(widget.camera.length!=0){
  cameraindex=0;
  initcamera(widget.camera[cameraindex]);
}
  
  
}
getuser()async{
    Constants.mystring=await Helperfunction.getUsernamesharedprefence();
  }
Future uploadimage()async{
 firebase_storage.Reference ref =firebase_storage.FirebaseStorage.instance.ref().child("${Constants.mystring}/${filepath}/");
firebase_storage.UploadTask uploadTask=ref.putFile(File(filepath));
await uploadTask.whenComplete(() {
 
});
}
initcamera(CameraDescription camera)async{
if(controller!=null){
  await controller.dispose();
}
controller=CameraController(camera,ResolutionPreset.high,);
controller.addListener(()=>this.setState(() {
  
}));
controller.initialize();

}
Widget builcamer(){
  if(controller==null||! controller.value.isInitialized){
    return Center(child: CircularProgressIndicator());
  }
else{
return AspectRatio(child:CameraPreview(controller),aspectRatio: controller.value.aspectRatio,);
}
}
 Widget buildcontrolls(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(icon: Icon(getcameraicon(widget.camera[cameraindex].lensDirection),size: 42), onPressed: 
        onswitchingcamera
      ),

      IconButton(icon: Icon(Icons.radio_button_checked,size: 42,), onPressed:isrecording?null:record),
      IconButton(icon: Icon(Icons.stop,size: 42,), onPressed:isrecording?onstop:null),
       IconButton(icon: Icon(Icons.play_arrow,size: 42,), onPressed:isrecording?null:onplay)

    ],
  );
  }
  IconData getcameraicon(CameraLensDirection lensDirection){
if(lensDirection==CameraLensDirection.back){
   return Icons.photo_camera_front;
}
else{
return Icons.photo_camera_rounded;
  }}
  onplay(){
    Toast.show("Recorded Video is now playing", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,textColor: Colors.amber);
    OpenFile.open(filepath);
  }
  Future onstop()async{
await controller.stopVideoRecording();
Toast.show("Video is recorded" , context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,textColor: Colors.amber);
setState(() {
  isrecording=false;

});
uploadimage();
Toast.show("Upload", context,gravity:Toast.CENTER,duration: Toast.LENGTH_LONG,textColor: Colors.amber);
  }
  Future record()async{
  var directory=await getTemporaryDirectory();
   filepath=directory.path+"/${DateTime.now()}.mp4";
   Toast.show("Video recording is started", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER,textColor: Colors.amber);
  controller.startVideoRecording(filepath);
  setState(() {
    isrecording=true;
  });

  }
void onswitchingcamera(){
  if(widget.camera.length<2){
    return;
  }
  cameraindex=(cameraindex+1)%2;
  initcamera(widget.camera[cameraindex]);
}



  Widget build (BuildContext context){
    return Scaffold(
      appBar:AppBar(
          title: Text("Video Making App"),
          centerTitle: true,
          backgroundColor: Colors.grey,
         // gradient: LinearGradient(colors: [Colors.red, Colors.purple])
),
      body:Container(
        margin: EdgeInsets.only(top:30),
        child: Column(
        children:[
          Container(height: MediaQuery.of(context).size.height-230,child:Center(child: builcamer())),
          SizedBox(height:17),
          buildcontrolls()
        ]
      ),),
    );
  }
}
