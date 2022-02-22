import 'package:flutter/material.dart';
import 'package:nosql/components/placeholder.dart';
import 'package:nosql/request/request.dart';

class Friends extends StatelessWidget {
  Friends(
    this.value, {
    Key? key,
  }) : super(key: key);
  String value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<dynamic>>(
        future: getFriends(value),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ResultListView(snapshot.data!, value);
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return WaitingListView();
        },
      ),
    );
  }
}

class WaitingListView extends StatelessWidget {
  const WaitingListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: 220,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  placeHolder(20, 70),
                  placeHolder(20, 70),
                ],
              ),
              Icon(
                Icons.perm_contact_cal,
                size: 40,
                color: Colors.grey,
              ),
              placeHolder(20, 130),
            ],
          )),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.blueGrey.shade100),
        );
      },
    );
  }
}

class ResultListView extends StatefulWidget {
  ResultListView(
    this.result,
    this.value, {
    Key? key,
  }) : super(key: key);
  List<dynamic> result;
  String value;

  @override
  State<ResultListView> createState() => _ResultListViewState();
}

class _ResultListViewState extends State<ResultListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.result.length,
      itemBuilder: (context, index) {
        return Container(
          width: 220,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(widget.result[index]["prenomUtilisateur"].toString()),
                  Text(widget.result[index]["nomUtilisateur"].toString()),
                  Text(widget.result[index]["idUtilisateur"].toString())
                ],
              ),
              Icon(
                Icons.perm_contact_cal,
                size: 40,
                color: Colors.grey,
              ),
              TextButton(
                onPressed: () {
                  unfollow(int.parse(widget.value),
                      int.parse(widget.result[index]["idUtilisateur"]));
                  setState(() {
                    getFriends(widget.value);
                  });
                },
                child: Text("Unfollow"),
              )
            ],
          )),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.blueGrey.shade100),
        );
      },
    );
  }
}
