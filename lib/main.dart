import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini/core/api/api_key.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/src/search_text/presentation/pages/search_page.dart';
import 'package:gemini/src/sql_database/database/text_database.dart';

AppDatabase? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: apiKey);
  initDependencies();
   database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
     useMaterial3: true,
        fontFamily: "Kodchasan"
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Kodchasan"
      ),
      home: const SearchTextPage(),
    );
  }
}
