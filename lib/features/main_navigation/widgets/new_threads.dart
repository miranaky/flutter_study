import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/features/photo/take_photo_screen.dart';
import 'package:thread_clone/utils.dart';

class NewThread extends StatefulWidget {
  const NewThread({super.key});

  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  final TextEditingController _threadController = TextEditingController();
  String _thread = '';

  XFile? imageFile;

  void _onBodyTap() {
    FocusScope.of(context).unfocus();
  }

  Future<void> _onImageTap() async {
    imageFile = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const TakePhotoScreen()));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _threadController.addListener(() {
      setState(() {
        _thread = _threadController.text;
      });
    });
  }

  @override
  void dispose() {
    _threadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = isDarkMode(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      height: size.height * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("New thread"),
          toolbarHeight: 70,
          elevation: 0.5,
          shadowColor: Colors.black,
          leadingWidth: 100,
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: _onBodyTap,
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.fromBorderSide(
                                BorderSide(
                                  color: Colors.black38,
                                  width: 0.5,
                                ),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://file.osen.co.kr/article_thumb/2022/08/05/202208051014771929_62ec6f10a595b_300x.jpg',
                                ),
                              ),
                            ),
                          ),
                          Gaps.v10,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            color: Colors.grey.shade300,
                            width: 2,
                            height: 50,
                          ),
                          Gaps.v10,
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: const NetworkImage(
                              'https://file.osen.co.kr/article_thumb/2022/08/05/202208051014771929_62ec6f10a595b_300x.jpg',
                            ),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(
                                    0.5), // Set the color and opacity of the filter
                                backgroundBlendMode: BlendMode
                                    .srcATop, // Set the blend mode of the filter
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "__haerin",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: size.width - 100,
                            child: TextField(
                              controller: _threadController,
                              minLines: 1,
                              maxLines: 10,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                hintText: "Start a thread...",
                                hintStyle: TextStyle(
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _onImageTap,
                            icon: FaIcon(
                              FontAwesomeIcons.paperclip,
                              size: 20,
                              color: isDark ? Colors.grey : Colors.black54,
                            ),
                          ),
                          if (imageFile != null)
                            Container(
                              width: size.width - 100,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(imageFile!.path),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Opacity(
                        opacity: 0.6,
                        child: Text(
                          "Anyone can reply",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _thread.length > 1
                            ? () => Navigator.pop(context)
                            : () {},
                        child: Text(
                          "Post",
                          style: TextStyle(
                            color: _thread.length > 1
                                ? Colors.blue
                                : Colors.blue.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
