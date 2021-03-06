import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nosql/components/placeholder.dart';
import 'package:nosql/request/request.dart';

class ArticlesFriend extends StatefulWidget {
  ArticlesFriend(
    this.value, {
    Key? key,
  }) : super(key: key);
  String value;
  @override
  State<ArticlesFriend> createState() => _ArticlesFriendState();
}

class _ArticlesFriendState extends State<ArticlesFriend> {
  int _currentIntValue = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 700,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
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
          ),
          Container(
            child: FutureBuilder<List<dynamic>>(
              future: getProductsByLevelN(
                  int.parse(widget.value), _currentIntValue),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ResultArticle(snapshot.data!, widget.value);
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
    this.result,
    this.value, {
    Key? key,
  }) : super(key: key);
  String value;
  List<dynamic> result;
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
              Text(result[index]["nomProduit"]),
              Text(result[index]["prix"] + "???"),
              Text("Achet?? " + result[index]["count"].toString() + " fois"),
              Icon(
                Icons.shop_2_outlined,
                size: 50,
                color: Colors.grey,
              ),
              TextButton(
                onPressed: () {
                  buyArticle(int.parse(value), result[index]["idProduit"]);
                },
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
