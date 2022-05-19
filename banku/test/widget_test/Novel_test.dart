import 'package:banku/screen/home/home_screen.dart';
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

  testWidgets('judul halaman', (WidgetTester tester) async{
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => NovelViewModel(),
      child: const MaterialApp(home: HomeScreen(),),
    ));
    await tester.pumpAndSettle();
    expect(find.text("Explore All Novel"), findsOneWidget);
  });

  testWidgets('Pada halaman harus ada Icon Search', (WidgetTester tester) async{
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => NovelViewModel(),
      child: const MaterialApp(home: HomeScreen(),),
    ));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
  });
}