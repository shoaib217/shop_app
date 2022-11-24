import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

Future<void> toggleFavoriteStatus(String? token) async{
  final oldStatus = isFavorite;
  isFavorite = !isFavorite;
  notifyListeners();
   final url = Uri.parse(
        'https://shopapp-982d0-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
try{
  await http.patch(url,body: json.encode({
    'isFavorite': isFavorite.toString()
  }));

}catch(error){
  isFavorite = oldStatus;
}
}

}

