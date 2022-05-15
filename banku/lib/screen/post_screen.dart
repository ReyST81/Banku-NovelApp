import 'package:banku/screen/home_nav.dart';
import 'package:banku/screen/viewModel/view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  String? user;
  Future<void> getUserId() async{
    User userData = FirebaseAuth.instance.currentUser!;
    setState(() {
      user = userData.uid.toString();
    });
  }
  @override
  void initState() {
    getUserId();
    super.initState();
  }

  final imageEditingController = TextEditingController();
  final titleEditingController = TextEditingController();
  final genreEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final contentEditingController = TextEditingController();
  String image = '';
  String title = '';
  String genre = '';
  String description = '';
  String content = '';

//coba onChange

  @override
  Widget build(BuildContext context) {
    final novelProvider = Provider.of<NovelViewModel>(context);
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
      textInputAction: TextInputAction.done,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Please Write Your Novel Story Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),),
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
        onPressed: () {
          novelProvider.postNovel(
            image, title, genre, description, content, user
          );
          Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
          return const HomeNav();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: 0.0, end: 2.0);
          return FadeTransition(
            opacity: animation.drive(tween),
            child: child,
          );
        }),
        (route) => false);
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
                  "Post",
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
