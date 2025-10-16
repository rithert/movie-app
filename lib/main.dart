import 'package:app_movie/core/config/env.config.dart';
import 'package:app_movie/features/movie/presentation/cubit/movies_cubit.dart';
import 'package:app_movie/features/movie/presentation/pages/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar variables de entorno
  await EnvConfig.init();

  // Inicializar dependencias
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      home: BlocProvider(
        create: (context) => di.sl<MoviesCubit>()..loadMovies(),
        child: const MoviesPage(),
      ),
    );
  }
}
