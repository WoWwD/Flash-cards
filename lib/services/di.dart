import 'package:flash_cards/data/local_data/collection_local_data.dart';
import 'package:flash_cards/domain/repositories/local_repositories/collection_local_repository.dart';
import 'package:get_it/get_it.dart';
import '../presentation/provider/settings_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final CollectionLocalData collectionLocalData = CollectionLocalData();
  final CollectionLocalRepository collectionLocalRepository = CollectionLocalRepository(collectionLocalData);

  //#region Data

  getIt.registerLazySingleton(() => collectionLocalData);

  //#endregion

  //region Repository
  getIt.registerLazySingleton(() => collectionLocalRepository);

  //#endregion

  //region Provider

  getIt.registerLazySingleton(() => SettingsModel());

  //#endregion
}