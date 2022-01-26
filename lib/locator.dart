import 'package:feelin/services/local_storage_service.dart';
import 'package:feelin/ui/viewmodel/home_viewmodel.dart';
import 'package:feelin/ui/viewmodel/settings_viewmodel.dart';
import 'package:feelin/ui/viewmodel/startup_viewmodel.dart';
import 'package:feelin/ui/viewmodel/statistic_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  var localStorage = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorage);

  locator.registerFactory(() => StartUpViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => StatisticViewModel());
  locator.registerFactory(() => SettingsViewModel());
}