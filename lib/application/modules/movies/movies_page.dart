import 'package:app_filmes/application/modules/movies/movies_controller.dart';
import 'package:app_filmes/application/modules/movies/widgets/movies_filters.dart';
import 'package:app_filmes/application/modules/movies/widgets/movies_group.dart';
import 'package:app_filmes/application/modules/movies/widgets/movies_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
    
class MoviesPage extends GetView<MoviesController> {

  const MoviesPage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: ListView(
        children: [
          MoviesHeader(),
          MoviesFilters(),
          MoviesGroup(title: 'Mais populares',movies: controller.popularMovies,),
          MoviesGroup(title: 'Top Filmes',movies: controller.topRatedMovies),
        ],
      ),
    );
  }
}