import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/services/store.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetails extends StatelessWidget {
  static String screenID = 'OrderDetailsScreen';
  var store = Store();
  List<Product> products_OrderDetails = [];

  @override
  Widget build(BuildContext context) {
    String docID = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: store.viewOrderDetails(docID),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: Text('Loading...'),
              );
            else {
              snapshot.data!.docs.forEach((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                products_OrderDetails.add(
                  Product(
                    data[nameDOC],
                    data[priceDOC],
                    '',
                    data[categoryDOC],
                    '',
                    '',
                    data[product_quantity],
                  ),
                );
              });
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            color: secoundryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Product name : ' +
                                        products_OrderDetails[index].Pname,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Category : ' +
                                        products_OrderDetails[index]
                                            .Pcategory
                                            .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Quantity : ' +
                                        products_OrderDetails[index]
                                            .Pquantity
                                            .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: products_OrderDetails.length,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueGrey),
                        ),
                        child: Text(
                          'Confirm Order',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueGrey),
                        ),
                        child: Text(
                          'Delete Order',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
          }),
    );
  }
}
