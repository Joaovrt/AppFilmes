import 'package:app_filmes/application/ui/loader/loader_mixing.dart';
import 'package:app_filmes/application/ui/messages/messages_mixing.dart';
import 'package:app_filmes/services/login/login_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with LoaderMixing, MessagesMixing {
  final LoginService _loginService;
  final loading = false.obs;
  final message = Rxn<MessageModel>();

  LoginController({required LoginService loginService})
      : _loginService = loginService;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  Future<void> login() async {
    try {
      loading(true);
      await _loginService.login();
      loading(false);
      message(MessageModel.info(title: 'Sucesso!', message: 'Login efetuado com sucesso!'));
    } on Exception catch (e) {
      loading(false);
      print('--------------erro-----------------');
      print(e);
      print('-----------------------------------');
      message(MessageModel.error(title: 'Erro!', message: 'Erro ao realizar login!'));
    }
  }
}
