import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String? text;
  final bool isDone;
  const TodoWidget({Key? key, this.text, required this.isDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: isDone ? const Color(0xFF7349FE) : Colors.transparent,
              border: isDone
                  ? null
                  : Border.all(
                      color: const Color(0xFF86829D),
                      width: 1.5,
                    ),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
          Text(
            text ??
                "(toDO sem nome)", //if the text is there we display it, if not them show
            style: TextStyle(
              color: isDone ? const Color(0xFF211551) : const Color(0xFF86829D),
              fontSize: 15.0,
              fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
