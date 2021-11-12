import 'package:flutter/material.dart';
import 'package:sqflite_workspace/data/db_helper.dart';
import 'package:sqflite_workspace/models/product.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Ekle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            buildProductName(),
            buildProductDescription(),
            buildProductPrice(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  TextFormField buildProductName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Ürün Adı'),
      controller: txtName,
    );
  }

  TextFormField buildProductDescription() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Ürün Açıklaması'),
      controller: txtDescription,
    );
  }

  TextFormField buildProductPrice() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Ürün Fiyatı'),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return TextButton(
        onPressed: () {
          addProduct();
        },
        child: Text('Ekle'));
  }

  void addProduct() async {
    var result = await dbHelper.insert(Product(
        name: txtName.text.toString(),
        description: txtDescription.text.toString(),
        unitPrice: int.tryParse(txtUnitPrice.text.toString())));
    Navigator.pop(context, true);
  }
}
