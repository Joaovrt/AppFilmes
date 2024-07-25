import 'package:app_filmes/application/modules/favorites/favorites_controller.dart';
import 'package:app_filmes/application/ui/widgets/movies_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Favoritos'),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: SizedBox(
              width: Get.width,
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                children: controller.movies
                    .map((element) =>
                        MoviesCard(movie: element, favoriteCallback: ()=>controller.removeFavorite(element)))
                    .toList(),
              ),
            ),
          );
        }));
  }
}
