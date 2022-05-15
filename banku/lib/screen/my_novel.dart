import 'package:banku/screen/detail_screen.dart';
import 'package:banku/screen/edit_screen.dart';
import 'package:banku/screen/viewModel/view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyNovel extends StatefulWidget {
  const MyNovel({Key? key}) : super(key: key);

  @override
  State<MyNovel> createState() => _MylistPostNoveltate();
}

class _MylistPostNoveltate extends State<MyNovel> {
  bool isInit = true;
  
  @override
  void didChangeDependencies(){
    if(isInit == true){
      Provider.of<NovelViewModel>(context).getAllPostNovel();
      isInit = false;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final novelProvider = Provider.of<NovelViewModel>(context);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff3A5568),
            title: Center(
              child: Text(
                "All My Novel",
                style: GoogleFonts.dongle(fontSize: 35),
              ),
            ),
          ),
          body: Container(
            key: const Key("message this is Ok"),
            margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: novelProvider.listPostNovel.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        key: Key(novelProvider.listPostNovel[index].key),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailNovel(
                                  image:
                                      novelProvider.listPostNovel[index].image,
                                  title:
                                      novelProvider.listPostNovel[index].title,
                                  genre:
                                      novelProvider.listPostNovel[index].genre,
                                  description: novelProvider
                                      .listPostNovel[index].description,
                                  content: novelProvider
                                      .listPostNovel[index].content),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Image(
                                  image: NetworkImage(
                                      novelProvider.listPostNovel[index].image),
                                  height: 150,
                                  width: 150,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                      novelProvider.listPostNovel[index].title),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditScreen(
                                              keys: novelProvider
                                                  .listPostNovel[index].key,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color(0xff3A5568)
                                      ),
                                      child: const Text("Edit"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        novelProvider.deleteNovel(novelProvider
                                            .listPostNovel[index].key, index);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color(0xff3A5568)
                                      ),
                                      child: const Text("Delete"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
