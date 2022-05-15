import 'package:flutter/material.dart';

import 'main.dart';

/* This page used to create new players */


class Player {
  String name;
  int score = 0;

  Player(this.name);
}

class AddPlayer extends StatefulWidget {
  const AddPlayer({Key? key}) : super(key: key);

  @override
  State<AddPlayer> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayer> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Player'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 250,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      controller: textController,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: grey, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300),
                        hintText: 'Enter player name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 70,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ElevatedButton(
                    style: buttonStyle,
                    onPressed: textController.text.isEmpty
                        ? null
                        : () {
                            setState(() {
                              players.add(Player(textController.text));
                              textController.text = '';
                            });
                          },
                    child: const Text('Add', style: buttonFontStyle,),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
