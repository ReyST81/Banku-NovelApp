import 'package:banku/model/novel_model.dart';
import 'package:banku/screen/viewModel/view_model_myNovel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final NovelModel? novel;

  const EditScreen({ Key? key, this.novel}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final imageEditingController = TextEditingController();
  final titleEditingController = TextEditingController();
  final genreEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final contentEditingController = TextEditingController();
  String key = '';
  String image = '';
  String title = '';
  String genre = '';
  String description = '';
  String content = '';

  @override
  void initState() {
    key = widget.novel!.key!;
    imageEditingController.text = widget.novel!.image!;
    titleEditingController.text = widget.novel!.title!;
    genreEditingController.text = widget.novel!.genre!;
    descriptionEditingController.text = widget.novel!.description!;
    contentEditingController.text = widget.novel!.content!;

    image = widget.novel!.image!;
    title = widget.novel!.title!;
    genre = widget.novel!.genre!;
    description = widget.novel!.description!;
    content = widget.novel!.content!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myNovelProvider = Provider.of<MyNovelViewModel>(context);
    final imageField = TextField(
      controller: imageEditingController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Please Write image link Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      onChanged: (String value) {
        image = value;
      },
    );

    final titleField = TextFormField(
      controller: titleEditingController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Please Write Your Title Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (String value) {
        title = value;
      },
    );

    final genreField = TextFormField(
      controller: genreEditingController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Please Write Your Genre Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (String value) {
        genre = value;
      },
    );

    final descriptionField = TextFormField(
      controller: descriptionEditingController,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Please Write Your Novel Description Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (String value) {
        description = value;
      },
    );

    final contentField = TextFormField(
      controller: contentEditingController,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Please Write Your Novel Story Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (String value) {
        content = value;
      },
    );

    final submitButton = Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xff3A5568),
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: () async{
          final user = FirebaseAuth.instance.currentUser;
          await myNovelProvider.editNovel(
            key ,image, title, genre, description, content, user!.uid
          );
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Novel has been edit");
        },
        child: Text(
          "Submit",
          style: GoogleFonts.dongle(color: Colors.white, fontSize: 30),
        ),
      ),
    );

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff3A5568),
              title: Center(
                child: Text(
                  "Edit",
                  style: GoogleFonts.dongle(fontSize: 35),
                ),
              ),
            ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 18, right: 18, top: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Image Url",
                      style: GoogleFonts.dongle(fontSize: 28),
                    ),
                    imageField,
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Title",
                      style: GoogleFonts.dongle(fontSize: 28),
                    ),
                    titleField,
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Genre",
                      style: GoogleFonts.dongle(fontSize: 28),
                    ),
                    genreField,
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.dongle(fontSize: 28),
                    ),
                    descriptionField,
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Content",
                      style: GoogleFonts.dongle(fontSize: 28),
                    ),
                    contentField,
                    const SizedBox(
                      height: 25,
                    ),
                    submitButton
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}