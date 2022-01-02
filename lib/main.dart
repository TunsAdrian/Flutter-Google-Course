import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Shape',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomePage(title: 'Number Shape'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _numberFindShape = '';
  String _numberShapeResult = '';

  String _findNumberShape(int number) {
    final int cube = pow(number, 1 / 3).round().toInt();
    final int square = sqrt(number).toInt();

    if (cube * cube * cube == number && square * square == number) {
      return 'Number $number is both SQUARE and CUBE';
    } else if (cube * cube * cube == number) {
      return 'Number $number is CUBE';
    } else if (square * square == number) {
      return 'Number $number is SQUARE';
    }

    return 'Number $number is neither SQUARE nor CUBE';
  }

  // source: api.flutter.dev
  Future<void> _showNumberShapeDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must not tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_numberFindShape),
          content: Text(_numberShapeResult),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          setState(() {
            if (_formKey.currentState.validate()) {
              _numberFindShape = _controller.text;
              _numberShapeResult = _findNumberShape(int.parse(_numberFindShape));
              _showNumberShapeDialog();
            }
          });
        },
        child: const Icon(Icons.done),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              const Text('Please input a number to see if it is SQUARE or CUBE:', style: TextStyle(fontSize: 20)),
              Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (int.tryParse(value) == null || int.parse(value) < 0) {
                        return 'Please enter a whole, positive number';
                      }
                      return null;
                    },
                  )),
            ],
          )),
    );
  }
}
