import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/pages/game/game_properties.dart';
import 'package:quiz_flutter/styles/appbar.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  String selectedCategory = 'All Categories';
  String selectedDifficulty = 'All Difficulties';
  List<Text> difficulty = [
    const Text('Easy'),
    const Text('Medium'),
    const Text('Hard'),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeModel, child) {
      return Scaffold(
        appBar: standardAppBar2(themeModel, 'Leaderboard', context, true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('high_scores')
                    .where('score', isGreaterThan: 0)
                    .orderBy('score', descending: true)
                    .limit(10)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Image.asset(
                        'assets/images/gifs/loading.gif',
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('Noone has scored yet! Be the first!'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Text(
                                '${index + 1})',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              title: Text(
                                ds['user'],
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              trailing: Text(
                                '${ds['score']}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: pickerButtons(),
      );
    });
  }

  Widget pickerButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(msg: 'Coming Soon!');
            },
            child: Text(
              selectedCategory,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(msg: 'Coming Soon!');
            },
            child: Text(
              selectedDifficulty,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
