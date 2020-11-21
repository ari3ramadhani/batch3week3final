import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaperplugin/wallpaperplugin.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailWallpaper extends StatefulWidget {
  String nama, gambar;

  DetailWallpaper({this.nama, this.gambar});

  @override
  _DetailWallpaperState createState() => _DetailWallpaperState();
}

class _DetailWallpaperState extends State<DetailWallpaper> {
  List data;
  String _localPath;

  void initState() {
    super.initState();
    getData();
  }

  Future<String> getData() async {
    var onlineData = await http.get(
        'https://api.unsplash.com/search/photos?per_page=30&client_id=NiB7XjoSs_1Rd3rUZ7DuheTDmF9fzz91zX_6JHhGL9I&query=naruto');
    var jsonData = json.decode(onlineData.body);
    setState(() {
      data = jsonData['results'];
    });
    return "success";
  }

  static Future<bool> _checkAndGetPermission() async {
    final PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      final Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions(<PermissionGroup>[PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
        return null;
      }
    }
    return true;
  }

  _onTapProcess(context, values) {
    return CupertinoAlertDialog(
      title: new Text("Set As Wallpaper"),
      content: Text('click Yes to set wallpaper'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes!'),
          onPressed: () async {
            if (_checkAndGetPermission() != null) {
              Dio dio = Dio();
              final Directory appdirectory =
                  await getExternalStorageDirectory();
              final Directory directory =
                  await Directory(appdirectory.path + '/wallpapers')
                      .create(recursive: true);
              final String dir = directory.path;
              String localPath = '$dir/myImages.jpeg';
              try {
                dio.download(values, localPath);
                setState(() {
                  _localPath = localPath;
                });
                Wallpaperplugin.setAutoWallpaper(localFile: _localPath);
                Wallpaperplugin.setAutoWallpaper(localFile: _localPath);
              } on PlatformException catch (e) {
                print(e);
              }
              Navigator.pop(context);
            } else {}
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.nama}'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Center(
        child: Hero(
          tag: widget.gambar,
          child: Material(
            child: Image.network(
              widget.gambar,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.setWallpaper) {
      showDialog(
          context: context,
          builder: (context) => _onTapProcess(context, widget.gambar));
    }
  }
}

class Constants {
  static const String setWallpaper = 'Set as wallpaper';

  static const List<String> choices = <String>[
    setWallpaper,
  ];
}
