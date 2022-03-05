import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_dev_lab1/bloc/loading_bloc.dart';
import 'package:mobile_dev_lab1/bloc/loading_observer.dart';
import 'package:mobile_dev_lab1/home.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: LoadingObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc(),
      child: MaterialApp(
          title: 'La frase diaria',
          home: const Home(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
          )),
    );
  }
}
