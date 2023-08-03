import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_flutter/apis/firebase/user_firebase.dart';
import 'package:quiz_flutter/pages/drawer-pages/leaderboard.dart';
import 'package:quiz_flutter/utils/ui_helper.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: Text(
              'My Profile',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
            leading: const Icon(Icons.person_outlined),
            onTap: () => Fluttertoast.showToast(msg: 'Profile'),
          ),
          ListTile(
            title: Text(
              'Show Friends',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
            leading: const Icon(Icons.people_outlined),
            onTap: () => Fluttertoast.showToast(msg: 'Show Friends'),
          ),
          ListTile(
            title: const Text('Leaderboard'),
            leading: const Icon(Icons.leaderboard_outlined),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LeaderBoard())),
          ),
          ListTile(
            title: Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
            leading: const Icon(Icons.settings_outlined),
            onTap: () => Fluttertoast.showToast(msg: 'Settings'),
          ),
          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.logout_outlined),
            onTap: () => {
              Navigator.pop(context),
              UIHelper.showConfirmationDialog(
                  'Sign Out?', context, () => UserHelper.signOutUser(context))
            },
          ),
        ],
      ),
    );
  }
}
