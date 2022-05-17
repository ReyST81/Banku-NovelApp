import 'package:banku/screen/home/detail_screen.dart';
import 'package:banku/screen/viewModel/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchNovel extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // ignore: non_constant_identifier_names
    final NovelProvider = Provider.of<NovelViewModel>(context);
     return FutureBuilder<void>(
       future: NovelProvider.getSearch(query),
       builder: (context, snapshot) {
         return ListView.builder(
           itemCount: NovelProvider.result.length,
           itemBuilder: (context, index) {
             return GestureDetector(
               onTap: (){
                 Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DetailNovel(
                        image: NovelProvider.result[index].image,
                        title: NovelProvider.result[index].title,
                        genre: NovelProvider.result[index].genre,
                        description: NovelProvider.result[index].description,
                        content: NovelProvider.result[index].content),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  final tween = Tween(begin: 0.0, end: 2.0);
                  return FadeTransition(
                      opacity: animation.drive(tween), child: child);
                }));
               },
               child: Container(
                 margin: const EdgeInsets.all(15),
                 child: Row(
                   children: [
                     Image(image: NetworkImage(NovelProvider.result[index].image!), height: 150,width: 150,),
                     SizedBox(width: 100, child: Text(NovelProvider.result[index].title!),)
                   ],
                 ),
               )
             );
           },
         );
       } 
    
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text("Search Novel"),);
  }
}
