import 'package:batch3week3final/pagewallpaper/wallpaper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Wallpaper(),
    debugShowCheckedModeBanner: false,
  ));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Week3"),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> Wallpaper()));
                  },
                  child: Text(
                    "Task6 Walpaper",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  textColor: Colors.black,
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
