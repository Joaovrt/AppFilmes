import 'package:app_filmes/application/modules/favorites/favorites_bindings.dart';
import 'package:app_filmes/application/modules/favorites/favorites_page.dart';
import 'package:app_filmes/application/modules/home/home_controller.dart';
import 'package:app_filmes/application/modules/movies/movies_bindings.dart';
import 'package:app_filmes/application/modules/movies/movies_page.dart';
import 'package:app_filmes/application/ui/filmes_app_icons_icons.dart';
import 'package:app_filmes/application/ui/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          onTap: controller.goToPage,
          currentIndex: controller.pageIndex,
          selectedItemColor: context.themeRed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Filmes'),
            BottomNavigationBarItem(
                icon: Icon(FilmesAppIcons.heart_empty), label: 'Favoritos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout_outlined), label: 'Sair'),
          ],
        );
      }),
      body: Navigator(
        initialRoute: '/movies',
        key: Get.nestedKey(HomeController.NAVIGATOR_KEY),
        onGenerateRoute: (settings) {
          if (settings.name == '/movies') {
            return GetPageRoute(settings: settings, page: () => MoviesPage(), binding: MoviesBindings());
          }
          if (settings.name == '/favorites') {
            return GetPageRoute(
                settings: settings, page: () => FavoritesPage(), binding: FavoritesBindings());
          }
          return null;
        },
      ),
    );
  }
}
