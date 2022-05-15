import 'package:banku/model/api/novel_api.dart';
import 'package:banku/model/novel_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'Novel_api_test.mocks.dart';

@GenerateMocks([NovelAPI])
void main(){
  group('NovelAPI', (){	
    NovelAPI novelAPI = MockNovelAPI();
    test('get all novel', ()async {
    when(novelAPI.getPostNovel()).thenAnswer(
      (_) async => <NovelModel>[
        NovelModel(image: 'a' ,genre: 'b', content: 'c', user: 'd', title: 'e')
      ]
    );
    var novel = await novelAPI.getPostNovel();
    expect(novel.isNotEmpty, true);

  });
});
}