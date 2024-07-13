import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  final String buttonName;
  final Color backgroundColor;
  final Color borderColor;
  final Function() function;

  const FollowButton(
      {super.key, required this.function, required this.buttonName, required this.backgroundColor, required this.borderColor});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: Container(

        decoration: BoxDecoration(

          color: widget.backgroundColor,
          border: Border.all(color: widget.borderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        width: 250,height: 27,
        child: Text(
          widget.buttonName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
