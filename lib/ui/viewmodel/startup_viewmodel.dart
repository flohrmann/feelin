import 'package:feelin/ui/viewmodel/base_viewmodel.dart';
import 'package:get/get.dart';

class StartUpViewModel extends BaseViewModel {
  void onModelReady() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    await Get.offAllNamed('/home');
  }
}