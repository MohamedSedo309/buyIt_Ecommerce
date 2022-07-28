import 'dart:ui';

import 'package:buy_it/constants.dart';
import 'package:buy_it/models/Order.dart';
import 'package:buy_it/screens/admin/orderDetailsScreen.dart';
import 'package:buy_it/services/store.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersScreen extends StatelessWidget {
  static String screenID = 'OrdersScreen';
  var store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.viewOrders(),
        builder: (context, snapshot) {
          List<Order> orders = [];
          if (!snapshot.hasData || snapshot.data == null || orders == []) {
            print(snapshot.data);
            return Center(
              child: Text('No Orders'),
            );
          } else {
            snapshot.data!.docs.forEach((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              orders.add(
                Order(
                  totalPrice: data[totalprice],
                  addreSS: data[user_address],
                  orderID: document.id,
                ),
              );
            });
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetails.screenID,
                          arguments: orders[index].orderID);
                    },
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
                              'Order price : ' +
                                  orders[index].totalPrice.toString() +
                                  '\$',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Clint Address : ' +
                                  orders[index].addreSS.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
