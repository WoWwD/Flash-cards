import 'package:flash_cards/presentation/provider/card_provider_model.dart';
import 'package:flash_cards/presentation/provider/dictionary_provider_model.dart';
import 'package:flash_cards/presentation/provider/learning_provider_model.dart';
import 'package:flash_cards/presentation/provider/search_provider_model.dart';
import 'package:flash_cards/presentation/provider/settings_provider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flash_cards/services/di.dart' as di;
import 'app.dart';

Future<void> main() async {
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProviderModel>(create: (_) => di.getIt()..getValueTheme()),
        ChangeNotifierProvider<DictionaryProviderModel>(create: (_) => di.getIt()),
        ChangeNotifierProvider<CardProviderModel>(create: (_) => di.getIt()),
        ChangeNotifierProvider<SearchProviderModel>(create: (_) => di.getIt()),
        ChangeNotifierProvider<LearningProviderModel>(create: (_) => di.getIt())
      ],
      child: const App()
    )
  );
}