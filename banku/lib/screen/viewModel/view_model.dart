// import 'package:flutter/cupertino.dart';
// import 'dart:convert';

import 'package:banku/model/api/novel_api.dart';
import 'package:banku/model/novel_model.dart';
import 'package:flutter/material.dart';

class NovelViewModel with ChangeNotifier{

  List<NovelModel> _listPostNovel = [];
  List get listPostNovel => _listPostNovel;

  List<NovelModel> result = [];
  List<NovelModel> get listsearch => result;
  

  postNovel(image, title, genre, description, content, user)async{
    await NovelAPI().addNovelData(image: image, title: title, genre: genre, description: description, content: content , user: user);
    notifyListeners();
  }

  getAllPostNovel()async{
    final allPostNovel = await NovelAPI().getPostNovel();
    _listPostNovel = allPostNovel;
    notifyListeners();
  }

  getSearch(query)async{
    final allPostNovel = await NovelAPI().getPostNovel();
    _listPostNovel = allPostNovel;
    result = _listPostNovel.where((element) {
      return element.title!.toLowerCase().contains(query.toLowerCase());
    },).toList();
  }

  editNovel(key, image, title, genre, description, content)async{
    await NovelAPI().editNovelData(key:key,image: image, title: title, genre: genre, description: description, content: content );
    notifyListeners();
  }

  Future<void> deleteNovel(key, index)async{
    await NovelAPI().deleteNovelData(key: key);
    listPostNovel.removeAt(index);
    notifyListeners();
  }

  

  //ini untuk my novel

  // getAllMyNovel(query)async{
  //   final allPostNovel = await NovelAPI.getPostNovel();
  //   _listPostNovel = allPostNovel;
  //   result = listPostNovel.where((element) {
  //     return element.title!.toLowerCase().contains(query.toLowerCase());
  //   },).toList();
  //   notifyListeners();
  // }

  }