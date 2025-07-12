import 'package:covid_19_tracker_dashboard/app_config/styles/styles.dart';
import 'package:covid_19_tracker_dashboard/features/dashboard/data/repository/covid_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/dashboard/bloc/bloc.dart';
import 'features/dashboard/view/tracker_dasboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeColors.themeMode;
  void setThemeMode(ThemeMode mode) => setState(() {
    _themeMode = mode;
    ThemeColors.saveThemeMode(mode);
  });
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CovidRepository>(
          create: (BuildContext context) => CovidRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CovidDataBloc>(
            create:
                (BuildContext context) => CovidDataBloc(
                  covidRepository: context.read<CovidRepository>(),
                ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: isTablet ? Size(601, 962) : Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,

          builder: (context, _) {
            final mediaQueryData = MediaQuery.of(context);
            return MaterialApp(
              title: 'COVID 19 Tracker',
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: _themeMode,
              home: MediaQuery(
                data: mediaQueryData.copyWith(
                  textScaler: TextScaler.linear(isTablet ? 0.8 : 1.0),
                ),
                child: CovidScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
