import 'dart:convert';
import 'package:banku/model/novel_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../novel_model.dart';

class NovelAPI{
  addNovelData({String? content, String? genre, String? title, String? description, String? image, String? user}) async{
    http.post(
      Uri.parse("https://miniproject-8163d-default-rtdb.firebaseio.com/PostNovel.json"),
      body: json.encode(
        {
          "content":content,
          "genre":genre,
          "title":title,
          "description":description,
          "image":image,
          "user": user
      })
    );
  }

  String? user;
  Future<void> getUserId() async{
    User userData = FirebaseAuth.instance.currentUser!;
    user = userData.uid.toString();
  }

  Future <List<NovelModel>> getPostNovel()async{
    List<NovelModel> listPostDisplay = [];
    final response = await Dio().get(
      "https://miniproject-8163d-default-rtdb.firebaseio.com/PostNovel.json"
    );
    (response.data as Map<String, dynamic>).forEach((key, value) {
      listPostDisplay.add(NovelModel(
          key: key, 
          image: value["image"],
          title: value["title"],
          genre: value["genre"],
          description: value["description"],
          content: value["content"]
      ),);
    });
    return listPostDisplay;
  }

  editNovelData({String? content, String? genre, String? title, String? description, String? image, String? key}) async{
    await Dio().put(
      "https://miniproject-8163d-default-rtdb.firebaseio.com/PostNovel/$key.json", data: jsonEncode({"content": content, "description":description, "genre":genre, "image":image, "title":title})
    );
  }

  deleteNovelData({key}) async{
    await Dio().delete(
      "https://miniproject-8163d-default-rtdb.firebaseio.com/PostNovel/$key.json"
    );
  }
}
