import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nosql/components/placeholder.dart';
import 'package:nosql/request/request.dart';
import 'package:flutter_picker/flutter_picker.dart';

class ArticlesFriendByArticle extends StatefulWidget {
  ArticlesFriendByArticle({
    Key? key,
  }) : super(key: key);
  @override
  State<ArticlesFriendByArticle> createState() =>
      _ArticlesFriendByArticleState();
}

class _ArticlesFriendByArticleState extends State<ArticlesFriendByArticle> {
  int _currentIntValue = 1;
  dynamic _currentChoice = 0;
  List<String> _choices = ["banane", "pomme", "poire", "fraise"];

  showPickerModal(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: const JsonDecoder().convert(jsonEncode(_choices))),
        hideHeader: false,
        onConfirm: (Picker picker, List value) {
          setState(() {
            _currentChoice = value[0];
          });
        }).showModal(context); //_scaffoldKey.currentState);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 700,
      color: Colors.grey[300],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FutureBuilder(
              future: getProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return productChanger(context);
                } else if (snapshot.hasError) {
                  return Text("Error");
                }
                return Container();
              },
            ),
            valueChanger(),
            Container(
              child: FutureBuilder<List<String>>(
                future: computeData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ResultArticle(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text("Error");
                  }
                  return WaitingArticle();
                },
              ),
              height: 660,
            )
          ],
        ),
      ),
    );
  }

  ListTile productChanger(BuildContext context) {
    return ListTile(
      title: Text('Select your product : ${_choices[_currentChoice]}'),
      onTap: () {
        showPickerModal(context);
      },
    );
  }

  Row valueChanger() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => setState(() {
            final newValue = _currentIntValue - 1;
            _currentIntValue = newValue.clamp(1, 5);
          }),
        ),
        Text('Current level value: $_currentIntValue'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => setState(() {
            final newValue = _currentIntValue + 1;
            _currentIntValue = newValue.clamp(1, 5);
          }),
        ),
      ],
    );
  }
}

class WaitingArticle extends StatelessWidget {
  const WaitingArticle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          color: Colors.blue[50],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              placeHolder(20, 70),
              Icon(
                Icons.shop_2_outlined,
                size: 50,
                color: Colors.grey,
              ),
              placeHolder(20, 130),
            ],
          ),
        ),
      ),
      itemCount: 10,
    );
  }
}

class ResultArticle extends StatelessWidget {
  ResultArticle(
    this.result, {
    Key? key,
  }) : super(key: key);

  List<String> result;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          color: Colors.blue[50],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Nom de l'article"),
              Icon(
                Icons.shop_2_outlined,
                size: 50,
                color: Colors.grey,
              ),
              TextButton(
                onPressed: () {},
                child: Text("Acheter"),
              )
            ],
          ),
        ),
      ),
      itemCount: result.length,
    );
  }
}
