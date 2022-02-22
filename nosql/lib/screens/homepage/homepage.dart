import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'component/articles.dart';
import 'component/articlesfriend.dart';
import 'component/articlesfriendbyarticle.dart';
import 'component/users.dart';
import '../profile/user.dart';

class HomePage extends StatefulWidget {
  HomePage(this.value);
  Map value;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value["prenomUtilisateur"] +
            " " +
            widget.value["nomUtilisateur"]),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UserProfile(widget.value["idUtilisateur"])),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("List of user:"),
              Users(widget.value["idUtilisateur"]),
              const Text("Shopping article:"),
              Articles(widget.value["idUtilisateur"]),
              const Text('Article parmis le niveau N des followers'),
              ArticlesFriend(widget.value["idUtilisateur"]),
              const Text(
                  "Article parmis le niveau N des followers sur l'article X"),
              ArticlesFriendByArticle(widget.value["idUtilisateur"])
            ],
          ),
        ),
      ),
    );
  }
}
