import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess My Number',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomePage(title: 'Guess My Number'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

int _generateRandom() {
  return Random().nextInt(100) + 1;
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _guessState = '', _userNumber = '';
  int _numberToGuess = _generateRandom();
  bool _isGuessed = false;

  Future<void> _showNumberGuessedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You guessed right!'),
          content: Text('It was $_numberToGuess'),
          actions: <Widget>[
            TextButton(
              child: const Text('Try again!'),
              onPressed: () {
                setState(() {
                  _guessState = '';
                  _userNumber = '';
                  _isGuessed = false;
                  _numberToGuess = _generateRandom();
                });

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
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
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const Text('I\'m thinking of a number between 1 and 100.\nIt\'s your turn to guess my number!',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
              Text(_userNumber == '' ? '' : '\nYou tried $_userNumber\n$_guessState\n',
                  textAlign: TextAlign.center, style: const TextStyle(fontSize: 32, color: Colors.grey)),
              Card(
                elevation: 5.0,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: <Widget>[
                      const Text('Try a number!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
                      Form(
                          key: _formKey,
                          child: TextFormField(
                            // If number was guessed, disable text field
                            enabled: !_isGuessed,
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (int.tryParse(value) == null || int.parse(value) < 1 || int.parse(value) > 100) {
                                return 'Please enter a whole number, between 1 and 100';
                              }
                              return null;
                            },
                          )),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // If button is pressed after the number was guessed, reset the game
                              if (_isGuessed) {
                                _userNumber = '';
                                _guessState = '';
                                _isGuessed = false;
                                _numberToGuess = _generateRandom();
                              } else if (_formKey.currentState.validate()) {
                                _userNumber = _controller.text;
                                final int _actualNumberValue = int.parse(_userNumber);
                                if (_actualNumberValue > _numberToGuess) {
                                  _guessState = 'Try lower';
                                } else if (_actualNumberValue < _numberToGuess) {
                                  _guessState = 'Try higher';
                                } else {
                                  _isGuessed = true;
                                  _guessState = 'You guessed right';
                                  _showNumberGuessedDialog();
                                }
                              }
                              _controller.text = '';
                            });
                          },
                          child: Text(_isGuessed ? 'RESET' : 'GUESS'))
                    ])),
              ),
            ],
          )),
    );
  }
}
