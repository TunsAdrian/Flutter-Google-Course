import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:google_hw/actions/get_movies.dart';
import 'package:google_hw/data/yts_api.dart';
import 'package:google_hw/middleware/app_middleware.dart';
import 'package:google_hw/models/app_state.dart';
import 'package:google_hw/presentation/home_page.dart';
import 'package:google_hw/reducer/reducer.dart';

void main() {
  final Client client = Client();
  final YtsApi api = YtsApi(client: client);
  final AppMiddleware appMiddleware = AppMiddleware(ytsApi: api);
  final AppState initialState = AppState();
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: initialState,
    middleware: appMiddleware.middleware,
  );

  store.dispatch(const GetMovies());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const HomePage(),
      ),
    );
  }
}
