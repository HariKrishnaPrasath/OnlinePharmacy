import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../providers/item.dart';

class carsoul_widget extends StatefulWidget {
  const carsoul_widget({
    Key? key,
  }) : super(key: key);

  @override
  State<carsoul_widget> createState() => _carsoul_widgetState();
}

class _carsoul_widgetState extends State<carsoul_widget> {
  @override
  Widget build(BuildContext context) {
    final presc = Provider.of<Item>(context);
    return Container(
      height: 270,
      child: Stack(
        children: [
          Container(
            height: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Colors.green,
            ),
          ),
          Container(
            height: 200,
            child: CarouselSlider(
              items: [
                Image(
                  image: AssetImage('assets/Images/free_home_delivery.png'),
                ),
                Image(
                  image: AssetImage('assets/Images/e_pharm.jpeg'),
                ),
                Image(
                  image: AssetImage('assets/Images/welcome.png'),
                ),
              ],
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                onChanged: (val) => presc.updateList(val),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search, color: Colors.green),
                  suffixIconColor: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
