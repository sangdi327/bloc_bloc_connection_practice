import 'package:bloc_connection_practice2/bloc/license_bloc.dart';
import 'package:bloc_connection_practice2/bloc/product_bloc_copywith.dart';
import 'package:bloc_connection_practice2/repository/license_repository.dart';
import 'package:bloc_connection_practice2/repository/product_repository.dart';
import 'package:bloc_connection_practice2/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey)),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => ProductRepository()),
          RepositoryProvider(create: (context) => LicenseRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductBlocCopyWith(
                context.read<ProductRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => LicenseBloc(
                context.read<LicenseRepository>(),
              ),
            ),
          ],
          child: const App(),
        ),
      ),
    );
  }
}
