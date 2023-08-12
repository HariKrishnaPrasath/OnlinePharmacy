import 'package:e_pharm_ui/pages/Screens/cart_screen.dart';
import 'package:e_pharm_ui/pages/Screens/placing_order.dart';
import 'package:e_pharm_ui/pages/Screens/product_details.dart';
import 'package:e_pharm_ui/pages/nav_pages/home_page.dart';
import 'package:e_pharm_ui/pages/nav_pages/my_cart.dart';
import 'package:e_pharm_ui/pages/nav_pages/profile.dart';
import 'package:e_pharm_ui/providers/cart.dart';
import 'package:e_pharm_ui/providers/item.dart';
import 'package:e_pharm_ui/providers/order.dart';
import 'package:e_pharm_ui/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "dart:ffi";
import 'pages/Screens/main_page.dart';
import 'widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Item(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductDetails.routeName: (ctx) => ProductDetails(),
          MyHomePage.routeName: (ctx) => const MyHomePage(),
          PlacingOrder.routeName: (ctx) => PlacingOrder(),
        },
        theme: ThemeData(
          primaryColor: Colors.green,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green,
          ),
        ),
        home: WidgetTree(),
        // theme: ThemeData(
        //     fontFamily: 'Roboto',
        //     primaryColor: Colors.white,
        //     primaryColorDark: Colors.white,
        //     backgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}



//https://api.evaly.com.bd/core/public/products/?page=1&limit=12&category=facial-cleansing-brushes-84365a5ee

//https://api.evaly.com.bd/core/public/products/?page=1&limit=12&category=bags-luggage-966bc8aac
