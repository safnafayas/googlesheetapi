import 'package:flutter/material.dart';
import 'package:googlesheetcrud/services/servicefile.dart';
import 'package:googlesheetcrud/views/AddHeroes.dart';

import 'model/usermodel.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AddPage(
        onSavedUser: (user) async {
          await UserSheetsApi.insert(user.toJson());
        },
      ),
    );
  }
}

