import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Items with ChangeNotifier {
  final String id;
  final String title;
  final String desc;
  final double price;
  final String imgUrl;
  final bool presNeeded;
  bool isFavorite;

  Items({
    required this.id,
    required this.title,
    required this.desc,
    required this.imgUrl,
    required this.price,
    required this.presNeeded,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final val = isFavorite;
    final url = Uri.parse(
        "https://e-pharmacy-42b9a-default-rtdb.asia-southeast1.firebasedatabase.app/items/$id.json");
    http.patch(url, body: json.encode({
      
    }));
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
