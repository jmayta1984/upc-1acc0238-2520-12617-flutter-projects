import 'package:easy_travel/features/auth/presentation/login_page.dart';
import 'package:easy_travel/core/ui/theme.dart';
import 'package:easy_travel/features/home/presentation/blocs/destinations_bloc.dart';
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
    return  BlocProvider(
      create: (context) => DestinationsBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.light(),
        darkTheme: theme.dark(),
        home: Scaffold(
          body: SafeArea(child: LoginPage()),
        ),
      ),
    );
  }
}
