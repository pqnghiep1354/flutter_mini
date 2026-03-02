import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/name_provider.dart';
import 'Myapp.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NameProvider(),
      child: const MyApp(),
    ),
  );
}
