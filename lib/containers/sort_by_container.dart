import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_hw/models/app_state.dart';
import 'package:redux/src/store.dart';

class SortByContainer extends StatelessWidget {
  const SortByContainer({Key key, @required this.builder}) : super(key: key);

  final ViewModelBuilder<String> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (Store<AppState> store) => store.state.sortBy,
      builder: builder,
    );
  }
}
