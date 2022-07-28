import 'package:buy_it/constants.dart';
import 'package:buy_it/provider/cartItem.dart';
import 'package:buy_it/provider/progressHUD.dart';
import 'package:buy_it/screens/admin/addProduct.dart';
import 'package:buy_it/screens/admin/adminHome.dart';
import 'package:buy_it/screens/admin/editProduct.dart';
import 'package:buy_it/screens/admin/manageProducts.dart';
import 'package:buy_it/screens/admin/orderDetailsScreen.dart';
import 'package:buy_it/screens/admin/ordersScreen.dart';
import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/screens/signup_screen.dart';
import 'package:buy_it/screens/user/cart.dart';
import 'package:buy_it/screens/user/homepage.dart';
import 'package:buy_it/screens/user/productInfo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Product> products = [];

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          rememberMe = false;
        else if (snapshot.data!.getBool(remember_User) == null)
          rememberMe = false;
        else
          rememberMe = snapshot.data!.getBool(remember_User)!;

        return MultiProvider(
          providers: [
            ChangeNotifierProvider<ProgressHUDprovider>(
              create: (context) => ProgressHUDprovider(),
            ),

            ChangeNotifierProvider<CartItem>(
              create: (context) => CartItem(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute:
                rememberMe ? HomePage.screenID : Login_Screen.screenID,
            routes: {
              Login_Screen.screenID: (context) => Login_Screen(),
              Signup_Screen.screenID: (context) => Signup_Screen(),
              HomePage.screenID: (context) => HomePage(),
              Admin_Home.screenID: (context) => Admin_Home(),
              Add_Product.screenID: (context) => Add_Product(),
              Manage_Products.screenID: (context) => Manage_Products(),
              Edit_Product.screenID: (context) => Edit_Product(),
              Product_Info.screenID: (context) => Product_Info(),
              Cart_Screen.screenID: (context) => Cart_Screen(),
              OrdersScreen.screenID: (context) => OrdersScreen(),
              OrderDetails.screenID: (context) => OrderDetails(),
            },
          ),
        );
      },
    );
  }
}
