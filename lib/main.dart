import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/data/adapters/car_adapter.dart';
import 'package:hive_example/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('myBoxOne');
  await Hive.openBox('myBoxTwo');
  Hive.registerAdapter(CarAdapter());
  await Hive.openBox('cars');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const HomeScreen(),
    );
  }
}
