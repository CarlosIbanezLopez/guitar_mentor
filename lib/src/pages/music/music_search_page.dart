import 'package:flutter/material.dart';
import 'package:guitar_mentor/src/helpers/theme_colors.dart';
import '../../components/main_button.dart';
import 'music_page.dart';

class MusicSearchPage extends StatefulWidget {
  @override
  _MusicSearchPageState createState() => _MusicSearchPageState();
}

class _MusicSearchPageState extends State<MusicSearchPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  void _searchMusic() {
    final title = _titleController.text;
    final author = _authorController.text;

    if (title.isNotEmpty && author.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MusicPage(title: title, author: author),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both title and author')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Search Page'),
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Song Title',
                labelStyle: TextStyle(color: ThemeColors.primaryColor),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.primaryColor),
                ),
              ),
              style: TextStyle(
                color: ThemeColors.primaryColor,
                fontSize: 18,
              ),
              cursorColor: ThemeColors.primaryColor,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: 'Author',
                labelStyle: TextStyle(color: ThemeColors.primaryColor),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.primaryColor),
                ),
              ),
              style: TextStyle(
                color: ThemeColors.primaryColor,
                fontSize: 18,
              ),
              cursorColor: ThemeColors.primaryColor,
            ),
            const SizedBox(height: 32),
            MainButton(
              text: 'Search',
              onTap: _searchMusic,
            ),
          ],
        ),
      ),
    );
  }
}
