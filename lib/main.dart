import 'package:flutter/material.dart';
import 'package:netflix_clone/repositories/data_reposirory.dart';
import 'package:netflix_clone/ui/screens/loading_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: ((context) => DataRepository()), child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix clone ',
      theme: ThemeData( ),
      home: const LoadingScreen(),
    );
  }
}

