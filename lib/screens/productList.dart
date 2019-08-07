import 'package:e_ticaret/db/dbHelper.dart';
import 'package:e_ticaret/models/product.dart';
import 'package:flutter/material.dart';

class PorductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductListState();
}



class ProductListState extends State {

  @override
  void initState() {    // runned when the screen is first created
    super.initState();

    if (products == null) {
      products = new List<Product>();
      getData();
    }
  }
  DbHelper dbHelper = DbHelper();
  List<Product> products;
  int count=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(body: count != 0 ? PorductListItems() : Center(child: Text('products empty'),));    // if products not empty show products or display products empty
  }

  ListView PorductListItems() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        return Card(
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

        if(count != 0){
        for (int i = 0; i < count; i++) {
          productsData.add(Product.fromObject(data[i]));
        }
        setState(() {
          products = productsData;
          count=count;
        });
        }


      });
    });
  }
}
