import 'package:banku/model/novel_model.dart';
import 'package:banku/screen/home/detail_screen.dart';
import 'package:banku/screen/home/search_fitur.dart';
import 'package:banku/screen/login_regis/login_screen.dart';
import 'package:banku/screen/viewModel/view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit == true) {
      Provider.of<NovelViewModel>(context).getAllPostNovel();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var novelPostProvider =
          Provider.of<NovelViewModel>(context, listen: false);
      await novelPostProvider.getAllPostNovel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final NovelProvider = Provider.of<NovelViewModel>(context);
    if (NovelProvider.listPostNovel.isEmpty) {
      const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 18, right: 18, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          showSearch(context: context, delegate: SearchNovel());
                        },
                        icon: const Icon(Icons.search)),
                    Text(
                      "BANKU",
                      style: GoogleFonts.dongle(
                          fontSize: 36,
                          color: const Color(0xff3A5568),
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          logout(context);
                        },
                        icon: const Icon(Icons.logout))
                  ],
                ),
                Text(
                  "Explore All Novel",
                  style: GoogleFonts.dongle(fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 600,
                  child: novelListNew(context, NovelProvider.listPostNovel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget novelListNew(context, List<NovelModel> viewModel) {
    if (viewModel.isEmpty) {
      return Center(
        child: Text(
          "There Are No Novels Uploaded Yet.",
          style: GoogleFonts.dongle(fontSize: 25),
        ),
      );
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: viewModel.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DetailNovel(
                        image: viewModel[index].image,
                        title: viewModel[index].title,
                        genre: viewModel[index].genre,
                        description: viewModel[index].description,
                        content: viewModel[index].content),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  final tween = Tween(begin: 0.0, end: 2.0);
                  return FadeTransition(
                      opacity: animation.drive(tween), child: child);
                }));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage(viewModel[index].image!),
                  height: 150,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: SpinKitCubeGrid(
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("title : "),
                          Expanded(
                              child: Text(
                            viewModel[index].title!,
                            textAlign: TextAlign.start,
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text("genre : "),
                          Flexible(
                              child: Text(viewModel[index].genre!,
                                  textAlign: TextAlign.start)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
