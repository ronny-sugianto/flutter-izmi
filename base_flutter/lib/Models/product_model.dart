class Product {
  int id;
  String name;
  int price;
  int qty;

  Product({this.id, this.name, this.price, this.qty});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        price = json['price'] ?? 0,
        qty = json['qty'] ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'qty': qty,
    };
  }
}
