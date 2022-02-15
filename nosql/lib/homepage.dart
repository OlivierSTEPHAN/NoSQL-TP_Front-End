import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage(this.value);
  final String value;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.blueGrey,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    color: Colors.blueGrey,
                    margin: new EdgeInsets.symmetric(horizontal: 20.0),
                  );
                },
              ),
            ),
            Text('On va mettre plein de truc là'),
          ],
        ),
      ),
    );
  }
}
