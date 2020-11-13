import 'dart:convert';
import 'package:batch3week3final/pagewallpaper/detailwallpaper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tennis extends StatefulWidget {
  @override
  _TennisState createState() => _TennisState();
}

class _TennisState extends State<Tennis> {
  List data;

  void initState() {
    super.initState();
    getData();
  }

  Future<String> getData() async {
    var onlineData = await http.get(
        'https://api.unsplash.com/search/photos?per_page=30&client_id=NiB7XjoSs_1Rd3rUZ7DuheTDmF9fzz91zX_6JHhGL9I&query=Tennis');
    var jsonData = json.decode(onlineData.body);
    setState(() {
      data = jsonData['results'];
    });
    return "success";
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: AppBar(
            title: Center(child: Text('- - Tennis - -')),
            backgroundColor: Colors.black,
          ),
        ),
        body: GridView.builder(
            itemCount: data == null ? 0 : data.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailWallpaper(
                                gambar: data[index]['urls']['small'],
                                nama:data[index]['alt_description'],


                              )));
                    },

                    child: Container(
                      width: 300.0,
                      height: 300.0,

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: new Image.network(
                          data[index]['urls']['small'],
                          fit: BoxFit.cover,
                          height: 500.0,
                        ),
                      ),
                    ),

                  ),
                ],
              );
            })
    );
  }
}
