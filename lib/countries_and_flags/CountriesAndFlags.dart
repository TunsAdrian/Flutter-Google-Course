import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Flags and Countries',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Fetch Flags and Countries'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> countryList = <String>[];
  List<String> countryFlagList = <String>[];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final Response response = await get('https://www.worldometers.info/geography/flags-of-the-world/');

    final String data = response.body;
    final List<String> parts = data.split('<a href="/img/flags/').skip(1).toList();

    for (final String part in parts) {
      countryList.add(part.split('10px">')[1].split('<')[0]);
      countryFlagList.add('https://www.worldometers.info/img/flags/${part.substring(0, part.indexOf('"'))}');
    }
    setState(() {
      // countryList and countryFlagList are changed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: countryList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: <Widget>[
                Expanded(flex: 2, child: Image.network(countryFlagList[index])),
                Expanded(
                  flex: 1,
                  child: Text(
                    countryList[index],
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
