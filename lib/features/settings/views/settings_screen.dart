import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/authentication/repos/authentication_repo.dart';
import 'package:thread_clone/features/settings/view_models/darkmode_config_vm.dart';
import 'package:thread_clone/features/settings/views/privacy_screen.dart';
import 'package:thread_clone/features/user_profile/user_profile_screen.dart';

const List<Map<String, dynamic>> _settings = [
  {
    "title": "Follow and invite friends",
    "icon": FontAwesomeIcons.userPlus,
  },
  {
    "title": "Notifications",
    "icon": FontAwesomeIcons.bell,
  },
  {
    "title": "Privacy",
    "icon": FontAwesomeIcons.lock,
  },
  {
    "title": "Account",
    "icon": FontAwesomeIcons.circleUser,
  },
  {
    "title": "Help",
    "icon": FontAwesomeIcons.lifeRing,
  },
  {
    "title": "About",
    "icon": FontAwesomeIcons.circleInfo,
  }
];

class SettingsScreen extends ConsumerWidget {
  static const routeURL = '/settings';
  static const routeName = "settings";
  const SettingsScreen({super.key});

  void _onTapPrivacy(BuildContext context) {
    context.goNamed(PrivacyScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey.shade400,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: Sizes.size20,
          ),
        ),
        leading: GestureDetector(
          onTap: () => context.go(UserProfileScreen.routeURL),
          child: const Row(
            children: [
              Gaps.h10,
              FaIcon(FontAwesomeIcons.chevronLeft),
              Gaps.h5,
              Text(
                "Back",
                style: TextStyle(
                  fontSize: Sizes.size20,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 100,
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            title: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: Sizes.size16),
                  child: Icon(
                    FontAwesomeIcons.moon,
                    size: Sizes.size24,
                  ),
                ),
                Text(
                  "Dark mode",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            value: ref.watch(darkModeConfigViewModelProvider).isDarkMode,
            onChanged: (value) => ref
                .read(darkModeConfigViewModelProvider.notifier)
                .setDarkMode(value),
          ),
          for (var setting in _settings)
            ListTile(
              onTap: setting['title'] == 'Privacy'
                  ? () => _onTapPrivacy(context)
                  : () {},
              leading: Icon(
                setting["icon"],
                size: Sizes.size24,
              ),
              title: Text(
                setting["title"],
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Divider(
            height: Sizes.size20,
            thickness: 1,
            color: Colors.grey.shade300,
          ),
          ListTile(
            onTap: () => {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Do you want to log out?"),
                  actions: [
                    CupertinoDialogAction(
                      textStyle: const TextStyle(color: Colors.blueAccent),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("No"),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                      onPressed: () => ref.read(authRepo).signOut(),
                    ),
                  ],
                ),
              ),
            },
            title: const Text(
              "Log out",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
