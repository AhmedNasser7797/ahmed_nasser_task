import 'dart:io';

class ProductModel {
  int id;
  String name;
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
    this.isFavorite = false,
    this.price,
    this.name,
    this.numberInStock,
    this.priceForSale,
    this.imageFile,
  });
}
