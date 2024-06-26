import 'package:flutter/material.dart';
import 'package:guitar_mentor/src/helpers/theme_colors.dart';
import 'music_controller.dart';

class MusicPage extends StatefulWidget {
  final String title;
  final String author;

  MusicPage({required this.title, required this.author});

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final MusicController _musicController = MusicController();
  final ScrollController _scrollController = ScrollController();
  String _song = '';
  List<String> _chords = [];
  bool _isLoading = false;
  String _selectedChord = '';

  void _fetchSong() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final songDetails = await _musicController.fetchSong(widget.title, widget.author);
      setState(() {
        _song = songDetails['songDetails']['song'];
        _chords = List<String>.from(songDetails['songDetails']['chords']);
      });
    } catch (e) {
      setState(() {
        _song = 'Failed to load song: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSong();
  }

  void _showChordImage(String chord) {
    setState(() {
      _selectedChord = chord;
    });

    // Wait for the UI to update and then scroll down
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} by ${widget.author}'),
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _song,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _chords.map((chord) {
                  return ElevatedButton(
                    onPressed: () => _showChordImage(chord),
                    child: Text(chord),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.primaryColor,
                    ),
                  );
                }).toList(),
              ),
              if (_selectedChord.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'Chord: $_selectedChord',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Image.asset('images/$_selectedChord.png'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
