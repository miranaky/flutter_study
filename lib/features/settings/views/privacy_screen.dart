import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/settings/view_models/darkmode_config_vm.dart';
import 'package:thread_clone/features/settings/views/settings_screen.dart';

class PrivacyScreen extends ConsumerStatefulWidget {
  static const routeURL = 'privacy';
  static const routeName = "privacy";
  const PrivacyScreen({super.key});

  @override
  PrivacyScreenState createState() => PrivacyScreenState();
}

class PrivacyScreenState extends ConsumerState<PrivacyScreen> {
  bool _privateProfile = true;

  final List<Map<String, dynamic>> _privacy_list = [
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
      "trailing": Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Everyone",
            style: TextStyle(
              fontSize: Sizes.size16,
              color: Colors.grey.shade500,
            ),
          ),
          Gaps.h5,
          FaIcon(
            FontAwesomeIcons.chevronRight,
            size: Sizes.size16,
            color: Colors.grey.shade500,
          ),
        ],
      )
    },
    {
      "title": "Mute",
      "icon": FontAwesomeIcons.bellSlash,
      "trailing": FaIcon(
        FontAwesomeIcons.chevronRight,
        size: Sizes.size16,
        color: Colors.grey.shade500,
      ),
    },
    {
      "title": "Hidden Words",
      "icon": FontAwesomeIcons.eyeSlash,
      "trailing": FaIcon(
        FontAwesomeIcons.chevronRight,
        size: Sizes.size16,
        color: Colors.grey.shade500,
      ),
    },
    {
      "title": "Profiles you follow",
      "icon": FontAwesomeIcons.users,
      "trailing": FaIcon(
        FontAwesomeIcons.chevronRight,
        size: Sizes.size16,
        color: Colors.grey.shade500,
      ),
    }
  ];

  void _onPrivateProfileChanged(bool value) {
    if (value == null) return;
    setState(() {
      _privateProfile = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(darkModeConfigViewModelProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey.shade400,
        title: const Text(
          "Privacy",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: Sizes.size20,
          ),
        ),
        leading: GestureDetector(
          onTap: () => context.go(SettingsScreen.routeURL),
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
            activeColor: isDark ? Colors.grey.shade700 : Colors.black,
            value: _privateProfile,
            onChanged: _onPrivateProfileChanged,
            title: const Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.lock,
                  size: Sizes.size24,
                ),
                Gaps.h20,
                Text(
                  "Private Profile",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          for (var setting in _privacy_list)
            ListTile(
              leading: FaIcon(
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
              trailing: setting["trailing"],
            ),
          Divider(
            height: Sizes.size20,
            thickness: Sizes.size2,
            color: Colors.grey.shade300,
          ),
          ListTile(
            title: const Text(
              "Other Privacy settings",
              style: TextStyle(
                fontSize: Sizes.size18,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.arrowUpRightFromSquare,
              size: Sizes.size18,
              color: Colors.grey.shade500,
            ),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.circleXmark,
              size: Sizes.size24,
            ),
            title: const Text(
              "Blocked profiles",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.arrowUpRightFromSquare,
              size: Sizes.size18,
              color: Colors.grey.shade500,
            ),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.heartCrack,
              size: Sizes.size24,
            ),
            title: const Text(
              "Hide likes",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.arrowUpRightFromSquare,
              size: Sizes.size18,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
