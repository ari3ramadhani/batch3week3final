import 'package:batch3week3final/pagewallpaper/tennis.dart';
import 'package:batch3week3final/pagewallpaper/volley.dart';
import 'package:flutter/material.dart';

import 'basket.dart';
import 'bowling.dart';
import 'football.dart';
import 'golf.dart';



class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> with SingleTickerProviderStateMixin {

  TabController _tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.white,
            title: new TabBar(
                isScrollable: true,
                controller: _tabController,

                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 15.0),
                    insets: EdgeInsets.symmetric(horizontal:10.0)
                ),
                unselectedLabelColor: Colors.lightGreen,
                tabs: <Tab>[
                  new Tab(icon: new Image.asset('gambar/football.png')),
                  new Tab(icon: new Image.asset('gambar/basketball.png')),
                  new Tab(icon: new Image.asset('gambar/volleyball.png')),
                  new Tab(icon: new Image.asset('gambar/tennis.png')),
                  new Tab(icon: new Image.asset('gambar/bowling.png')),
                  new Tab(icon: new Image.asset('gambar/golf.png')),
                ]
            )
        ),
        backgroundColor: Colors.grey,
        body: new TabBarView(
            controller: _tabController,
            children: <Widget>[
              Football(),
              Basket(),
              Volley(),
              Tennis(),
              Bowling(),
              Golf(),
            ]
        ),     ),
    );
  }
}