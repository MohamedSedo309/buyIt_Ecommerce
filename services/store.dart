import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final firestore = FirebaseFirestore.instance;

  addProduct(Product product) async {
    try {
      await firestore.collection(productsCollection).add({
        nameDOC: product.Pname,
        priceDOC: product.Pprice,
        descriptionDOC: product.Pdiscription,
        categoryDOC: product.Pcategory,
        imgPathDOC: product.PimgPath,
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot>? loadProduct() {
    try {
      return firestore.collection(productsCollection).snapshots();
    } catch (e) {
      print('$e');
    }
  }

  deleteProduct(product_id) async {
    try {
      firestore.collection(productsCollection).doc(product_id).delete();
    } catch (e) {
      show_toast('An error occurred');
      print(e);
    }
  }

  editProduct(product_id, data) async {
    try {
      firestore.collection(productsCollection).doc(product_id).update(data);
    } catch (e) {
      show_toast('An error occurred');
    }
  }

  placeOrders(data, List<Product> products) async {
    var ref = firestore.collection(orders).doc();
    ref.set(data);
    for (var prod in products) {
      await ref.collection(ordersDetails).doc().set(
        {
          nameDOC: prod.Pname,
          priceDOC: prod.Pprice,
          product_quantity: prod.Pquantity,
          categoryDOC: prod.Pcategory,
        },
      );
    }
  }

  Stream<QuerySnapshot>? viewOrders() {
    return firestore.collection(orders).snapshots();
  }

  Stream<QuerySnapshot>? viewOrderDetails(String dodId) {
    return firestore
        .collection(orders)
        .doc(dodId)
        .collection(ordersDetails)
        .snapshots();
  }
}
