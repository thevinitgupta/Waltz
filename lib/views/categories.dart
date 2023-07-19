import 'package:flutter/material.dart';
import 'dart:convert';

import '../data/data.dart';
import '../model/categories_model.dart';
import '../model/wallpaper_model.dart';
import '../widgets/widget.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Category extends StatefulWidget {
  final String? categoryName;
  Category({this.categoryName});
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<CategoriesModel> categories = <CategoriesModel>[];

  List<WallpaperModel> wallpapers = <WallpaperModel>[];

  void getSearchWallpapers(String query) async{
  String apiKey = "IzZ4awUXojz1tp7jxOx7ZsPgoKFbsCOHG9wsYpVQk4zVSr12x02XJxro";
  String url = "https://api.pexels.com/v1/search?query=$query?per_page=15&page=1";
  var response = await http.get(Uri.parse(url), headers: {
  'Authorization' : apiKey ,
  });
  // print(response.body.toString());
  Map<String,dynamic> jsonData = jsonDecode(response.body);

  jsonData["photos"].forEach((wallMap){
  // print(wallMap);
  // print("\n");
  WallpaperModel wallpaper = new WallpaperModel();
  wallpaper = WallpaperModel.fromMap(wallMap);
  wallpapers.add(wallpaper);
  });
  setState((){});
}
void initState(){
  categories = getCategories();
    getSearchWallpapers(widget.categoryName?? "");
    super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: brandName(),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body : SingleChildScrollView(
          child : Container(
              child: Column(
                  children: <Widget>[
                    Container(
                        height: 80,
                        child : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return CategoriesTile(
                                title: categories[index].categoryName,
                                imgUrl: categories[index].imgUrl,
                              );
                            }
                        )),
                    SizedBox(height: 16,),
                    WallpapersList(wallpapers: wallpapers, context : context)
                  ])),
        )
    );;
  }
}
