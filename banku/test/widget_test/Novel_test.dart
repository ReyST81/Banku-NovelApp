import 'package:banku/model/novel_model.dart';
import 'package:banku/screen/detail_screen.dart';
import 'package:banku/screen/edit_screen.dart';
import 'package:banku/screen/home_screen.dart';
import 'package:banku/screen/my_novel.dart';
import 'package:banku/screen/viewModel/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding{
  @override
  bool get overrideHttpClient => false;
}

void main(){
  CustomBindings();
  group("Widget Test", (){
    testWidgets('judul halaman', (WidgetTester tester) async{
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => NovelViewModel(),
      child: const MaterialApp(home: HomeScreen(),),
    ));
    await tester.pumpAndSettle();
    expect(find.text("BANKU"), findsOneWidget);
  });
  testWidgets('Harus ada icon', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home: DetailNovel(),));
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
  });
  testWidgets('coba cari key', (WidgetTester tester) async{
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => NovelViewModel(),
      child: const MaterialApp(home: MyNovel(),
      )));
      await tester.pumpAndSettle();
    expect(find.byKey(const Key("message this is Ok")), findsOneWidget); 
  });
    testWidgets('harus ada text title', (WidgetTester tester) async{
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => NovelViewModel(),
      child: const MaterialApp(home: EditScreen(),
    )));
    await tester.pumpAndSettle();
    expect(find.text("Title"), findsOneWidget);
  });
  });
}