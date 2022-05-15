import 'package:banku/model/log_model.dart';
import 'package:banku/screen/login_regis/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final usernameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final firstPasswordEditingController = TextEditingController();
  final secondPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      controller: usernameEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{4,}$');
        if (value!.isEmpty) {
          return ("Please enter your username");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid username (Min. 4 Character)");
        }
        return null;
      },
      onSaved: (value) {
        usernameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Type Username Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final emailField = TextFormField(
      controller: emailEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-].[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Type Email Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final firstPasswordField = TextFormField(
      obscureText: true,
      controller: firstPasswordEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid password (Min. 6 Character");
        }
        return null;
      },
      onSaved: (value) {
        firstPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          prefixIcon: const Icon(Icons.lock),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Type Password Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final secondPasswordField = TextFormField(
      obscureText: true,
      controller: secondPasswordEditingController,
      validator: (value) {
        if (secondPasswordEditingController.text !=
            firstPasswordEditingController.text) {
          return "password dont match";
        }
        return null;
      },
      onSaved: (value) {
        secondPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          prefixIcon: const Icon(Icons.lock),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final registerButton = Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xff3A5568),
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: () {
          signUp(emailEditingController.text,
              secondPasswordEditingController.text);
        },
        child: Text(
          "Sign up",
          style: GoogleFonts.dongle(color: Colors.white, fontSize: 30),
        ),
      ),
    );

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: GoogleFonts.dongle(
                          fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Username",
                      style: GoogleFonts.dongle(fontSize: 28),
                    ),
                    usernameField,
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Email",
                      style: GoogleFonts.dongle(fontSize: 28),
                    ),
                    emailField,
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Password",
                      style: GoogleFonts.dongle(fontSize: 28),
                    ),
                    firstPasswordField,
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Confirm Password",
                      style: GoogleFonts.dongle(fontSize: 28),
                    ),
                    secondPasswordField,
                    const SizedBox(
                      height: 20,
                    ),
                    registerButton,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Do you Have An Account?",
                            style: TextStyle(color: Color(0xff0D1667))),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Log in",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                {postDetailsToFirestore()}
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //manggil firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    LogModel logModel = LogModel();

    logModel.email = user!.email;
    logModel.userId = user.uid;
    logModel.username = usernameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(logModel.toMap());
    Fluttertoast.showToast(msg: "Account created succesfully");

    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
          return const LoginScreen();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: 0.0, end: 2.0);
          return FadeTransition(
            opacity: animation.drive(tween),
            child: child,
          );
        }),
        (route) => false);
  }
}
