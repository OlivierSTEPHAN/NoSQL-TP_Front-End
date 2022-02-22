import 'package:flutter/material.dart';
import 'package:nosql/components/placeholder.dart';
import 'package:nosql/request/request.dart';

class Users extends StatelessWidget {
  const Users({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<dynamic>>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ResultListView(snapshot.data!);
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

class ResultListView extends StatelessWidget {
  ResultListView(
    this.result, {
    Key? key,
  }) : super(key: key);
  List<dynamic> result;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: result.length,
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
                  Text(result[index]["prenomUtilisateur"]),
                  Text(result[index]["nomUtilisateur"]),
                ],
              ),
              Icon(
                Icons.perm_contact_cal,
                size: 40,
                color: Colors.grey,
              ),
              TextButton(
                onPressed: () {},
                child: Text("Add"),
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
