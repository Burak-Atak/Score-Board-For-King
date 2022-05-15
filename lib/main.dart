import 'package:flutter/material.dart';
import 'package:king/players.dart';

import 'changeScore.dart';

List<Player> players = [];

// Define const variables
const String no = "NO";
const String name = "NAME";
const String score = "SCORE";
const green = Color(0xff39FF14);
const lightGreen = Color(0xff7da565);
const grey = Color(0xff696969);
const buttonFontStyle = TextStyle(
  fontSize: 20,
);
var buttonStyle = ElevatedButton.styleFrom(
  primary: lightGreen,
);
const firstRowStyle = TextStyle(
  fontFamily: "Poppins",
  fontSize: 27,
  color: green,
);
const mainStyle = TextStyle(
  fontSize: 23,
  color: Colors.white,

);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'King'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 35, fontFamily: "PTSerif"),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            firstRow(),
            playerRows(),
            bottomRow(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                updateScoreButton(),
                addPlayerButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  // First row of the app this contains titles
  Padding firstRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 8.0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            SizedBox(
              width: 50,
              child: Text(
                no,
                style: firstRowStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 198,
                child: Text(
                  name,
                  style: firstRowStyle,
                ),
              ),
            ),
            SizedBox(
              width: 151.4,
              child: Text(
                score,
                style: firstRowStyle,
              ),
            )
          ]),
    );
  }

  // This represents the row for every player in game
  SizedBox playerRows() {
    List<Widget> rows = [];
    for (var player in players) {
      Widget playerRow = SizedBox(
        height: 50,
        child: Container(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 50,
                child: Text(
                  "#" + (players.indexOf(player) + 1).toString(),
                  style: mainStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  width: 198,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      player.name,
                      style: mainStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 151.4,
                height: 50,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    player.score.toString(),
                    style: mainStyle,
                  ),
                ),
              ),
            ],
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: lightGreen,
                width: 0.7,
              ),
            ),
          ),
        ),
      );
      rows.add(playerRow);
    }
    return SizedBox(
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            children: [...rows],
          ),
        ));
  }

  // This row contains hands types
  Widget bottomRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          ...handTypesColumns(),
        ],
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  // This function creates the columns for the bottom row
  List<Widget> handTypesColumns() {
    List<Widget> columns = [];
    for (var handType in handTypes.keys) {
      if (handTypes.keys.toList().indexOf(handType) == 0) {
        continue;
      }
      Widget flex = Flexible(
        flex: 1,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(handType,
              style: TextStyle(
                  fontSize: 23,
                  color: handTypes[handType] == 2 ? green : Colors.white,
                  fontWeight: FontWeight.bold)),
          Text(handTypes[handType].toString(),
              style: TextStyle(
                  fontSize: 23,
                  color: handTypes[handType] == 2 ? green : Colors.white))
        ]),
      );

      columns.add(flex);
    }
    return columns;
  }

  // This function creates updateButton
  Widget updateScoreButton() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        width: 160,
        height: 50,
        child: ElevatedButton(
            style: buttonStyle,
            child: const Text("Update Score", style: buttonFontStyle),
            onPressed: players.isEmpty
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangeScore()),
                    ).then((_) {
                      setState(() {});
                    });
                  }),
      ),
    );
  }

  // This function creates addPlayerButton
  Widget addPlayerButton() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        width: 160,
        height: 50,
        child: ElevatedButton(
          style: buttonStyle,
          child: const Text("Add Player", style: buttonFontStyle),
          onPressed: addPlayer,
        ),
      ),
    );
  }

  void addPlayer() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddPlayer()),
    ).then((_) {
      setState(() {});
    });
  }
}
