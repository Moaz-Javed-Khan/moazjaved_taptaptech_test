import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moazjaved_taptaptech_test/features/theme/cubit/theme_cubit.dart';

import 'core/app_router.dart';

void main() {
  runApp(BlocProvider(create: (context) => ThemeCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDark;

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Moaz Javed Khan Test',
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.teal)),
    );
  }
}
