import 'package:flutter/material.dart';
import 'package:news_app/consts/theme_data.dart';
import 'package:news_app/inner_screen/blog_details.dart';
import 'package:news_app/provider/bookmarks_provider.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/screen/home_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          //Notify about theme changes
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookmarksProvider(),
         ),
      ],
      child:
          Consumer<ThemeProvider>(builder: (context, themeChangeProvider, ch) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App Api',
          theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
          home:  HomeScreen(),
          routes: {
            NewsDetailsScreen.routeName: (ctx) => NewsDetailsScreen(),
           },
        );
      }),
    );
  }
}
