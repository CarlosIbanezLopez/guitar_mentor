import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guitar_mentor/src/helpers/theme_colors.dart';
import 'package:guitar_mentor/src/pages/music/music_page.dart';
import 'package:guitar_mentor/src/pages/music/music_search_page.dart';
import '../../components/custom_image_card.dart'; // Importa CustomImageCard
import '../lessons/video_player_page.dart';
import '../login/login_page.dart';
import '../login/logout_controller.dart';
import 'lesson_controller.dart'; // Importa el LogoutController

class HomePage extends StatefulWidget {
  final String email;
  final String password;

  HomePage({required this.email, required this.password});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LogoutController _logoutController = LogoutController();
  final LessonController _lessonController = LessonController(); // Instancia de LessonController

  Future<void> _handleLogout() async {
    // Aquí puedes pasar el email y password del usuario logueado
    bool success = await _logoutController.logout(AutofillHints.email, AutofillHints.password, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzE5MzM5NDk2LCJleHAiOjE3MTk0MjU4OTZ9.4jjCieDsmOPg0RyZgwv0CYbtLSuUOGfOyDriX1tkRew');

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed. Please try again.')),
      );
    }
  }

  Future<List<CustomImageCard>> _fetchLessons() async {
    try {
      List<CustomImageCard> lessonsCards = [];
      List<dynamic> lessonsData = await _lessonController.lections();

      for (var lesson in lessonsData) {
        lessonsCards.add(CustomImageCard(
          imagePath: lesson['imagepath'],
          title: lesson['title'],
          description: lesson['content'],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerPage(videoUrl: lesson['url']),
              ),
            );
          },
        ));
      }

      return lessonsCards;
    } catch (e) {
      print('Error fetching lessons: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.textFieldBgColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.scaffoldBbColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: ThemeColors.primaryColor,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      drawer: Drawer(
        child: Container(
          color: ThemeColors.scaffoldBbColor,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: ThemeColors.scaffoldBbColor,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: ThemeColors.primaryColor,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: ThemeColors.primaryColor),
                title: Text('Home', style: TextStyle(color: ThemeColors.primaryColor)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(Icons.music_note , color: ThemeColors.primaryColor),
                title: Text('Canciones', style: TextStyle(color: ThemeColors.primaryColor)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicSearchPage(),
                  ),
                ),
              ),
              Spacer(),
              ListTile(
                leading: Icon(Icons.logout, color: ThemeColors.primaryColor),
                title: Text('Logout', style: TextStyle(color: ThemeColors.primaryColor)),
                onTap: _handleLogout,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ThemeColors.scaffoldBbColor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'GuitarMentor',
                      style: TextStyle(
                          color: ThemeColors.primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ThemeColors.textFieldBgColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: ThemeColors.primaryColor,
                            ),
                            hintText: "Search you're looking for",
                            hintStyle: TextStyle(
                                color: ThemeColors.primaryColor, fontSize: 15)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Lecciones',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FutureBuilder<List<CustomImageCard>>(
                      future: _fetchLessons(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error fetching lessons');
                        } else if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data!,
                          );
                        } else {
                          return Text('No data available');
                        }
                      },
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
