import 'package:e_pharm_ui/widgets/user_product_item.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/item.dart';

class UserProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prodsData = Provider.of<Item>(context);
    return Container(
      child: ListView.builder(
        itemBuilder: (_, i) => UserProductItem(
          imgUrl: prodsData.items[i].imgUrl,
          title: prodsData.items[i].title,
        ),
        itemCount: prodsData.items.length,
      ),
    );
  }
}
