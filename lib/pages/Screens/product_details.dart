import 'package:e_pharm_ui/pages/Screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../providers/cart.dart';
import '../../providers/item.dart';

class ProductDetails extends StatefulWidget {
  // final String title;

  // ProductDetails(this.title);
  static const routeName = '/product-detail';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qua = 0;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final cart = Provider.of<Cart>(context);
    final loadedProd = Provider.of<Item>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(loadedProd.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(CartScreen.routeName);
              },
              icon: Icon(
                Icons.shopping_cart,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProd.imgUrl,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Rs. ${loadedProd.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            loadedProd.presNeeded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                      ),
                      Text(
                        "Prescription needed",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  )
                : Text(
                    "No Prescription needed",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProd.desc,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: qua < 3
                      ? () {
                          setState(() {
                            qua += 1;
                          });
                        }
                      : () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Make Limit reached!',
                            ),
                            duration: Duration(seconds: 2),
                          ));
                        },
                  child: Icon(Icons.add),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                ),
                Text(qua.toString()),
                ElevatedButton(
                  onPressed: qua > 0
                      ? () {
                          setState(() {
                            qua -= 1;
                          });
                        }
                      : null,
                  child: Icon(Icons.remove),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: qua > 0
                  ? () {
                      cart.addItem(loadedProd.id, loadedProd.price,
                          loadedProd.title, loadedProd.presNeeded, qua);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Added Item to cart!',
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: "Undo",
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            cart.removeItem(loadedProd.id);
                          },
                        ),
                      ));
                    }
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'No items selected',
                        ),
                        duration: Duration(seconds: 2),
                      ));
                    },
              child: Text('Add to Cart'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
              // icon: Icon(
              //   Icons.shopping_cart,
              //   color: Colors.green,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
