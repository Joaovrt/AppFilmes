import 'package:app_filmes/application/modules/movies/movies_controller.dart';
import 'package:app_filmes/repositories/genres/genres_repository.dart';
import 'package:app_filmes/repositories/genres/genres_repository_impl.dart';
import 'package:app_filmes/services/genres/genre_service_impl.dart';
import 'package:app_filmes/services/genres/genres_service.dart';
import 'package:get/get.dart';

class MoviesBindings implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut<GenresRepository>(()=>GenresRepositoryImpl(restclient: Get.find()));
    Get.lazyPut<GenresService>(()=>GenreServiceImpl(genreRepository: Get.find()));
    Get.lazyPut(()=>MoviesController(genresService: Get.find(),moviesService: Get.find(), authService: Get.find()));
  }
}