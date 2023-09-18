import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/features/activity/activity_screen.dart';
import 'package:thread_clone/features/main_navigation/post_screen.dart';
import 'package:thread_clone/features/search/search_screen.dart';
import 'package:thread_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:thread_clone/features/main_navigation/widgets/new_threads.dart';
import 'package:thread_clone/features/user_profile/user_profile_screen.dart';

class MainNavScreen extends StatefulWidget {
  static const routeURL = '/';
  static const routeName = "main_navigation";

  final String tab;
  const MainNavScreen({super.key, required this.tab});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  final List<String> _tabs = [
    "",
    "search",
    "write",
    "activity",
    "profile",
  ];
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onWriteThreadsTap(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => const NewThread(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const PostScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const SearchScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const ActivityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavTab(
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              isSelected: _selectedIndex == 0,
              onTap: () => _onTap(0),
            ),
            NavTab(
              icon: FontAwesomeIcons.magnifyingGlass,
              selectedIcon: FontAwesomeIcons.magnifyingGlass,
              isSelected: _selectedIndex == 1,
              onTap: () => _onTap(1),
            ),
            NavTab(
              icon: FontAwesomeIcons.penToSquare,
              selectedIcon: FontAwesomeIcons.solidPenToSquare,
              isSelected: _selectedIndex == 2,
              onTap: () => _onWriteThreadsTap(context),
            ),
            NavTab(
              icon: FontAwesomeIcons.heart,
              selectedIcon: FontAwesomeIcons.solidHeart,
              isSelected: _selectedIndex == 3,
              onTap: () => _onTap(3),
            ),
            NavTab(
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              isSelected: _selectedIndex == 4,
              onTap: () => _onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
