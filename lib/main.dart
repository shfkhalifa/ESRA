import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'api/userApiClient.dart';
import 'bloc/authenticationBloc/authentication.dart';
import 'bloc/authenticationBloc/authenticationBloc.dart';
import 'bloc/faqBloc/faq.dart';
import 'bloc/manageChildrenBloc/mangeChildren.dart';
import 'pages/authentication/authenticationPage.dart';
import 'pages/home/homePage.dart';
import 'pages/splash/splashPage.dart';
import 'repositories/predictionRepository.dart';
import 'repositories/userRepository.dart';
import 'utils/blocDelegate.dart';
import 'utils/constants.dart';
import 'utils/routeGenerator.dart';

import 'package:esra/localization/demo_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/language_constants.dart';

// void main() => runApp(ESRAApp());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = AppBlocDelegate();
  UserApiClient.httpClient = http.Client();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (BuildContext context) => UserRepository(),
        ),
        RepositoryProvider<PredictionRepository>(
          create: (BuildContext context) => PredictionRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(context.repository<UserRepository>())
                  ..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) =>
                ManagechildrenBloc(context.repository<UserRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                FaqBloc(context.repository<UserRepository>())..add(LoadFaq()),
          ),
        ],
        child: ESRAApp(),
      ),
    ),
  );
}

class ESRAApp extends StatefulWidget {
//i18n setLocale function
  static void setLocale(BuildContext context, Locale newLocale) {
    _ESRAAppState state = context.findAncestorStateOfType<_ESRAAppState>();
    state.setLocale(newLocale);
  }

  @override
  _ESRAAppState createState() => _ESRAAppState();
}

class _ESRAAppState extends State<ESRAApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    super.dispose();
    UserApiClient.closeClient();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.APP_TITLE,
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'HBKU',
      ),
      supportedLocales: [
        Locale("en", "US"),
        Locale("ar", "SA"),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      onGenerateRoute: RouteGenerator.generateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) return SplashScreen();
          if (state is Authenticated) {
            BlocProvider.of<ManagechildrenBloc>(context).add(GetChildren());
            return HomePage();
          }
          if (state is Unauthenticated) return AuthenticationPage();
        },
      ),
    );
  }
}
