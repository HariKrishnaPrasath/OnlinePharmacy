import 'package:e_pharm_ui/providers/item.dart';
import 'package:e_pharm_ui/widgets/list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Items.dart';
import '../pages/Screens/product_details.dart';

class listView extends StatefulWidget {
  @override
  State<listView> createState() => _listViewState();
}

class _listViewState extends State<listView> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Item>(context);
    final products = productData.item;
    return Expanded(
      child: products.length != 0
          ? ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, i) {
                return ChangeNotifierProvider.value(
                  value: products[i],
                  child: listCard(
                      // desc: products[i].desc,
                      // id: products[i].id,
                      // price: products[i].price,
                      // title: products[i].title,
                      // imgUrl: products[i].imgUrl,
                      ),
                );
              },
            )
          : Center(
              child: Text(
                "No Match!",
                style: TextStyle(color: Colors.grey, fontSize: 22),
              ),
            ),
    );
  }
}
