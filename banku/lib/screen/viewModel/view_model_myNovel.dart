import 'package:banku/model/api/novel_api.dart';
import 'package:banku/model/novel_model.dart';
import 'package:flutter/cupertino.dart';

class MyNovelViewModel extends ChangeNotifier{
  List<NovelModel> _listMyPostNovel = [];
  List<NovelModel> get listMyPostNovel => _listMyPostNovel;
  
  getAllMyPostNovel(user) async{
    final allMyPostNovel = await NovelAPI().getMyPostNovel(user);
    _listMyPostNovel = allMyPostNovel;
    notifyListeners();
  }

  editNovel(key, image, title, genre, description, content, user)async{
    await NovelAPI().editNovelData(key:key, image: image, title: title, genre: genre, description: description, content: content, user: user);
    notifyListeners();
  }

  Future<void> deleteNovel(key, novel, user)async{
    await NovelAPI().deleteNovelData(key: key, user: user);
    _listMyPostNovel.removeWhere((e)=> e.key == key);
    notifyListeners();
  }
}