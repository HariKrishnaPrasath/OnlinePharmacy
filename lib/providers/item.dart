import 'package:e_pharm_ui/providers/Items.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Item with ChangeNotifier {
  List<Items> _items = [
    Items(
      id: 'm1',
      title: 'Paracetamol',
      desc: "Fever medicine",
      imgUrl:
          'https://www.practostatic.com/practopedia-images/v3/res-750/dolo-650mg-tablet-cold-cough-covid-essentials-15-s_6fbd3435-bffd-428d-9288-ec74ad6a94ef.JPG',
      price: 18.0,
      presNeeded: true,
    ),
    Items(
      id: 'm2',
      title: 'Vicks',
      desc: "Fever medicine",
      imgUrl: 'https://m.media-amazon.com/images/I/818Q7bRbUkL._SY450_.jpg',
      price: 14.0,
      presNeeded: false,
    ),
    Items(
      id: 'm3',
      title: 'Action 500',
      desc: "Fever medicine",
      imgUrl:
          'https://images.ctfassets.net/umpxkz97ty8t/aIwP4Ll5m4jYR3qAlaqGB/c2083e141d19f244064aca13f2d7e747/vicks-india-veer.jpg',
      price: 12.0,
      presNeeded: true,
    ),
    Items(
      id: 'm4',
      title: 'Vaporub',
      desc: "Fever medicine",
      imgUrl:
          'https://newassets.apollo247.com/pub/media/catalog/product/4/9/4987176014955_1_.jpg',
      price: 11.0,
      presNeeded: true,
    ),
    Items(
      id: 'm5',
      title: 'Inhaler',
      desc: "Fever medicine",
      imgUrl:
          'https://images.jdmagicbox.com/quickquotes/images_main/vicks-ayurveda-products-12-12-2020-002-219916683-txl8l.jpg',
      price: 13.0,
      presNeeded: false,
    ),
    Items(
      id: 'm6',
      title: 'Erythromycin',
      desc: "Fever medicine",
      imgUrl:
          'https://wellonapharma.com/admincms/product_img/product_resize_img/erythromycin-stearate-tablets_1645450996.jpg',
      price: 5.0,
      presNeeded: true,
    ),
    Items(
      id: 'm7',
      title: 'saridon',
      desc: "Fever medicine",
      imgUrl:
          'https://www.practostatic.com/practopedia-images/v3/res-750/saridon-tablet-10-s_2c63761b-47b5-4f1c-82af-26af7132a99b.JPG',
      price: 2.0,
      presNeeded: false,
    ),
    Items(
      id: 'm8',
      title: 'Cofil syrup',
      desc: "Fever medicine",
      imgUrl:
          'https://www.netmeds.com/images/product-v1/600x600/976632/bahola_cofil_syrup_450_ml_0_0.jpg',
      price: 20.0,
      presNeeded: false,
    ),
  ];

  var _showFavoritesOnly = false;

  late List<Items> _itm = List.from(_items);

  void updateList(String val) {
    _itm = _items
        .where((element) =>
            element.title.toLowerCase().contains(val.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Items findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Items> get item {
    return [..._itm];
  }

  List<Items> get req {
    return _items.where((prodItem) => prodItem.presNeeded == true).toList();
  }

  List<Items> get items {
    if (_showFavoritesOnly) {
      return _itm.where((prodItem) => prodItem.isFavorite).toList();
    }
    return [..._itm];
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  String getUrl(String id) {
    List<Items> item = _items.where((element) => element.title == id).toList();
    return item[0].imgUrl;
  }

  void showAll() {
    fetchAndSetProducts();
    _showFavoritesOnly = false;
    notifyListeners();
  }

  Future<void> fetchAndSetProducts() async {
    // final url = Uri.parse(
    //     "https://e-pharmacy-42b9a-default-rtdb.asia-southeast1.firebasedatabase.app/items.json");
    // try {
    //   final response = await http.post(
    //     url,
    //     body: json.encode({
    //       'title': _items[7].title,
    //       'description': _items[7].desc,
    //       'imageUrl': _items[7].imgUrl,
    //       'price': _items[7].price,
    //       'preNeeded': _items[7].presNeeded,
    //     }),
    //   );
    //   print(json.decode(response.body));
    // } catch (err) {
    //   print(err);
    // }
    final url = Uri.parse(
        "https://e-pharmacy-42b9a-default-rtdb.asia-southeast1.firebasedatabase.app/items.json");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Items> loadedProd = [];
      extractedData.forEach((key, value) {
        loadedProd.add(Items(
          id: key,
          title: value['title'],
          desc: value['description'],
          imgUrl: value['imageUrl'],
          price: value['price'],
          presNeeded: value['preNeeded'],
        ));
      });
      _items = List.from(loadedProd);
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }
}
