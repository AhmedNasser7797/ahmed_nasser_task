import 'dart:io';

class ProductModel {
  String id;
  String title;
  String description;
  double price;
  double priceForSale;
  String imageUrl;
  File imageFile;
  bool isFavorite;
  int numberInStock;

  ProductModel({
    this.description,
    this.id,
    this.imageUrl,
    this.isFavorite,
    this.price,
    this.title,
    this.numberInStock,
    this.priceForSale,
    this.imageFile,
  });
}
