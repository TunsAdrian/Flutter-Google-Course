import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomePage(title: 'Currency Converter'),
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
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double valueEur;
  double valueRon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.network(
              'https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/06/13/09/euros.jpg?width=990'),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter the amount in EUR',
                  ),
                  validator: (String value) {
                    if (double.tryParse(value) == null) {
                      return 'Please enter a number';
                    }
                    return null;
                  },
                )),
          ),
          RaisedButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    valueEur = double.parse(controller.text);
                    valueRon = valueEur * 4.87;
                  }
                });
              },
              child: const Text('CONVERT!')),
          Text(valueRon == null ? '' : '$valueRon RON',
              style: const TextStyle(fontSize: 28, color: Colors.grey)),
        ],
      )),
    );
  }
}
