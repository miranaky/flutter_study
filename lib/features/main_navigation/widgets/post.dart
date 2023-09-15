import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/features/main_navigation/widgets/ellipsis.dart';
import 'package:thread_clone/features/main_navigation/widgets/reply_users.dart';
import 'package:thread_clone/features/main_navigation/widgets/user_image.dart';

class Post extends StatelessWidget {
  Post(
      {super.key,
      required this.userName,
      required this.userImageUrl,
      required this.postText,
      required this.minutesAgo,
      required this.replyUserImageUrl1,
      required this.replyUserImageUrl2,
      required this.replyUserImageUrl3,
      required this.replies,
      required this.likes,
      this.postImageList = const []});
  final String userName;
  final String userImageUrl;
  final String postText;
  List<String> postImageList;
  final String replyUserImageUrl1;
  final String replyUserImageUrl2;
  final String replyUserImageUrl3;
  final String minutesAgo;
  final int replies;
  final int likes;

  void _onEllipsisTap(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => const Ellipsis(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    UserImage(
                      imageUrl: userImageUrl,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Gaps.h4,
                              const FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                size: 16,
                                color: Color.fromRGBO(65, 147, 239, 1),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Opacity(
                                opacity: 0.7,
                                child: Text(
                                  minutesAgo,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Gaps.h8,
                              GestureDetector(
                                onTap: () => _onEllipsisTap(context),
                                child: const FaIcon(
                                  FontAwesomeIcons.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gaps.v10,
                      Column(
                        children: [
                          Text(
                            postText,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Gaps.v10,
                          postImageList.isNotEmpty
                              ? Container(
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      aspectRatio: 2.0,
                                      enlargeCenterPage: true,
                                    ),
                                    items: postImageList
                                        .map((item) => Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                              child: Center(
                                                child: Image.network(
                                                  item,
                                                  fit: BoxFit.cover,
                                                  width: 1000,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      Gaps.v10,
                      const Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                          ),
                          Gaps.h20,
                          FaIcon(
                            FontAwesomeIcons.comment,
                          ),
                          Gaps.h20,
                          FaIcon(
                            FontAwesomeIcons.retweet,
                          ),
                          Gaps.h20,
                          FaIcon(
                            FontAwesomeIcons.paperPlane,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Gaps.v12,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: ReplyUsers(
                    imageUrl1: replyUserImageUrl1,
                    imageUrl2: replyUserImageUrl2,
                    imageUrl3: replyUserImageUrl3,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        replies.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Gaps.h2,
                    const Opacity(
                      opacity: 0.7,
                      child: Text(
                        "replies",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Gaps.h6,
                    const Opacity(
                      opacity: 0.7,
                      child: FaIcon(
                        FontAwesomeIcons.solidCircle,
                        size: 4,
                      ),
                    ),
                    Gaps.h6,
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        likes.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Gaps.h2,
                    const Opacity(
                      opacity: 0.7,
                      child: Text(
                        "likes",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
