import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qstore/core/services/bloc_provider_service/bloc_providers.dart';
import 'package:qstore/features/home/presentation/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QStore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:MultiBlocProvider(
          providers: BlocProviders.getProviders(),
          child: HomeScreen())
    );
  }
}
