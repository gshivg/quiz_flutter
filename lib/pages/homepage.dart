import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:switcher_button/switcher_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Home Page',
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    themeNotifier.isDark
                        ? CupertinoIcons.sun_max
                        : CupertinoIcons.moon,
                  ),
                  onPressed: () {
                    themeNotifier.toggleTheme();
                  },
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Theme Switcher',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ));
      },
    );
  }
}
