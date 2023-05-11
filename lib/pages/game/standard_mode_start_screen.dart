// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/pages/game/game_properties.dart';
import 'package:quiz_flutter/pages/game/game_screen.dart';
import 'package:quiz_flutter/styles/appbar.dart';
import 'package:quiz_flutter/styles/buttons.dart';

class StandardModeStartScreen extends StatefulWidget {
  const StandardModeStartScreen({super.key});

  @override
  State<StandardModeStartScreen> createState() =>
      _StandardModeStartScreenState();
}

class _StandardModeStartScreenState extends State<StandardModeStartScreen> {
  late GameProperties gameProperties;

  String selectedDifficulty = 'Easy';
  String selectedCategory = 'All Categories';
  List<Text> difficulty = [
    const Text('Easy'),
    const Text('Medium'),
    const Text('Hard'),
  ];
  List<Text> categories = [
    const Text('All Categories'),
    const Text('Linux'),
    const Text('DevOps'),
    const Text('Networking'),
    const Text('Programming'),
    const Text('Cloud'),
    const Text('Docker'),
    const Text('Kubernetes'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeModel, child) {
        return Scaffold(
          appBar:
              standardAppBar2(themeModel, 'Start Standard Mode', context, true),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.category_outlined,
                                  size: 30,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Select Category',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () => BottomPicker(
                                dismissable: true,
                                items: categories,
                                title: 'Select Category',
                                displayCloseIcon: false,
                                buttonText: 'Select',
                                displayButtonIcon: false,
                                buttonSingleColor:
                                    Theme.of(context).colorScheme.primary,
                                buttonTextStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                                onSubmit: (p0) => setState(() {
                                  Fluttertoast.showToast(
                                      msg:
                                          ' Selected Category: ${categories[p0].data!}');
                                  selectedCategory = categories[p0].data!;
                                }),
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                titleStyle:
                                    Theme.of(context).textTheme.bodyLarge!,
                                pickerTextStyle:
                                    Theme.of(context).textTheme.bodyLarge!,
                              ).show(context),
                              child: Text(
                                selectedCategory,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.offline_bolt_rounded,
                                  size: 30,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Select Difficulty',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () => BottomPicker(
                                dismissable: true,
                                items: difficulty,
                                title: 'Select Difficulty',
                                displayCloseIcon: false,
                                buttonText: 'Select',
                                displayButtonIcon: false,
                                buttonSingleColor:
                                    Theme.of(context).colorScheme.primary,
                                buttonTextStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                                onSubmit: (p0) => setState(() {
                                  Fluttertoast.showToast(
                                      msg:
                                          ' Selected Difficulty: ${difficulty[p0].data!}');
                                  selectedDifficulty = difficulty[p0].data!;
                                }),
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                                titleStyle:
                                    Theme.of(context).textTheme.bodyLarge!,
                                pickerTextStyle:
                                    Theme.of(context).textTheme.bodyLarge!,
                              ).show(context),
                              child: SizedBox(
                                width: 70,
                                child: Center(
                                  child: Text(
                                    selectedDifficulty,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  buttonRow(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buttonRow() => Expanded(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StandardButton(
                label: 'Start',
                onPressed: startGame,
              ),
              StandardButton(label: 'Reset', onPressed: resetProperties),
            ],
          ),
        ),
      );

  void startGame() {
    log('Selected Category: $selectedCategory');
    log('Selected Difficulty: $selectedDifficulty');
    GameProperties gameProperties = GameProperties(
      selectedDifficulty,
      selectedCategory,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(gameProperties: gameProperties),
      ),
    );
  }

  void resetProperties() {
    Fluttertoast.showToast(msg: 'Reset');
    setState(() {
      selectedDifficulty = 'Easy';
      selectedCategory = 'All Categories';
    });
  }
}
