class Product {
  int? id;
  String? name;
  String? description;
  int? unitPrice;

  Product({this.id, this.name, this.description, this.unitPrice});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    unitPrice = json['unitPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['unitPrice'] = this.unitPrice;
    return data;
  }
}
