import 'package:flutter/material.dart';
import 'package:nosql/components/placeholder.dart';
import 'package:nosql/request/request.dart';

class Articles extends StatelessWidget {
  Articles(
    this.value, {
    Key? key,
  }) : super(key: key);
  String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 700,
      color: Colors.grey.shade200,
      child: FutureBuilder<List<dynamic>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ResultArticle(snapshot.data!, value);
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return WaitingArticle();
        },
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
              Icon(
                Icons.shop_2_outlined,
                size: 50,
                color: Colors.grey,
              ),
              TextButton(
                onPressed: () {
                  buyArticle(
                      int.parse(value), int.parse(result[index]["idProduit"]));
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
