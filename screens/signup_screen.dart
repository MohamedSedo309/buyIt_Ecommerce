import 'package:buy_it/provider/progressHUD.dart';
import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/screens/user/homepage.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/auth.dart';

import '../constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class Signup_Screen extends StatelessWidget {
  static String screenID = 'SignupScreen';
  final form_key = GlobalKey<FormState>();

  var email = '';
  var password = '';

  submit(BuildContext ctx) async {
    var hud = Provider.of<ProgressHUDprovider>(ctx, listen: false);
    final progress = ProgressHUD.of(ctx);

    try {
      final isValid = form_key.currentState!.validate();
      FocusScope.of(ctx).unfocus();
      if (isValid) {
        hud.isLoading = true;
        form_key.currentState!.save();
        progress?.showWithText('Loading...');
        var user = await Auth().sign_UP(email, password);
        print(user.toString());
        progress?.dismiss();
        hud.isLoading = false;
        Navigator.of(ctx).pushReplacementNamed(HomePage.screenID);
      }
    } on FirebaseAuthException catch (e) {
      progress?.dismiss();
      hud.isLoading = false;

      String error_msg = "";
      if (e.code == 'weak-password') {
        error_msg = 'Too weak password';
      } else if (e.code == 'email-already-in-use') {
        error_msg = 'Account already exists for that email try to sign in';
      } else if (e.code == 'user-not-found') {
        error_msg = 'No user found try sign up';
      } else if (e.code == 'wrong-password') {
        error_msg = 'Wrong password';
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(error_msg),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (e) {
      print(e);
      progress?.dismiss();
      hud.isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screen_hieght = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<ProgressHUDprovider>(
      create: (context) => ProgressHUDprovider(),
      child: Scaffold(
        backgroundColor: mainColor,
        body: ProgressHUD(
          indicatorColor: Colors.amber,
          indicatorWidget: CircularProgressIndicator(
            color: mainColor,
          ),
          child: Form(
            key: form_key,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    height: screen_hieght * 0.3,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/icons/buy_it.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Buy it',
                            style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screen_hieght * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    key: ValueKey('name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintText: "Enter your Name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: mainColor,
                      ),
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screen_hieght * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    key: ValueKey('email'),
                    onSaved: (val) {
                      email = val!;
                    },
                    validator: (value) {
                      if (value!.isEmpty ||
                          !value.contains("@") ||
                          !value.contains(".")) {
                        return 'Please enter a valid email';
                      }
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: mainColor,
                      ),
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screen_hieght * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    key: ValueKey('password'),
                    onSaved: (val) {
                      password = val!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be 6 characters or more';
                      }
                    },
                    cursorColor: mainColor,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: mainColor,
                      ),
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screen_hieght * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child: Builder(
                    builder: (ctx) => FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.black,
                      onPressed: () {
                        submit(ctx);
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screen_hieght * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Login_Screen.screenID);
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
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
}
