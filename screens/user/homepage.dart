import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/screens/login_screen.dart';
import 'package:buy_it/screens/user/Cart.dart';
import 'package:buy_it/screens/user/productInfo.dart';
import 'package:buy_it/services/auth.dart';
import 'package:buy_it/services/store.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  static String screenID = 'Homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = Auth();
  final store = Store();
  var loggedUser;
  int tabBarIndex = 0;
  int bottomNavIndex = 0;

  getCurrentUser() {
    loggedUser = auth.getUser();
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorColor: mainColor,
                onTap: (val) {
                  setState(() {
                    print(val);
                    tabBarIndex = val;
                    print(tabBarIndex);
                  });
                },
                tabs: [
                  Text(
                    'Jackets',
                    style: tabBarIndex == 0
                        ? TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        : TextStyle(
                            color: inActiveColor,
                            fontWeight: FontWeight.normal,
                          ),
                  ),
                  Text(
                    'T-Shirts',
                    style: tabBarIndex == 1
                        ? TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        : TextStyle(color: inActiveColor),
                  ),
                  Text(
                    'Jeans',
                    style: tabBarIndex == 2
                        ? TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        : TextStyle(color: inActiveColor),
                  ),
                  Text(
                    'Shoes',
                    style: tabBarIndex == 3
                        ? TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        : TextStyle(color: inActiveColor),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                productview(jackets),
                productview(t_shirts),
                productview(jeans),
                productview(shoes),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      auth.log_out();
                      Navigator.pushReplacementNamed(
                          context, Login_Screen.screenID);
                    },
                    child: Icon(
                      Icons.logout,
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
        ),
      ],
    );
  }

  Widget productview(String category) {
    List<Product> productsHomepage = [];
    return StreamBuilder<QuerySnapshot>(
        stream: store.loadProduct(),
        builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          productsHomepage.clear();
          if (snapshot.data == null) {
            return Center(child: Text('loading...'));
          }
          snapshot.data!.docs.forEach((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            if (data[categoryDOC] == category) {
              productsHomepage.add(Product(
                  data[nameDOC],
                  data[priceDOC],
                  data[descriptionDOC],
                  data[categoryDOC],
                  data[imgPathDOC],
                  document.id,
                  0));
            }
          });
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }

          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: productsHomepage.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Product_Info.screenID,
                          arguments: productsHomepage[index]);
                    },
                    child: Stack(children: [
                      Positioned.fill(
                        child: Image.asset(
                          productsHomepage[index].PimgPath,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: 0.5,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productsHomepage[index].Pname,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(productsHomepage[index].Pprice),
                                Text(productsHomepage[index].Pcategory),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              });
        });
  }

  List<Product> getProductCategory(String category) {
    List<Product> products = [];
    for (var product in products) {
      if (product.Pcategory == category) {
        products.add(product);
      }
    }
    return products;
  }
}
