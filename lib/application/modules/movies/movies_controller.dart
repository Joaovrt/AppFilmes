import 'package:app_filmes/application/auth/auth_service.dart';
import 'package:app_filmes/application/ui/messages/messages_mixing.dart';
import 'package:app_filmes/models/genre_model.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:app_filmes/services/genres/genres_service.dart';
import 'package:app_filmes/services/movies/movies_service.dart';
import 'package:get/get.dart';

class MoviesController extends GetxController with MessagesMixing {
  final GenresService _genresService;
  final MoviesService _moviesService;
  final AuthService _authService;
  final _message = Rxn<MessageModel>();
  final genres = <GenreModel>[].obs;
  final popularMovies = <MovieModel>[].obs;
  final topRatedMovies = <MovieModel>[].obs;
  var _popularMoviesOriginal = <MovieModel>[];
  var _topRatedMoviesOriginal = <MovieModel>[];
  final genreSelected = Rxn<GenreModel>();

  MoviesController(
      {required GenresService genresService,
      required MoviesService moviesService,
      required AuthService authService})
      : _genresService = genresService,
        _moviesService = moviesService,
        _authService = authService;

  @override
  void onInit() {
    messageListener(_message);
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    try {
      final genres = await _genresService.getGenres();
      this.genres.assignAll(genres);
      await getMovies();
    } catch (e) {
      print(e);
      _message(MessageModel.error(
          title: 'Erro', message: 'Erro ao buscar dados da pagina'));
    }
  }

  Future<void> getMovies() async {
    try {
      var popularMovies = await _moviesService.getPopularMovies();
      var topRatedMovies = await _moviesService.getTopRated();
      final favorites = await getFavorites();

      popularMovies = popularMovies.map((e){
        if(favorites.containsKey(e.id)){
          return e.copyWith(favorite: true);
        }
        else{
          return e.copyWith(favorite: false);
        }
      }).toList();

       topRatedMovies = topRatedMovies.map((e){
        if(favorites.containsKey(e.id)){
          return e.copyWith(favorite: true);
        }
        else{
          return e.copyWith(favorite: false);
        }
      }).toList();

      _popularMoviesOriginal = popularMovies;
      _topRatedMoviesOriginal = topRatedMovies;
      this.popularMovies.assignAll(popularMovies);
      this.topRatedMovies.assignAll(topRatedMovies);
    } catch (e) {
      print(e);
      _message(MessageModel.error(
          title: 'Erro', message: 'Erro ao buscar dados da pagina'));
    }
  }

  void filterByName(String title) {
    if (title.isEmpty) {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    } else {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });
      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    }
  }

  void filterByGenre(GenreModel? genreModel) {
    var genreFilter = genreModel;

    if (genreFilter?.id == genreSelected.value?.id) {
      genreFilter = null;
    }
    genreSelected.value = genreFilter;
    if (genreFilter != null) {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.genres.contains(genreFilter?.id);
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.genres.contains(genreFilter?.id);
      });
      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }
  }

  Future<void> favoriteMovies(MovieModel movie) async {
    final user = _authService.user;
    if (user != null) {
      var newMovie = movie.copyWith(favorite: !movie.favorite);
      await _moviesService.addOrRemoveFavorite(user.uid, newMovie);
      await getMovies();
    }
  }

  Future<Map<int, MovieModel>> getFavorites() async {
    final user = _authService.user;
    if (user != null) {
      final favorites = await _moviesService.getFavoritesMovies(user.uid);
      return <int, MovieModel> {
        for (var fav in  favorites) fav.id:fav
      };
    }
    else
      return {};
  }
}
