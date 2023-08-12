import 'package:e_pharm_ui/pages/Screens/main_page.dart';
import 'package:e_pharm_ui/pages/nav_pages/my_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../providers/cart.dart';
import '../../providers/item.dart';
import '../../providers/order.dart';

class PlacingOrder extends StatefulWidget {
  static const routeName = '/place-order';

  @override
  State<PlacingOrder> createState() => _PlacingOrderState();
}

class _PlacingOrderState extends State<PlacingOrder> {
  File? _image;

  final imagePicker = ImagePicker();

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(context);
    final presc = Provider.of<Item>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Placing Order'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
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
                    "Rs.${cartItems.totalAmt}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            cartItems.req == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Prescription Not needed"),
                      TextButton(
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).addOrder(
                            cartItems.items.values.toList(),
                            cartItems.totalAmt,
                            "",
                          );
                          cartItems.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Order Now',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: _image == null
                              ? Text('No image selected')
                              : Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                      ElevatedButton(
                        onPressed: getImage,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        child: Text('Pick'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_image != null) {
                            Provider.of<Orders>(context, listen: false)
                                .addOrder(
                              cartItems.items.values.toList(),
                              cartItems.totalAmt,
                              "",
                            );
                            cartItems.clear();
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Image Not Picked!")));
                          }
                        },
                        child: Text(
                          'Order Now',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: cartItems.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: Image.network(
                      presc.getUrl(cartItems.items.values.toList()[i].title)),
                  title: Text(cartItems.items.values.toList()[i].title),
                  subtitle: Text(
                      'Total: Rs${(cartItems.items.values.toList()[i].price * cartItems.items.values.toList()[i].quantity)}'),
                  trailing:
                      Text('${cartItems.items.values.toList()[i].quantity} x'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
