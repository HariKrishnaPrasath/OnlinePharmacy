import 'dart:ffi';

import 'package:e_pharm_ui/providers/Items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/carsoul_widget.dart';
import '../../widgets/list_view.dart';
import '../Screens/product_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const SliverToBoxAdapter(
          child: Column(
            children: [
              carsoul_widget(),
            ],
          ),
        )
      ],
      body: listView(),
      // Column(
      //   children: [
      //     carsoul_widget(),
      //     listView(),
      //   ],
      // ),
    );
  }
}
