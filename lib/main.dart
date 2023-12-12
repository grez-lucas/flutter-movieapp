import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_providers.dart';
import 'screens/app_screens.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      // Create is what must be used to create the first instance of the provider
      // Make sure lazy is false to that the provider is created when the app starts
      ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Peliculas',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'details': (_) => const DetailsScreen(),
        },
        theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
          color: Colors.indigo,
          centerTitle: true,
          elevation: 0,
        )));
  }
}
