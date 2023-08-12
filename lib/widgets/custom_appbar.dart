import 'package:e_pharm_ui/pages/Screens/cart_screen.dart';
import 'package:e_pharm_ui/pages/nav_pages/my_cart.dart';
import 'package:e_pharm_ui/providers/cart.dart';
import 'package:e_pharm_ui/widgets/badge.dart' as bd;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth.dart';
import '../providers/item.dart';

enum FilterOptions {
  Favorites,
  All,
  noting,
}

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  CustomAppbar({required this.selectedIndex});

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Item>(context);
    return AppBar(
      bottomOpacity: 0,
      backgroundColor: Colors.green,
      elevation: 1,
      actions: [
        selectedIndex != 3
            ? Consumer<Cart>(
                builder: (_, cartData, ch) => bd.Badge(
                  value: cartData.itemCount.toString(),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        CartScreen.routeName,
                      );
                    },
                  ),
                ),
              )
            : IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                )),
        selectedIndex == 0
            ? PopupMenuButton(
                onSelected: (FilterOptions selectedVal) {
                  if (selectedVal == FilterOptions.Favorites) {
                    productsData.showFavoritesOnly();
                  } else if (selectedVal == FilterOptions.All) {
                    productsData.showAll();
                  } else if (selectedVal == FilterOptions.noting) {
                    signOut();
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Favorites'),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      value: FilterOptions.Favorites),
                  PopupMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Show all'),
                          Icon(
                            Icons.all_inbox,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      value: FilterOptions.All),
                  PopupMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Log out'),
                          Icon(
                            Icons.logout_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      value: FilterOptions.noting)
                ],
                icon: Icon(
                  Icons.menu,
                ),
              )
            : IconButton(
                onPressed: signOut,
                icon: Icon(
                  Icons.logout_rounded,
                ),
              ),
      ],
      title: Container(
        child: Text(
          "E Pharm",
          style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(100, 50);
}
