import 'package:app_filmes/application/ui/loader/loader_mixing.dart';
import 'package:app_filmes/application/ui/messages/messages_mixing.dart';
import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:app_filmes/services/movies/movies_service.dart';
import 'package:get/get.dart';

class MovieDetailController extends GetxController
    with LoaderMixing, MessagesMixing {
  final MoviesService _moviesService;

  var loading = false.obs;
  var message = Rxn<MessageModel>();
  var movie = Rxn<MovieDetailModel>();

  MovieDetailController({required MoviesService moviesService})
      : _moviesService = moviesService;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  @override
  void onReady() async {
    super.onReady();
    try {
      final movieId = Get.arguments;
      loading(true);
      final movieDetailData = await _moviesService.getDetail(movieId);
      movie.value = movieDetailData;
      
      loading(false);
    } catch (e) {
      print(e);
      loading(false);
      message(MessageModel.error(title: 'Erro!', message: 'Erro ao obter detalhes!'));
    }
  }
}
