import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/screens/admin/editProduct.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Manage_Products extends StatefulWidget {
  static String screenID = 'ManageProducts';

  // admin1@mail.com
  //admin1234

  @override
  _Manage_ProductsState createState() => _Manage_ProductsState();
}

class _Manage_ProductsState extends State<Manage_Products> {
  final store = Store();

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    return Scaffold(
      backgroundColor: mainColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: store.loadProduct(),
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            products.clear();
            if (snapshot.data == null) {
              return Center(child: Text('loading'));
            }
            snapshot.data!.docs.forEach((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              products.add(Product(
                  data[nameDOC],
                  data[priceDOC],
                  data[descriptionDOC],
                  data[categoryDOC],
                  data[imgPathDOC],
                  document.id,
                  0));
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
                itemCount: products.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Builder(
                      builder: (BuildContext popup_ctx) => GestureDetector(
                        onTapUp: (details) {
                          var dx = details.globalPosition.dx;
                          var dy = details.globalPosition.dy;
                          var dx1 = MediaQuery.of(ctx).size.width - dx;
                          var dy1 = MediaQuery.of(ctx).size.height - dy;
                          showMenu(
                            context: ctx,
                            position: RelativeRect.fromLTRB(dx, dy, dx1, dy1),
                            items: [
                              PopupMenuItem(
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(popup_ctx).pop();
                                    Navigator.of(context).pushNamed(
                                        Edit_Product.screenID,
                                        arguments: products[index]);
                                  },
                                  child: Text('Edit product'),
                                ),
                              ),
                              PopupMenuItem(
                                child: FlatButton(
                                  onPressed: () {
                                    store.deleteProduct(
                                        products[index].product_ID);
                                    show_toast('product deleted successfully');
                                    Navigator.of(popup_ctx).pop();
                                  },
                                  child: Text('Delete product'),
                                ),
                              ),
                            ],
                          );
                        },
                        child: Stack(children: [
                          Positioned.fill(
                            child: Image.asset(
                              products[index].PimgPath,
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
                                      products[index].Pname,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(products[index].Pprice),
                                    Text(products[index].Pcategory),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
