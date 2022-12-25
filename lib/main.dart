import 'package:flash_cards/presentation/provider/collection_cards_model.dart';
import 'package:flash_cards/presentation/provider/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flash_cards/services/di.dart' as di;
import 'app.dart';

Future<void> main() async {
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsModel>(create: (_) => di.getIt()..getValueTheme()),
        ChangeNotifierProvider<CollectionCardsModel>(create: (_) => di.getIt())
      ],
      child: const App()
    )
  );
}