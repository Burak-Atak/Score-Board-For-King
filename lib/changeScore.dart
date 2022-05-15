import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

/* This page used to change score */

Map<String, int> handTypes = {
  'Choose Game Type': 0,
  "El": 0,
  "Rıfkı": 0,
  "Kupa": 0,
  "Kız": 0,
  "Erkek": 0,
  "İki": 0
};

class ChangeScore extends StatefulWidget {
  const ChangeScore({Key? key}) : super(key: key);

  @override
  State<ChangeScore> createState() => _ChangeScorePageState();
}

class _ChangeScorePageState extends State<ChangeScore> {
  bool isSelected = false;
  int selectedButton = 0;
  List<TextEditingController> controllers = [
    for (int i = 0; i < players.length; i++) TextEditingController()
  ];
  String? dropdownValue = "Choose Game Type";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Score'),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(children: <Widget>[
            firstRow(),
            playerRows(),
            dropDown(),
            saveButton()
          ]),
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
                  child: TextField(
                    controller: controllers[players.indexOf(player)],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Total Hands',
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              )
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
        height: 425,
        child: SingleChildScrollView(
          child: Column(
            children: [...rows],
          ),
        ));
  }

  // Creates dropdown menu
  Widget dropDown() {
    return DropdownButton<String>(
      iconEnabledColor: lightGreen,
      borderRadius: BorderRadius.circular(10),
      alignment: Alignment.center,
      value: dropdownValue,
      elevation: 16,
      underline: Container(
        height: 2,
        color: lightGreen,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: handTypes.keys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: value != handTypes.keys.elementAt(0)
                ? mainStyle
                : const TextStyle(
                    color: Colors.white, fontStyle: FontStyle.italic, fontSize: 23),
          ),
        );
      }).toList(),
      itemHeight: 50,
    );
  }

  // When clicked, updates scores and hand types count
  Widget saveButton() {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ElevatedButton(
          style: buttonStyle,

          child: const Text(
            "Update",
            style: buttonFontStyle,
          ),
          onPressed: dropdownValue == "Choose Game Type"
              ? null
              : () {
                  int multiplier = 1;
                  switch (dropdownValue) {
                    case "El":
                      multiplier = 50;
                      break;
                    case "Rıfkı":
                      multiplier = 320;
                      break;
                    case "Kupa":
                      multiplier = 30;
                      break;
                    case "Kız":
                      multiplier = 100;
                      break;
                    case "Erkek":
                      multiplier = 60;
                      break;
                    case "İki":
                      multiplier = 180;
                      break;
                  }
                  for (var controller in controllers) {
                    if (controller.text.isNotEmpty) {
                      players[controllers.indexOf(controller)].score +=
                          int.parse(controller.text) * multiplier;
                    }
                  }
                  handTypes[dropdownValue!] = handTypes[dropdownValue!]! + 1;
                  Navigator.pop(context);
                },
        ),
      ),
    );
  }
}
