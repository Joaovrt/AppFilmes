import 'package:app_filmes/application/modules/movies/movies_controller.dart';
import 'package:app_filmes/application/ui/widgets/movies_card.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesGroup extends GetView<MoviesController> {
  final String title;
  final List<MovieModel> movies;
  const MoviesGroup({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 280,
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MoviesCard(movie: movies[index], favoriteCallback: ()=>controller.favoriteMovies(movies[index]),);
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
