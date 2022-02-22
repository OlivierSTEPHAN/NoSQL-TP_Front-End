import 'package:flutter/material.dart';

import 'component/boughtarticle.dart';
import 'component/friends.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.value, {Key? key}) : super(key: key);
  String value;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("List of friend:"),
              Friends(widget.value),
              const Text("Bought article : "),
              BoughtArticles(widget.value)
            ],
          ),
        ),
      ),
    );
  }
}
