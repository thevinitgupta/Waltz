import 'package:flutter/material.dart';
import 'dart:convert';

import '../widgets/widget.dart';
import 'package:flutter_app_testing/model/wallpaper_model.dart';

import 'package:http/http.dart' as http;



class Search extends StatefulWidget {
  final String? searchQuery;
  Search({this.searchQuery});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = new TextEditingController();
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

    setState(() {});
  }
  void initState(){
    getSearchWallpapers(widget.searchQuery ?? "");
    super.initState();
    searchController.text = widget.searchQuery?? "";
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
                            getSearchWallpapers(searchController.text);
                          },
                          child : Container(
                              child: Icon(Icons.search)),
                        ),
                      ],)
                  ),
                  SizedBox(height: 16,),
                  WallpapersList(wallpapers: wallpapers, context : context)

                ])),
      )
    );
  }
}
