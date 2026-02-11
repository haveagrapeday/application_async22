// // To parse this JSON data, do
// //
// //     final product = productFromJson(jsonString);

// import 'dart:convert';

// Product productFromJson(String str) => Product.fromJson(json.decode(str));

// String productToJson(Product data) => json.encode(data.toJson());

class Product {
    int id;
    String title;
    String desc;
    int price;
    double star;
    String imageURL;

    Product({
        required this.id,
        required this.title,
        required this.desc,
        required this.price,
        required this.star,
        required this.imageURL,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        desc: json["description"],
        price: json["price"],
        star: json["star"]?.toDouble(),
        imageURL: json["imageUrl"],
    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "title": title,
    //     "description": desc,
    //     "price": price,
    //     "star": star,
    //     "imageUrl": imageURL,
    // };
}
