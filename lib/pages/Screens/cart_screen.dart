import 'package:e_pharm_ui/pages/Screens/main_page.dart';
import 'package:e_pharm_ui/pages/Screens/placing_order.dart';
import 'package:e_pharm_ui/pages/nav_pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../providers/cart.dart';
import '../../providers/order.dart';
import '../../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(children: [
        Card(
          // margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  backgroundColor: Colors.green,
                  label: Text(
                    "Rs.${cart.totalAmt}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Provider.of<Orders>(context, listen: false).addOrder(
                    //   cart.items.values.toList(),
                    //   cart.totalAmt,
                    //   "",
                    // );
                    // cart.clear();
                    cart.items.length != 0
                        ? Navigator.of(context)
                            .pushNamed(PlacingOrder.routeName)
                        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'No items in cart!',
                            ),
                            duration: Duration(seconds: 2),
                            action: SnackBarAction(
                              label: "Order Now",
                              textColor: Theme.of(context).primaryColor,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ));
                  },
                  child: Text(
                    'Place Order',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => ci.CartItem(
                prodId: cart.items.keys.toList()[i],
                id: cart.items.values.toList()[i].id,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                title: cart.items.values.toList()[i].title),
          ),
        ),
      ]),
    );
  }
}
