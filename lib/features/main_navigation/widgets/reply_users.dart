import 'package:flutter/material.dart';

class ReplyUsers extends StatelessWidget {
  const ReplyUsers(
      {super.key,
      required this.imageUrl1,
      required this.imageUrl2,
      required this.imageUrl3});
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 20,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl1),
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl2),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 35,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl3),
              ),
            ),
          ),
        )
      ],
    );
  }
}
