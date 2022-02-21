import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'helper/articles.dart';
import 'helper/users.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("List of user:"),
              const Users(),
              const Text("Shopping article:"),
              const Articles(),
            ],
          ),
        ),
      ),
    );
  }
}
