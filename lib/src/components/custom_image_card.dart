import 'package:flutter/material.dart';

import '../helpers/theme_colors.dart';

class CustomImageCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Function() onTap; // Nueva propiedad onTap

  CustomImageCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onTap, // Agregar onTap al constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Usar GestureDetector para detectar gestos
      onTap: onTap, // Llamar onTap cuando se toque el widget
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imagePath),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              stops: [0.3, 0.9],
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 0.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: TextStyle(color: ThemeColors.primaryColor, fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: Text(
                  description,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
