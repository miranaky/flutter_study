import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/settings/view_models/darkmode_config_vm.dart';

const List<String> _tabs = [
  "All",
  "Replies",
  "Mentions",
  "Follows",
  "Verified",
  "Likes",
];
const List<Map<String, dynamic>> _activities = [
  {
    "username": "rjmithun",
    "Activity": "Mentioned you",
    "Mention":
        " Here's a therad you should follow if you love botany @kaengkaeng",
    "profile_pic": "https://randomuser.me/api/portraits/men/11.jpg",
    "tabs": "Mentions",
  },
  {
    "username": "johndoe",
    "Activity": "Followed you",
    "profile_pic": "https://randomuser.me/api/portraits/men/1.jpg",
    "tabs": "Follows",
  },
  {
    "username": "janedoe",
    "Activity": "Mentioned you",
    "Mention":
        " Here's a therad you should follow if you love botany @kaengkaeng",
    "profile_pic": "https://randomuser.me/api/portraits/women/1.jpg",
    "tabs": "Mentions",
  },
  {
    "username": "bobsmith",
    "Activity": "Mentioned you",
    "Mention":
        " Here's a therad you should follow if you love botany @kaengkaeng",
    "profile_pic": "https://randomuser.me/api/portraits/men/2.jpg",
    "tabs": "Mentions",
  },
  {
    "username": "alicesmith",
    "Activity": "Followed you",
    "profile_pic": "https://randomuser.me/api/portraits/women/2.jpg",
    "tabs": "Follows",
  },
  {
    "username": "johngreen",
    "Activity": "Mentioned you",
    "Mention":
        " Here's a therad you should follow if you love botany @kaengkaeng",
    "profile_pic": "https://randomuser.me/api/portraits/men/3.jpg",
    "tabs": "Mentions",
  },
  {
    "username": "janegreen",
    "Activity": "Followed you",
    "profile_pic": "https://randomuser.me/api/portraits/women/3.jpg",
    "tabs": "Follows",
  },
  {
    "username": "bobjohnson",
    "Activity": "Replyed to you",
    "profile_pic": "https://randomuser.me/api/portraits/men/4.jpg",
    "tabs": "Replies",
    "Reply": "I love this thread",
  },
  {
    "username": "alicejohnson",
    "Activity": "Followed you",
    "profile_pic": "https://randomuser.me/api/portraits/women/4.jpg",
    "tabs": "Follows",
  },
  {
    "username": "johnsmith",
    "Activity": "Replyed to you",
    "profile_pic": "https://randomuser.me/api/portraits/men/5.jpg",
    "tabs": "Replies",
    "Reply": "Here is my favourite store."
  },
];

class ActivityScreen extends ConsumerStatefulWidget {
  static const routeURL = '/activity';
  const ActivityScreen({super.key});

  @override
  ActivityScreenState createState() => ActivityScreenState();
}

class ActivityScreenState extends ConsumerState<ActivityScreen> {
  List<Map<String, dynamic>> _filteredActivities = [];

  @override
  void initState() {
    super.initState();
    _filteredActivities = List.from(_activities);
  }

  void _onTap(int index) {
    setState(() {
      if (index == 0) {
        _filteredActivities = _activities;
      } else {
        _filteredActivities = _activities
            .where((activity) => activity["tabs"] == _tabs[index])
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = ref.watch(darkModeConfigViewModelProvider).isDarkMode;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: false,
          title: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.size8,
            ),
            child: Text(
              "Activity",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            labelColor: isDark ? Colors.black : Colors.white,
            unselectedLabelColor: isDark ? Colors.white : Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.transparent,
            indicatorPadding: EdgeInsets.zero,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? Colors.grey.shade400 : Colors.black,
                width: 2,
              ),
              color: isDark ? Colors.grey.shade400 : Colors.black,
            ),
            isScrollable: true,
            onTap: _onTap,
            tabs: [
              for (var tab in _tabs)
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size12,
                      vertical: Sizes.size8,
                    ),
                    child: Text(
                      tab,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: _filteredActivities.length,
          itemBuilder: (context, index) {
            final activity = _filteredActivities[index];
            return ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              leading: CircleAvatar(
                radius: 23,
                backgroundImage: NetworkImage(activity["profile_pic"]),
              ),
              title: Row(
                children: [
                  Text(
                    activity["username"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.h4,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: 14,
                    color: Colors.blue.shade600,
                  )
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity["Activity"],
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                  Gaps.v5,
                  if (activity["tabs"] == 'Mentions')
                    Text(
                      "${activity['Mention']} ",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (activity["tabs"] == "Replies")
                    Text(
                      "${activity['Reply']} ",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              trailing: activity["tabs"] == 'Follows'
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        "Follow",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
