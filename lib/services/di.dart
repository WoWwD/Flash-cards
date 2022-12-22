import 'package:get_it/get_it.dart';
import '../presentation/provider/settings_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //region Provider

  getIt.registerLazySingleton(() => SettingsModel());

  //#endregion
}