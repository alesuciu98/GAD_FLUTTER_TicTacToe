import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TicTacToe(),
  ));
}

class GameFields {
  GameFields({this.id, this.text = '', this.clr = Colors.white, this.enable = true});

  final int id;
  String text;
  Color clr;
  bool enable;
}

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Tic-Tac-Toe'),
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
  int val;
  int win = -1;
  bool change;
  bool pressOK = false;
  List<GameFields> fieldsList;
  List<dynamic> first;
  List<dynamic> second;
  int currentPlayer;

  @override
  void initState() {
    super.initState();
    fieldsList = doInit();
  }

  List<GameFields> doInit() {
    first = <dynamic>[];
    second = <dynamic>[];
    currentPlayer = 1;

    final List<GameFields> fields = <GameFields>[
      GameFields(id: 1),
      GameFields(id: 2),
      GameFields(id: 3),
      GameFields(id: 4),
      GameFields(id: 5),
      GameFields(id: 6),
      GameFields(id: 7),
      GameFields(id: 8),
      GameFields(id: 9),
    ];
    return fields;
  }

  void game(GameFields g) {
    setState(() {
      if (currentPlayer == 1) {
        g.text = 'X';
        g.clr = Colors.pinkAccent;
        currentPlayer = 2;
        first.add(g.id);
      } else {
        g.text = '0';
        g.clr = Colors.greenAccent;
        currentPlayer = 1;
        second.add(g.id);
      }
      g.enable = false;
    });
  }

  void winner() {
    win = -1;
    pressOK = false;
    if (first.contains(1) && first.contains(2) && first.contains(3)) {
      win = 1;
    } else if (second.contains(1) && second.contains(2) && second.contains(3)) {
      win = 2;
    } else if (first.contains(4) && first.contains(5) && first.contains(6)) {
      win = 1;
    } else if (second.contains(4) && second.contains(5) && second.contains(6)) {
      win = 2;
    } else if (first.contains(7) && first.contains(8) && first.contains(9)) {
      win = 1;
    } else if (second.contains(7) && second.contains(8) && second.contains(9)) {
      win = 2;
    } else if (first.contains(1) && first.contains(4) && first.contains(7)) {
      win = 1;
    } else if (second.contains(1) && second.contains(4) && second.contains(7)) {
      win = 2;
    } else if (first.contains(2) && first.contains(5) && first.contains(8)) {
      win = 1;
    } else if (second.contains(2) && second.contains(5) && second.contains(8)) {
      win = 2;
    } else if (first.contains(3) && first.contains(6) && first.contains(9)) {
      win = 1;
    } else if (second.contains(3) && second.contains(6) && second.contains(9)) {
      win = 2;
    } else if (first.contains(1) && first.contains(5) && first.contains(9)) {
      win = 1;
    } else if (second.contains(1) && second.contains(5) && second.contains(9)) {
      win = 2;
    } else if (first.contains(3) && first.contains(5) && first.contains(7)) {
      win = 1;
    } else if (second.contains(3) && second.contains(5) && second.contains(7)) {
      win = 2;
    }
    if ((first.contains(1) || second.contains(1)) &&
        (first.contains(2) || second.contains(2)) &&
        (first.contains(3) || second.contains(3)) &&
        (first.contains(4) || second.contains(4)) &&
        (first.contains(5) || second.contains(5)) &&
        (first.contains(6) || second.contains(6)) &&
        (first.contains(7) || second.contains(7)) &&
        (first.contains(8) || second.contains(8)) &&
        (first.contains(9) || second.contains(9))) {
      pressOK = true;
    }
  }

  void playAgain() {
    winner();
    setState(() {
      if (win == 1 || win == 2 || pressOK == true) {
        fieldsList = doInit();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.blue[800]),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              itemCount: fieldsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1.0, crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(color: fieldsList[index].clr, border: Border.all(width: 2.0)),
                  child: FlatButton(
                    onPressed: fieldsList[index].enable ? () => game(fieldsList[index]) : null,
                    child: Text(
                      fieldsList[index].text,
                      style: const TextStyle(color: Colors.white, fontSize: 50.0),
                    ),
                  ),
                );
              },
            ),
          ),
          FlatButton(
            padding: const EdgeInsets.all(8.0),
            onPressed: playAgain,
            child: const Text(
              'Play Again',
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
