import 'package:e_pharm_ui/pages/Screens/main_page.dart';
import 'package:e_pharm_ui/providers/Items.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../../providers/order.dart';
import 'package:provider/provider.dart';
import '../../widgets/order_item.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return orderData.orders.length == 0
        ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Image.asset('assets/Images/waiting.png'),
                  height: 400,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "No Orders Yet!!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      MyHomePage.routeName,
                      arguments: 1,
                    );
                  },
                  child: Text(
                    'Order Now',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor)),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          MyHomePage.routeName,
                          arguments: 0,
                        );
                      },
                      // style: ButtonStyle(backgroundColor: MaterialStateColor.Colors.),
                      child: Text('Order Now')),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderedItem(
                    orderData.orders[i],
                  ),
                ),
              ),
            ],
          );
  }
}
