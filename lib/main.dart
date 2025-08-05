import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'core/models/message_history.dart';
import 'modules/home/home_page.dart';
import 'modules/result/result_page.dart';
import 'core/providers/message_provider.dart'; // Criado para gerenciar estados

import 'package:flutter/services.dart' show rootBundle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MessageHistoryAdapter());
  await Hive.openBox<MessageHistory>('historyBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final openAIKey = 'SUAAPI';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NutriScan AI',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: HomePage(apiKey: openAIKey),
      ),
    );
  }
}
