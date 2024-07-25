import 'package:app_filmes/application/bindings/application_bindings.dart';
import 'package:app_filmes/application/modules/home/home_module.dart';
import 'package:app_filmes/application/modules/login/login_module.dart';
import 'package:app_filmes/application/modules/movie_detail/movie_detail_module.dart';
import 'package:app_filmes/application/modules/splash/splash_module.dart';
import 'package:app_filmes/application/ui/filmes_app_ui_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  
  await remoteConfig.fetchAndActivate().then((bool success) {
    if (success) {
      print('Remote Config fetched and activated successfully');
      // Acesse um valor do Remote Config
      String exampleValue = remoteConfig.getString('example_key');
      print('Example Key: $exampleValue');
    } else {
      print('Remote Config fetch failed');
    }
  }).catchError((error) {
    print('Remote Config fetch error: $error');
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: FilmesAppUiConfig.title,
      initialBinding: ApplicationBindings(),
      theme: FilmesAppUiConfig.theme,
      getPages: [
        ...SplashModule().routers,
        ...LoginModule().routers,
        ...HomeModule().routers,
        ...MovieDetailModule().routers,
      ],
    );
  }
}
