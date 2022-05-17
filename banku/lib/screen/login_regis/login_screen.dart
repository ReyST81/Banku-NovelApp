import 'package:banku/screen/home/home_nav.dart';
import 'package:banku/screen/login_regis/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
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
        emailController.text = value!;
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

    final passwordField = TextFormField(
      autofocus: false,
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
      controller: passwordController,
      obscureText: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 236, 240, 243),
          filled: true,
          prefixIcon: const Icon(Icons.lock),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Type Password Here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final loginButton = Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xff3A5568),
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: Text(
          "Log in",
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Log in",
                    style: GoogleFonts.dongle(
                        fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
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
                  passwordField,
                  const SizedBox(
                    height: 20,
                  ),
                  loginButton,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dont Have An Account?",
                          style: TextStyle(color: Color(0xff0D1667))),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const RegisterScreen();
                            }, transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              final tween = Tween(begin: 0.0, end: 2.0);
                              return FadeTransition(
                                  opacity: animation.drive(tween),
                                  child: child);
                            }),
                          );
                        },
                        child: const Text(
                          "Sign up",
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
      );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (uid) => {
              Fluttertoast.showToast(msg: "Login Successful"),
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const HomeNav();
                  }, transitionsBuilder: (context, animation, secondaryAnimation, child){
                    final tween = Tween(begin: 0.0, end: 2.0);
                    return FadeTransition(
                      opacity: animation.drive(tween),
                      child: child,
                    );
                  }
                ),
              ),
            },
          )
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
