import 'package:buy_it/constants.dart';
import 'package:buy_it/screens/admin/addProduct.dart';
import 'package:buy_it/screens/admin/manageProducts.dart';
import 'package:buy_it/screens/user/homepage.dart';
import 'package:flutter/material.dart';

import 'ordersScreen.dart';

class Admin_Home extends StatelessWidget {
  static String screenID = 'AdminHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Add_Product.screenID);
            },
            child: Text('Add product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Manage_Products.screenID);
            },
            child: Text('Edit product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(OrdersScreen.screenID);
            },
            child: Text('View orders'),
          ),
          SizedBox(
            height: 25,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(HomePage.screenID);
            },
            child: Text('Log in as user'),
          ),
        ],
      ),
    );
  }
}
