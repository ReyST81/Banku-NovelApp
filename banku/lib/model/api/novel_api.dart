import 'dart:convert';
import 'package:banku/model/novel_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../novel_model.dart';

class NovelAPI{
  addNovelData({String? content, String? genre, String? title, String? description, String? image, String? user}) async{
    await Dio().post("https://banku-ec38c-default-rtdb.firebaseio.com/PostNovel/$user.json", data: jsonEncode(
      {
          "content":content,
          "genre":genre,
          "title":title,
          "description":description,
          "image":image,
      }
    ));
  }

  String? user;
  Future<void> getUserId() async{
    User userData = FirebaseAuth.instance.currentUser!;
    user = userData.uid.toString();
  }

  Future <List<NovelModel>> getPostNovel()async{
    List<NovelModel> listPostDisplay = [];
    final response = await Dio().get(
      "https://banku-ec38c-default-rtdb.firebaseio.com/PostNovel.json"
    );
    if(response.data != null){
      (response.data as Map<String,dynamic>).forEach((key, value) {
      
      for(var i in value.keys){
        listPostDisplay.add(NovelModel(
          key: i, 
          image: value[i]["image"],
          title: value[i]["title"],
          genre: value[i]["genre"],
          description: value[i]["description"],
          content: value[i]["content"]
      ),);
      }
      
    });
    }
    return listPostDisplay;
  }

  Future <List<NovelModel>> getMyPostNovel(user)async{
    List<NovelModel> listPostDisplay = [];
    final response = await Dio().get(
      "https://banku-ec38c-default-rtdb.firebaseio.com/PostNovel/$user.json"
    );
    if(response.data != null){
      (response.data as Map<String,dynamic>).forEach((key, value) {
      
      listPostDisplay.add(NovelModel(
          key: key, 
          image: value["image"],
          title: value["title"],
          genre: value["genre"],
          description: value["description"],
          content: value["content"],
          user: user
      ),);
      
    });
    }
    return listPostDisplay;
  }

  editNovelData({String? content, String? genre, String? title, String? description, String? image, String? key, String? user}) async{
    await Dio().put(
      "https://banku-ec38c-default-rtdb.firebaseio.com/PostNovel/$user/$key.json", data: jsonEncode({"content": content, "description":description, "genre":genre, "image":image, "title":title})
    );
  }

  deleteNovelData({key, user}) async{
    await Dio().delete(
      "https://banku-ec38c-default-rtdb.firebaseio.com/PostNovel/$user/$key.json"
    );
  }
}
