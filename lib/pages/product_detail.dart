import 'package:flutter/material.dart';
import 'package:sqflite_workspace/data/db_helper.dart';
import 'package:sqflite_workspace/models/product.dart';

enum Options { delete, update }

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    txtName.text = widget.product.name!;
    txtDescription.text = widget.product.description!;
    txtUnitPrice.text = widget.product.unitPrice!.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Adı ${widget.product.name}'),
        actions: [
          PopupMenuButton<Options>(
              onSelected: selectedProcess,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
                    PopupMenuItem(value: Options.delete, child: Text('Sil')),
                    PopupMenuItem(
                        value: Options.update, child: Text('Güncelle')),
                  ]),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            buildProductName(),
            buildProductDescription(),
            buildProductPrice(),
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

  void selectedProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(widget.product);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product(
            id: widget.product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: int.parse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
