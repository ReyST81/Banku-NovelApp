// import 'package:flutter/cupertino.dart';
// import 'dart:convert';

import 'package:banku/model/api/novel_api.dart';
import 'package:banku/model/novel_model.dart';
import 'package:flutter/material.dart';

class NovelViewModel with ChangeNotifier{

  List<NovelModel> _listPostNovel = [];
  List<NovelModel> get listPostNovel => _listPostNovel;

  List<NovelModel> _listMyPostNovel = [];
  List<NovelModel> get listMyPostNovel => _listMyPostNovel;

  List<NovelModel> result = [];
  List<NovelModel> get listsearch => result;
  

  postNovel(image, title, genre, description, content, user, date)async{
    await NovelAPI().addNovelData(image: image, title: title, genre: genre, description: description, content: content , user: user, date: date);
    notifyListeners();
  }

  getAllPostNovel()async{
    final allPostNovel = await NovelAPI().getPostNovel();
    _listPostNovel = allPostNovel;
    _listPostNovel.sort((b, a) {
      return a.date!.compareTo(b.date!);
    },);
    notifyListeners();
  }

  getAllMyPostNovel(user) async{
    final allMyPostNovel = await NovelAPI().getMyPostNovel(user);
    _listMyPostNovel = allMyPostNovel;
    notifyListeners();
  }

  getSearch(query)async{
    final allPostNovel = await NovelAPI().getPostNovel();
    _listPostNovel = allPostNovel;
    result = _listPostNovel.where((element) {
      return element.title!.toLowerCase().contains(query.toLowerCase());
    },).toList();
  }

  Future<void> deleteNovel(key, novel, user)async{
    await NovelAPI().deleteNovelData(key: key, user: user);
    _listPostNovel.removeWhere((e)=> e.key == key);
    notifyListeners();
  }
}