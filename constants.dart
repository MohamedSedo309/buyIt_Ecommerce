import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const mainColor = Color(0xFFFFBD28);
const secoundryColor = Color(0xFFFFE6AC);
const inActiveColor = Color(0xFFC1BDB8);

const String nameDOC = 'product_name';
const String priceDOC = 'product_price';
const String descriptionDOC = 'product_Description';
const String categoryDOC = 'product_Category';
const String imgPathDOC = 'product_imgPath';
const String orders = 'Orders';
const String ordersDetails = 'OrdersDetails';
const String totalprice = 'Totalprice';
const String user_address = 'Address';
const String product_quantity = 'product_quantity';

const String jackets = 'Jackets';
const String t_shirts = 'T-shirts';
const String jeans = 'Jeans';
const String shoes = 'Shoes';

const String remember_User = 'keepmeloggedin';

const productsCollection = 'products';
show_toast(String msg) {
  Fluttertoast.showToast(msg: msg);
}
