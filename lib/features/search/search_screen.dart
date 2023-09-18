import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/features/main_navigation/widgets/search_list.dart';
import 'package:thread_clone/features/settings/view_models/darkmode_config_vm.dart';

const List<Map<String, dynamic>> _users = [
  {
    "username": "rjmithun",
    "name": "Mithun Raj",
    "profile_pic": "https://randomuser.me/api/portraits/men/11.jpg",
    "followers": 100,
  },
  {
    "username": "johndoe",
    "name": "John Doe",
    "profile_pic": "https://randomuser.me/api/portraits/men/1.jpg",
    "followers": 500,
  },
  {
    "username": "janedoe",
    "name": "Jane Doe",
    "profile_pic": "https://randomuser.me/api/portraits/women/1.jpg",
    "followers": 200,
  },
  {
    "username": "bobsmith",
    "name": "Bob Smith",
    "profile_pic": "https://randomuser.me/api/portraits/men/2.jpg",
    "followers": 300,
  },
  {
    "username": "alicesmith",
    "name": "Alice Smith",
    "profile_pic": "https://randomuser.me/api/portraits/women/2.jpg",
    "followers": 150,
  },
  {
    "username": "johngreen",
    "name": "John Green",
    "profile_pic": "https://randomuser.me/api/portraits/men/3.jpg",
    "followers": 400,
  },
  {
    "username": "janegreen",
    "name": "Jane Green",
    "profile_pic": "https://randomuser.me/api/portraits/women/3.jpg",
    "followers": 250,
  },
  {
    "username": "bobjohnson",
    "name": "Bob Johnson",
    "profile_pic": "https://randomuser.me/api/portraits/men/4.jpg",
    "followers": 350,
  },
  {
    "username": "alicejohnson",
    "name": "Alice Johnson",
    "profile_pic": "https://randomuser.me/api/portraits/women/4.jpg",
    "followers": 175,
  },
  {
    "username": "johnsmith",
    "name": "John Smith",
    "profile_pic": "https://randomuser.me/api/portraits/men/5.jpg",
    "followers": 450,
  },
];

class SearchScreen extends ConsumerWidget {
  static const routeURL = '/search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(darkModeConfigViewModelProvider).isDarkMode;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v10,
            CupertinoSearchTextField(
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
              placeholder: 'Search',
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final user = _users[index];
          return SearchList(user: user);
        },
      ),
    );
  }
}
