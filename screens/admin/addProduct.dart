import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/store.dart';

class Add_Product extends StatefulWidget {
  static String screenID = 'AddProduct';

  @override
  _Add_ProductState createState() => _Add_ProductState();
}

class _Add_ProductState extends State<Add_Product> {
  final form_key = GlobalKey<FormState>();

  final store = Store();

  String name = '';

  String price = '';

  String description = '';

  String category = '';

  String imgPath = '';

  add() {
    final isValid = form_key.currentState!.validate();
    if (isValid) {
      form_key.currentState!.save();
      store.addProduct(
        Product(name, price, description, category, imgPath,
            store.firestore.collection(productsCollection).doc().id, 0),
      );
      show_toast('Product added successfully');
      //form_key.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: form_key,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    key: ValueKey('name'),
                    validator: (value) {
                      if (value!.isEmpty) return 'This value cannot be empty';
                    },
                    onSaved: (val) {
                      name = val!;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintText: "Product name",
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('Price'),
                    validator: (value) {
                      if (value!.isEmpty) return 'This value cannot be empty';
                    },
                    onSaved: (val) {
                      price = val!;
                    },
                    keyboardType: TextInputType.number,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintText: "Product Price",
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('description'),
                    validator: (value) {
                      if (value!.isEmpty) return 'This value cannot be empty';
                    },
                    onSaved: (val) {
                      description = val!;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintText: "Description",
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    onChanged: (value) {
                      setState(() {
                        category = value.toString();
                      });
                    },
                    value: jackets,
                    hint: Text('Category'),
                    onTap: () {},
                    key: ValueKey('category'),
                    decoration: InputDecoration(
                      hintText: "Category",
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: jackets,
                        child: Text(jackets),
                      ),
                      DropdownMenuItem(
                        value: t_shirts,
                        child: Text(t_shirts),
                      ),
                      DropdownMenuItem(
                        value: jeans,
                        child: Text(jeans),
                      ),
                      DropdownMenuItem(
                        value: shoes,
                        child: Text(shoes),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('imgPath'),
                    validator: (value) {
                      if (value!.isEmpty) return 'This value cannot be empty';
                    },
                    onSaved: (val) {
                      imgPath = val!;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintText: "Image path",
                      fillColor: secoundryColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    onPressed: () {
                      add();
                    },
                    child: Text('Add Product'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
