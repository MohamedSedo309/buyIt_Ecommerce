import 'package:buy_it/models/product.dart';
import 'package:buy_it/provider/cartItem.dart';
import 'package:buy_it/screens/user/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class Product_Info extends StatefulWidget {
  static String screenID = 'Product_info';

  @override
  _Product_InfoState createState() => _Product_InfoState();
}

class _Product_InfoState extends State<Product_Info> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 160, top: 75),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                product.PimgPath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      size: 28,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Cart_Screen.screenID);
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            bottom: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.Pname),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('price : '),
                    Text(product.Pprice),
                    Text('  \$'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(product.Pdiscription),
              ],
            ),
          ),
          Positioned(
            bottom: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(220, 50)),
                      backgroundColor: MaterialStateProperty.all(mainColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'Add to cart',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (count == 0) {
                        show_toast('you must add at least 1');
                      } else if (count > 0) {
                        product.Pquantity = count;
                        Provider.of<CartItem>(context, listen: false)
                            .addProduct(product);
                      }
                    },
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(30, 40)),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (count > 0) {
                        setState(() {
                          count -= 1;
                        });
                      }
                    },
                    child: Icon(Icons.exposure_minus_1),
                  ),
                  Text(
                    count.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(30, 40)),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        count += 1;
                      });
                    },
                    child: Icon(Icons.exposure_plus_1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
