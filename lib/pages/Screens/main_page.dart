import 'dart:ffi';
import 'package:provider/provider.dart';
import '../../providers/item.dart';
import 'package:e_pharm_ui/pages/nav_pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:e_pharm_ui/widgets/badge.dart';
import '../../widgets/custom_appbar.dart';
import '../nav_pages/home_page.dart';
import '../nav_pages/my_cart.dart';
import '../nav_pages/user_product.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/main-page';
  const MyHomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageNewState createState() => _MyHomePageNewState();
}

class _MyHomePageNewState extends State<MyHomePage> {
  int selectedIndex = 0;
  var _isloading = false;
  @override
  void initState() {
    setState(() {
      _isloading = true;
    });
    Provider.of<Item>(context, listen: false).fetchAndSetProducts().then((_) {
      setState(() {
        _isloading = false;
      });
    });
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Item>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List pages = [
    HomePage(),
    MyCart(),
    ProfilePage(),
    // UserProductScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    // final index = ModalRoute.of(context)?.settings.arguments ?? '0' as String;
    return Scaffold(
      appBar: CustomAppbar(
        selectedIndex: selectedIndex,
      ),
      // ignore: unrelated_type_equality_checks
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : pages[selectedIndex],
      // index == '0' && index == '1'
      //     ? pages[int.parse(index!)]
      // SingleChildScrollView(
      //   child: pages[selectedIndex],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: "My cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Account",
          ),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.add_circle), label: 'Add Products'),
        ],
        currentIndex: selectedIndex,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedIconTheme: IconThemeData(color: Colors.black),
        selectedIconTheme: IconThemeData(color: Colors.green),
        type: BottomNavigationBarType.shifting,
        onTap: onTap,
      ),
    );
  }
}
