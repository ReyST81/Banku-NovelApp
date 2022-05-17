import 'package:banku/screen/home/detail_screen.dart';
import 'package:banku/screen/myNovel/edit_screen.dart';
import 'package:banku/screen/viewModel/view_model_myNovel.dart';
import 'package:banku/screen/viewModel/view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      final user = FirebaseAuth.instance.currentUser;
      Provider.of<NovelViewModel>(context).getAllMyPostNovel(user!.uid);
      isInit = false;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final novelProvider = Provider.of<NovelViewModel>(context);
    final myNovelProvider = Provider.of<MyNovelViewModel>(context);
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
                novelProvider.listMyPostNovel.isEmpty? Center(child: Text("You Haven't post anything yet", style: GoogleFonts.dongle(fontSize: 25),),) :
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: novelProvider.listMyPostNovel.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        key: Key(novelProvider.listMyPostNovel[index].key!),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailNovel(
                                  image:
                                      novelProvider.listMyPostNovel[index].image,
                                  title:
                                      novelProvider.listMyPostNovel[index].title,
                                  genre:
                                      novelProvider.listMyPostNovel[index].genre,
                                  description: novelProvider
                                      .listMyPostNovel[index].description,
                                  content: novelProvider
                                      .listMyPostNovel[index].content),
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
                                      novelProvider.listMyPostNovel[index].image!),
                                  height: 150,
                                  width: 150,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                      novelProvider.listMyPostNovel[index].title!),
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
                                              novel: novelProvider
                                                  .listMyPostNovel[index],
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
                                        final user = FirebaseAuth.instance.currentUser!.uid;
                                        myNovelProvider.deleteNovel(novelProvider
                                            .listMyPostNovel[index].key, novelProvider.listMyPostNovel[index], user);
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
