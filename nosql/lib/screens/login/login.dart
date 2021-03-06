import 'package:flutter/material.dart';
import 'package:nosql/request/request.dart';
import '../homepage/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: 50,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "TP NoSQL",
                    style: TextStyle(fontSize: 30),
                  ),
                ]),
            SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Container(
                  width: 500.0,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                    ),
                    controller: _controller,
                  ),
                ),
                TextButton(
                  child: const Text("Se connecter"),
                  onPressed: () async {
                    Map res = await formValidator(_controller.text.toString());
                    if (_formKey.currentState!.validate()) {
                      if (res["status"] == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Processing Data'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(res)),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<Map> formValidator(String name) async {
  if (name.isEmpty) {
    return {"status": false};
  }
  Map response = await getUserById(name);
  if (response["error"] != null) {
    return {"status": false};
  }
  return response;
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Error'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("No such user in the database"),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
