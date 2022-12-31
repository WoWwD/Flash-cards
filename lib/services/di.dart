import 'package:flash_cards/data/local_data/card_local_data.dart';
import 'package:flash_cards/data/local_data/dictionary_local_data.dart';
import 'package:flash_cards/domain/repositories/local_repositories/card_local_repository.dart';
import 'package:flash_cards/domain/repositories/local_repositories/dictionary_local_repository.dart';
import 'package:flash_cards/presentation/provider/learning_provider_model.dart';
import 'package:get_it/get_it.dart';
import '../presentation/provider/card_provider_model.dart';
import '../presentation/provider/dictionary_provider_model.dart';
import '../presentation/provider/search_provider_model.dart';
import '../presentation/provider/settings_provider_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final DictionaryLocalData dictionaryLocalData = DictionaryLocalData();
  final DictionaryLocalRepository dictionaryLocalRepository = DictionaryLocalRepository(dictionaryLocalData);

  final CardLocalData cardLocalData = CardLocalData();
  final CardLocalRepository cardLocalRepository = CardLocalRepository(cardLocalData);
  //#region Data

  getIt.registerLazySingleton(() => dictionaryLocalData);
  getIt.registerLazySingleton(() => cardLocalData);

  //#endregion

  //region Repository
  getIt.registerLazySingleton(() => dictionaryLocalRepository);
  getIt.registerLazySingleton(() => cardLocalRepository);

  //#endregion

  //region Provider

  getIt.registerLazySingleton(() => SettingsProviderModel());
  getIt.registerLazySingleton(() => DictionaryProviderModel(dictionaryLocalRepository: dictionaryLocalRepository));
  getIt.registerLazySingleton(() => CardProviderModel(cardLocalRepository: cardLocalRepository));
  getIt.registerLazySingleton(() => SearchProviderModel(
    cardLocalRepository: cardLocalRepository,
    dictionaryLocalRepository: dictionaryLocalRepository
  ));
  getIt.registerFactory(() => LearningProviderModel());

  //#endregion
}