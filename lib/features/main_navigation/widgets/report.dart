import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';

const List<String> report_reasons = [
  "I just don't like it",
  "It's unlawful content under NetzDG",
  "It's suspicious or spam",
  "Hate speech or symbols",
  "Nudity or sexual activity",
  "Violence or dangerous organizations",
];

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 45,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Why are you reporting this thread?",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Gaps.v12,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call local emergency services - don't wait.",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
              Gaps.v20,
              const Divider(),
              Column(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    for (var reason in report_reasons)
                      ListTile(
                        title: Text(
                          reason,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const FaIcon(
                          FontAwesomeIcons.angleRight,
                          color: Colors.black54,
                        ),
                      ),
                  ],
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
