import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomePage(title: 'Tic-Tac-Toe'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

enum _TileState { uninitialised, firstPlayerTap, secondPlayerTap }

class _HomePageState extends State<HomePage> {
  final List<_TileState> _board = List<_TileState>.generate(9, (int index) {
    return _TileState.uninitialised;
  });
  bool _isFirstTurn = true;
  bool _isGameEnd = false;

  void _checkGameEnd(bool isFirst) {
    // Horizontal win check
    if ((_board[0] == _board[1]) && (_board[1] == _board[2]) && _board[1] != _TileState.uninitialised) {
      _highlightWin(0, 1, 2);
    }
    if ((_board[3] == _board[4]) && (_board[4] == _board[5]) && _board[4] != _TileState.uninitialised) {
      _highlightWin(3, 4, 5);
    }
    if ((_board[6] == _board[7]) && (_board[7] == _board[8]) && _board[7] != _TileState.uninitialised) {
      _highlightWin(6, 7, 8);
    }

    // Vertical win check
    if ((_board[0] == _board[3]) && (_board[3] == _board[6]) && _board[3] != _TileState.uninitialised) {
      _highlightWin(0, 3, 6);
    }
    if ((_board[1] == _board[4]) && (_board[4] == _board[7]) && _board[4] != _TileState.uninitialised) {
      _highlightWin(1, 4, 7);
    }
    if ((_board[2] == _board[5]) && (_board[5] == _board[8]) && _board[5] != _TileState.uninitialised) {
      _highlightWin(2, 5, 8);
    }

    // Diagonal win check
    if ((_board[0] == _board[4]) && (_board[4] == _board[8]) && _board[4] != _TileState.uninitialised) {
      _highlightWin(0, 4, 8);
    }
    if ((_board[2] == _board[4]) && (_board[4] == _board[6]) && _board[4] != _TileState.uninitialised) {
      _highlightWin(2, 4, 6);
    }

    // Check for draw
    if (!_board.contains(_TileState.uninitialised)) {
      setState(() {
        _isGameEnd = true;
      });
    }
  }

  void _highlightWin(int indexOne, int indexTwo, int indexThree) {
    setState(() {
      // Reset the game board
      _board.fillRange(0, _board.length, _TileState.uninitialised);
      _isGameEnd = true;

      if (_isFirstTurn) {
        _board[indexOne] = _TileState.firstPlayerTap;
        _board[indexTwo] = _TileState.firstPlayerTap;
        _board[indexThree] = _TileState.firstPlayerTap;
      } else {
        _board[indexOne] = _TileState.secondPlayerTap;
        _board[indexTwo] = _TileState.secondPlayerTap;
        _board[indexThree] = _TileState.secondPlayerTap;
      }
    });
  }

  void _onPlayerTap(int index) {
    setState(() {
      if (_board[index] == _TileState.uninitialised) {
        _board[index] = _isFirstTurn ? _TileState.firstPlayerTap : _TileState.secondPlayerTap;
        _checkGameEnd(_isFirstTurn);
        _isFirstTurn = !_isFirstTurn;
      }
    });
  }

  Color _getTileColor(int index) {
    if (_board[index] == _TileState.firstPlayerTap) {
      return Colors.green;
    } else if (_board[index] == _TileState.secondPlayerTap) {
      return Colors.red;
    }
    return Theme.of(context).scaffoldBackgroundColor; // color the uninitialised tiles with background color
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            // Both Column and GridView widgets expand the size on main axis, so shrinkWrap property should be used,
            // as the GridView is of a fairly small size
            Container(
              color: Colors.black,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child:
                          AnimatedContainer(duration: const Duration(milliseconds: 500), color: _getTileColor(index)),
                      onTap: () {
                        _onPlayerTap(index);
                      });
                },
              ),
            ),
            Visibility(
              visible: _isGameEnd,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Reset the game board
                        _board.fillRange(0, _board.length, _TileState.uninitialised);
                        _isFirstTurn = true;
                        _isGameEnd = false;
                      });
                    },
                    child: const Text('Play again!')),
              ),
            )
          ],
        ));
  }
}
