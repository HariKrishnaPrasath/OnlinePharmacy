import 'package:e_pharm_ui/providers/Items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/Screens/product_details.dart';
import '../providers/cart.dart';
import '../providers/item.dart';

class listCard extends StatefulWidget {
  @override
  State<listCard> createState() => _listCardState();
}

class _listCardState extends State<listCard> {
  // final String title;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Items>(context);
    final cart = Provider.of<Cart>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetails.routeName,
          arguments: product.id,
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: Image.network(product.imgUrl, cacheHeight: 150),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${product.title}',
            ),
            // IconButton(
            //   onPressed: () {
            //     cart.addItem(
            //       product.id,
            //       product.price,
            //       product.title,
            //     );
            //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
            //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //       content: Text(
            //         'Added Item to cart!',
            //       ),
            //       duration: Duration(seconds: 2),
            //       action: SnackBarAction(
            //         label: "Undo",
            //         textColor: Theme.of(context).primaryColor,
            //         onPressed: () {
            //           cart.removeItem(product.id);
            //         },
            //       ),
            //     ));
            //   },
            //   icon: Icon(
            //     Icons.shopping_cart,
            //     color: Colors.green,
            //   ),
            // ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${product.desc}'),
            Text('Rs${product.price}'),
          ],
        ),
        trailing: IconButton(
          icon:
              Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
          onPressed: () {
            product.toggleFavoriteStatus();
          },
          color: Colors.red,
        ),
      ),
    );
  }
}
