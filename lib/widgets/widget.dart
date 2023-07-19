import 'package:flutter/material.dart';
import 'package:flutter_app_testing/views/image.dart';

import '../model/wallpaper_model.dart';

Widget brandName(){
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, ),
      children: const <TextSpan>[
        TextSpan(text: 'Waltz - ', style: TextStyle(color: Colors.teal)),
        TextSpan(text: ' HD Wallpapers', style: TextStyle(color: Colors.black87)),
      ],
    ),
    textAlign: TextAlign.center,
  );
}

Widget WallpapersList({required List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        return GridTile(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> ImageView(
                        imgUrl: wallpaper.src?.portrait??"",
                    )));
              } ,
              child: Hero(
                tag: "",
                child: Container(
                  child : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child : Image.network(wallpaper.src?.portrait ?? "", fit: BoxFit.cover,),
                  )
        ),
              ),
            ));
      }).toList(),
    ),
  );
}