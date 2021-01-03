part of containers;

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
