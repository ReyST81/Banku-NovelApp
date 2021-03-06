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

    void AlertDialogBox(BuildContext context){
    // showDialog(
    //   context: context, 
    //   builder: (BuildContext context){
    //     return AlertDialog(
    //       content: Container(
    //         width: MediaQuery.of(context).size.width/1.2,
    //         height: MediaQuery.of(context).size.height/4,
    //         color: Colors.white,
    //         child: Container(
    //           margin: const EdgeInsets.all(10),
    //           child: Column(
    //             children: [
    //               ElevatedButton(
    //                 onPressed: (){}, 
    //                 child: child
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    // );
  }

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
                                        showDialog(
                                          context: context, 
                                          builder: (context){
                                            return  AlertDialog(
                                                content: Container(
                                                  width: MediaQuery.of(context).size.width/1.2,
                                                  height: MediaQuery.of(context).size.height/4,
                                                  color: Colors.white,
                                                  child: Container(
                                                    margin: const EdgeInsets.all(10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 40,),
                                                        Text(
                                                          "Are you sure you want to delete this Novel?",
                                                          textAlign: TextAlign.center,
                                                          style: GoogleFonts.dongle(fontSize: 28),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            ElevatedButton( 
                                                              onPressed: (){
                                                                final user = FirebaseAuth.instance.currentUser!.uid;
                                                                  myNovelProvider.deleteNovel(novelProvider
                                                                  .listMyPostNovel[index].key, novelProvider.listMyPostNovel[index], user);
                                                                  Navigator.of(context, rootNavigator: true).pop();
                                                              }, 
                                                              child: const Text("Yes"),
                                                              style: ElevatedButton.styleFrom(
                                                                primary: Colors.red
                                                              ),
                                                            ),
                                                            ElevatedButton( 
                                                              onPressed: (){
                                                                Navigator.of(context, rootNavigator: true).pop();
                                                              }, 
                                                              child: const Text("No"),
                                                              style: ElevatedButton.styleFrom(
                                                                primary: const Color(0xff3A5568)
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                          }
                                        );
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
