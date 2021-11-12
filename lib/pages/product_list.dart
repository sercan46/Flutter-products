import 'package:flutter/material.dart';
import 'package:sqflite_workspace/data/db_helper.dart';
import 'package:sqflite_workspace/models/product.dart';
import 'package:sqflite_workspace/pages/product_add.dart';
import 'package:sqflite_workspace/pages/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var dbHelper = DbHelper();
  List<Product> products = [];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Ekle'),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          goToProductAddPage();
        },
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, index) {
          return Card(
            elevation: 2,
            color: Colors.cyan,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text('P'),
              ),
              title: Text(products[index].name.toString()),
              subtitle: Text(products[index].description.toString()),
              onTap: () {
                goToProductDetail(products[index]);
              },
            ),
          );
        });
  }

  void goToProductAddPage() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {
        print('if çca');
        getProducts();
      }
    }
  }

  getProducts() {
    var productsFuture = dbHelper.getProducts();
    productsFuture?.then((value) {
      setState(() {
        products = value;
      });
    });
  }

  void goToProductDetail(Product product) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetail(product: product)));
    if (result != null) {
      if (result) {
        print('if çca');
        getProducts();
      }
    }
  }
}
