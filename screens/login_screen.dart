import 'package:buy_it/provider/progressHUD.dart';
import 'package:buy_it/screens/admin/adminHome.dart';
import 'package:buy_it/screens/signup_screen.dart';
import 'package:buy_it/screens/user/homepage.dart';
import 'package:buy_it/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Screen extends StatefulWidget {
  static String screenID = 'LoginScreen';

  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final form_key = GlobalKey<FormState>();

  var email = '';

  var password = '';

  bool keep_me_loggedin = false;

  final admin_pass = 'admin1234';

  final admin_UID = "1PYCVYNA0vc9AW63WPKCfL2ZXr33";

  submit(BuildContext ctx) async {
    var hud = Provider.of<ProgressHUDprovider>(ctx, listen: false);
    final progress = ProgressHUD.of(ctx);

    try {
      late UserCredential current_user;
      final isValid = form_key.currentState!.validate();
      FocusScope.of(ctx).unfocus();
      if (isValid) {
        hud.isLoading = true;
        form_key.currentState!.save();
        progress?.showWithText('Loading...');
        UserCredential user =
            await Auth().sign_IN(email.trim(), password.trim());
        user.user!.uid;
        print(user.toString());
        progress?.dismiss();
        hud.isLoading = false;
        current_user = user;
      }
      if (password == admin_pass && current_user.user!.uid == admin_UID) {
        Navigator.of(ctx).pushReplacementNamed(Admin_Home.screenID);
      } else {
        Navigator.of(ctx).pushReplacementNamed(HomePage.screenID);
      }
    } on FirebaseAuthException catch (e) {
      progress?.dismiss();
      hud.isLoading = false;
      String error_msg = "";

      if (e.code == 'user-not-found') {
        error_msg = 'No user found try sign up';
      } else if (e.code == 'wrong-password') {
        error_msg = 'Wrong password';
      } else {
        error_msg = e.code;
      }
      print(error_msg);

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(error_msg),
        backgroundColor: Colors.pink,
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
                  padding: const EdgeInsets.only(top: 50),
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
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !value.contains("@") ||
                          !value.contains(".")) {
                        return 'Please enter a valid email';
                      }
                    },
                    onSaved: (val) {
                      email = val!;
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
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be 6 characters or more';
                      }
                    },
                    onSaved: (val) {
                      password = val!;
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: mainColor,
                          value: keep_me_loggedin,
                          onChanged: (val) {
                            setState(() {
                              keep_me_loggedin = val!;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Remember me',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: Builder(
                    builder: (ctx) => FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.black,
                      onPressed: () {
                        if (keep_me_loggedin) {
                          keepUser_loggedin();
                        }
                        submit(ctx);
                      },
                      child: Text(
                        "Log in",
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
                      'Don\'t have an account ? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Signup_Screen.screenID);
                      },
                      child: Text(
                        "Sign up ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screen_hieght * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  keepUser_loggedin() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setBool(remember_User, keep_me_loggedin);
  }
}
