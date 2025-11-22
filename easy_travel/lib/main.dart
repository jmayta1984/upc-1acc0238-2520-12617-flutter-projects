import 'package:easy_travel/features/auth/data/auth_service.dart';
import 'package:easy_travel/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:easy_travel/features/auth/presentation/blocs/auth_event.dart';
import 'package:easy_travel/features/auth/presentation/blocs/login_bloc.dart';
import 'package:easy_travel/core/ui/theme.dart';
import 'package:easy_travel/features/auth/presentation/pages/splash_page.dart';
import 'package:easy_travel/features/favorites/blocs/favorites_bloc.dart';
import 'package:easy_travel/features/favorites/blocs/favorites_event.dart';
import 'package:easy_travel/features/home/data/destination_dao.dart';
import 'package:easy_travel/features/home/data/destination_repository_impl.dart';
import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/data/review_service.dart';
import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme(TextTheme());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            repository: DestinationRepositoryImpl(
              dao: DestinationDao(),
              service: DestinationService(),
            ),
          )..add(GetDestinationsByCategory(category: CategoryType.all)),
        ),
        BlocProvider(create: (context) => LoginBloc(service: AuthService())),
        BlocProvider(
          create: (context) =>
              FavoritesBloc(dao: DestinationDao())..add(GetAllFavorites()),
        ),
        BlocProvider(create: (context) => ReviewBloc(service: ReviewService())),
        BlocProvider(create: (context) => AuthBloc()..add(const AppStarted())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.light(),
        darkTheme: theme.dark(),
        home: const SplashPage(),
      ),
    );
  }
}
