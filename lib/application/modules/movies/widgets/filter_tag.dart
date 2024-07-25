import 'package:app_filmes/application/ui/theme_extensions.dart';
import 'package:app_filmes/models/genre_model.dart';
import 'package:flutter/material.dart';

class FilterTag extends StatelessWidget {
  final GenreModel model;
  final bool selected;
  final VoidCallback onPressed;
  const FilterTag({super.key, required this.model, this.selected =false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        constraints: BoxConstraints(minHeight: 30, minWidth: 100),
        decoration: BoxDecoration(
            color: selected ? context.themeRed : Colors.black, borderRadius: BorderRadius.circular(30)),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            model.name,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
