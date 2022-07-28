import 'package:buy_it/models/product.dart';
import 'package:buy_it/services/store.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/constants.dart';

class Edit_Product extends StatefulWidget {
  static String screenID = 'Edit_Product';

  @override
  _Edit_ProductState createState() => _Edit_ProductState();
}

class _Edit_ProductState extends State<Edit_Product> {
  final form_key = GlobalKey<FormState>();

  final store = Store();

  String name = '';

  String price = '';

  String description = '';

  String category = '';

  String imgPath = '';

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: form_key,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      hintText: product.Pname,
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
                      hintText: product.Pprice,
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
                      hintText: product.Pdiscription,
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
                      hintText: product.PimgPath,
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
                      final isValid = form_key.currentState!.validate();
                      if (isValid) {
                        form_key.currentState!.save();
                        store.editProduct(product.product_ID, {
                          nameDOC: name,
                          priceDOC: price,
                          descriptionDOC: description,
                          categoryDOC: category,
                          imgPathDOC: imgPath,
                        });
                        show_toast('Product Edited successfully');
                        form_key.currentState!.reset();
                      }
                    },
                    child: Text('Edit Product'),
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
