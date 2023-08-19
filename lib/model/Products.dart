import 'package:flutter/material.dart';

class Products {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = double.parse(json['rating'].toString());
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }
}

class TextAndIcon extends StatelessWidget {
  final Products products;

  const TextAndIcon({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 4,
        child: Container(

          decoration: BoxDecoration(
            color: Colors.yellow,
            image: DecorationImage(
              image: NetworkImage(
                products.thumbnail!,
              ),
              fit: BoxFit.cover,
            ),
          ),
          margin: const EdgeInsets.all(10),
        ),
      ),
      Expanded(
        flex: 1,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            products.description as String,
            style: const TextStyle(color: Colors.white),
            textScaleFactor: 1.2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Text(
          '\$${products.price.toString()}',
          textScaleFactor: 1.5,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ]);
  }
}
