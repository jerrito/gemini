import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/src/authentication/presentation/bloc/user_bloc.dart';
import 'package:gemini/src/authentication/presentation/pages/landing_page.dart';
import 'package:gemini/src/authentication/presentation/provider/user_provider.dart';
import 'package:gemini/src/connection_page.dart';
import 'package:gemini/src/search_text/presentation/pages/search_page.dart';
import 'package:gemini/src/sql_database/database/text_database.dart';
import 'package:provider/provider.dart';

AppDatabase? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
   
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColorDark: Colors.white,
            useMaterial3: true,
            fontFamily: "Kodchasan"),
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: "Kodchasan"),
        home: const SearchTextPage(),
      ),
    );
  }
}
