import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_chef/res/app_colors.dart';
import 'package:star_chef/services/star_chef_service.dart';
import 'package:star_chef/view/dishes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          surfaceTint: AppColors.white,
        ),
        fontFamily: 'OpenSans',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32.0,
            color: AppColors.textTitle,
            fontWeight: FontWeight.w800,
          ),
          headlineMedium: TextStyle(
            fontSize: 22.0,
            color: AppColors.textTitle,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
          headlineSmall: TextStyle(
            fontSize: 17.0,
            color: AppColors.textTitle,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.12,
          ),
          bodySmall: TextStyle(
            fontSize: 8.0,
            color: AppColors.textTitle,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.16,
          ),
          bodyMedium: TextStyle(
            fontSize: 12.0,
            color: AppColors.textTitle,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 17.0,
            color: AppColors.textTitle,
            fontWeight: FontWeight.w600,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => StarChefService(),
          ),
        ],
        child: const DishesPage(),
      ),
    );
  }
}

