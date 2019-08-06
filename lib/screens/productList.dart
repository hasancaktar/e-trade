import 'package:e_ticaret/db/dbHelper.dart';
import 'package:e_ticaret/models/product.dart';
import 'package:flutter/material.dart';

class PorductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductListState();
}

class ProductListState extends State {
  DbHelper dbHelper = DbHelper();
  List<Product> products;
  int count=0;
  @override
  Widget build(BuildContext context) {
    if (products == null) {
      products = new List<Product>();
      getData();
    }
    return Scaffold(body: PorductListItems());
  }

  ListView PorductListItems() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        Card(
          color: Colors.amberAccent,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text("A"),
            ),
            title: Text(this.products[position].name),
            subtitle: Text(this.products[position].discription),
            onTap: (){},

          ),
        );
      }
    );
  }

  void getData() {
    var db = dbHelper.initializeDb();
    db.then((result) {
      var productsFuture = dbHelper.getProduct();
      productsFuture.then((data) {
        List<Product> productsData = new List<Product>();

        count = data.length;

        for (int i = 0; i < count; i++) {
          productsData.add(Product.fromObject(data[i]));
        }
        setState(() {
          products = productsData;
          count=count;
        });
      });
    });
  }
}
