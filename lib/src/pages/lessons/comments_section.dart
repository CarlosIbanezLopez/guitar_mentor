import 'package:flutter/material.dart';
import 'package:guitar_mentor/src/helpers/theme_colors.dart';

class CommentsSection extends StatefulWidget {
  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final List<String> _comments = [];
  final TextEditingController _commentController = TextEditingController();

  void _addComment(String comment) {
    setState(() {
      _comments.add(comment);
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _comments[index],
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    iconColor: ThemeColors.primaryColor,
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeColors.primaryColor),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                color: ThemeColors.primaryColor,
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    _addComment(_commentController.text);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
