import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/provider/cartItem.dart';
import 'package:buy_it/screens/user/productInfo.dart';
import 'package:buy_it/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart_Screen extends StatelessWidget {
  static String screenID = 'Cart';

  @override
  Widget build(BuildContext context) {
    var cartItem = Provider.of<CartItem>(context);
    List<Product> productsCart =
        Provider.of<CartItem>(context, listen: true).productsCartItem;
    double hieght = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: productsCart.isEmpty
          ? Container(
              alignment: Alignment.center,
              color: Colors.amber,
              child: Text(
                'Your cart is empty \n add some products to make a deal .',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: productsCart.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Builder(builder: (ctx) {
                          return GestureDetector(
                            onTapUp: (details) {
                              var dx = details.globalPosition.dx;
                              var dy = details.globalPosition.dy;
                              var dx1 = MediaQuery.of(ctx).size.width - dx;
                              var dy1 = MediaQuery.of(ctx).size.height - dy;
                              showMenu(
                                context: ctx,
                                position:
                                    RelativeRect.fromLTRB(dx, dy, dx1, dy1),
                                items: [
                                  PopupMenuItem(
                                    child: TextButton(
                                      onPressed: () {
                                        print("object");
                                        Navigator.popAndPushNamed(
                                            context, Product_Info.screenID,
                                            arguments: productsCart[index]);
                                        Provider.of<CartItem>(context,
                                                listen: false)
                                            .deleteFromCart(
                                                productsCart[index]);
                                      },
                                      child: Text(
                                        'Change Quantity',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);

                                        Provider.of<CartItem>(context,
                                                listen: false)
                                            .deleteFromCart(
                                                productsCart[index]);
                                      },
                                      child: Text(
                                        'Remove from cart',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            child: Container(
                              color: Color(0xFFFFE3A6),
                              height: hieght * 0.15,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: hieght * 0.15 / 2,
                                    backgroundImage: AssetImage(
                                        productsCart[index].PimgPath),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                productsCart[index].Pname,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '\$' +
                                                    productsCart[index].Pprice,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            productsCart[index]
                                                .Pquantity
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Builder(builder: (context) {
                    return ElevatedButton(
                      child: Text('place order'),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all(
                            Size(width - 75, hieght * 0.08)),
                        backgroundColor: MaterialStateProperty.all(mainColor),
                      ),
                      onPressed: () {
                        showCustomDialog(productsCart, context);
                      },
                    );
                  }),
                ),
              ],
            ),
    );
  }

  void showCustomDialog(List<Product> products, BuildContext context) async {
    var total_price = gettotalprice(products);
    var address = '';
    AlertDialog alertDialog = AlertDialog(
      title: Text('Total price = $total_price'),
      content: TextField(
        onChanged: (val) {
          address = val;
        },
        decoration: InputDecoration(hintText: 'Enter your address'),
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            var store = Store();
            if (address == '') {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Address Cannot be empty')));
              Navigator.pop(context);
            } else {
              try {
                store.placeOrders({
                  totalprice: total_price,
                  user_address: address,
                }, products);
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('ordered successfully')));
                Navigator.pop(context);
              } catch (e) {
                print(e);
              }
            }
          },
          child: Text('Confirm Order'),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  gettotalprice(List<Product> products) {
    var price = 0;
    for (var prod in products) {
      price += prod.Pquantity * int.parse(prod.Pprice);
    }
    return price;
  }
}
