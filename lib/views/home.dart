import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_testing/data/data.dart';
import 'package:flutter_app_testing/model/wallpaper_model.dart';
import 'package:flutter_app_testing/views/categories.dart';
import 'package:flutter_app_testing/views/search.dart';
import 'package:flutter_app_testing/widgets/widget.dart';


import 'package:http/http.dart' as http;

import '../model/categories_model.dart';

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = <CategoriesModel>[];
  List<WallpaperModel> wallpapers = <WallpaperModel>[];

  TextEditingController searchController = new TextEditingController();

  void getTrendingWallpapers() async{

    String apiKey = "IzZ4awUXojz1tp7jxOx7ZsPgoKFbsCOHG9wsYpVQk4zVSr12x02XJxro";
    String url = "https://api.pexels.com/v1/curated?per_page=15";
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

    setState(() {});
  }

  void initState(){
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child : Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30),
                  ),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child : Row(children: <Widget>[
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: "search wallpapers",
                    border : InputBorder.none
                  ),
                ),),
               InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                       builder: (context) => Search(
                          searchQuery: searchController.text,
                       )
                   ));
                 },
                 child : Container(
                       child: Icon(Icons.search)),
               ),
            ],)
          ),
            SizedBox(height: 16,),
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
        ],
      ),)),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  // const CategoriesTile({Key? key}) : super(key: key);
  final String? imgUrl, title;
  CategoriesTile({this.imgUrl, this.title}){}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Category(
              categoryName: title?.toLowerCase() ?? "",
            )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(children: <Widget>[
          ClipRRect(
            borderRadius : BorderRadius.circular(8),
            child: Image.network(imgUrl?? "https://podcastingresources.com/wp-content/uploads/2019/09/Pexels-logo.jpg", height: 50, width: 100,fit: BoxFit.cover,),
          ),
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color : Colors.black26
            ),
            alignment: Alignment.center,
            child : Text(title?? "Category", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),),),

        ],),
      ),
    );
  }
}

