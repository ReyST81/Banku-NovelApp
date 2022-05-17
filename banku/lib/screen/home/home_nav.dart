import 'package:banku/screen/home/home_screen.dart';
import 'package:banku/screen/myNovel/my_novel.dart';
import 'package:banku/screen/home/post_screen.dart';
import 'package:flutter/material.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  int _selectedIndex = 0;
  final _layoutPage = [const HomeScreen(), const PostScreen(), const MyNovel()];
  void _onTabItem(int index) {
    setState(
      () {
      _selectedIndex = index;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutPage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff3A5568),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_rounded,
              color: Colors.white,
            ),
            label: "Post",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              color: Colors.white,
            ),
            label: "MyNovel",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTabItem,
      ),
    );
  }
}
