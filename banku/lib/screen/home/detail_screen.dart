// import 'package:banku/model/novel_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailNovel extends StatefulWidget {
  final String? image;
  final String? title;
  final String? genre;
  final String? description;
  final String? content;
  const DetailNovel({ Key? key ,this.image, this.title,this.genre, this.description, this.content}) : super(key: key);

  @override
  State<DetailNovel> createState() => _DetailNovelState();
}

class _DetailNovelState extends State<DetailNovel> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3A5568),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: (){
          Navigator.pop(context);
        },
        )
        
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(right: 16, left: 16, top: 20),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(widget.image!.toString()),)
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(widget.title.toString(), style: GoogleFonts.dongle(fontSize: 26)),
                    const Divider(
                          color: Colors.black,
                        ),
                    Text(widget.genre.toString(), style: GoogleFonts.dongle(fontSize: 26)),
                    const Divider(
                          color: Colors.black,
                        ),
                    Text("Description", style: GoogleFonts.dongle(fontSize: 26)),
                    Text(widget.description.toString(),  textAlign: TextAlign.center,),
                    const Divider(
                          color: Colors.black,
                        ),
                    const SizedBox(height: 20,),
                    Text(widget.content.toString(), style: GoogleFonts.dongle(fontSize: 26),)
                  ],
                ),
              )
            ),
          ),
        ),
    );
  }
}
