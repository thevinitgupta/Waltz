import 'dart:typed_data';

import 'package:flutter/material.dart';
import "package:dio/dio.dart";
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String ? imgUrl;
  ImageView({required this.imgUrl});
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl?? "",
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child : Image.network(widget.imgUrl??"", fit: BoxFit.cover,),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    _save();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      border : Border.all(color : Colors.white60, width: 1),
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          Color(0x36FFFFFF),
                          Color(0x0FFFFFFF),
                        ]
                      )
                    ),
                    child: Column(
                      children: <Widget>[
                        Text("Set Wallpaper", style: TextStyle(
                          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500
                        ),),
                        Text("Image will be saved in Gallery", style : TextStyle(
                          fontSize: 10, color: Colors.white
                        ))
                      ],
                    ),
                  ),
                ),
                Text("Cancel", style: TextStyle(color: Colors.white),),
                SizedBox(height: 50,)
              ],
            ),
          )
        ],
      )
    );
  }
  _save() async{
    if(Platform.isAndroid){
      await _askPermission();
    }
    var response = await Dio().get(
        widget.imgUrl?? "",
        options : Options(responseType : ResponseType.bytes)
    );

    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result.toString());
  }

  _askPermission() async{
    if(Platform.isIOS){
      Map<Permission, PermissionStatus> permissions = await [Permission.photos].request();
    }
    else{
      PermissionStatus permission = await Permission.storage.request();
    }
  }
}
