import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:test/presentation/router/app_router.dart';

class SpashScreen extends StatelessWidget {
  const SpashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SelectableLinkify(text: "Gifs Made by https://storyset.com/book", textAlign: TextAlign.center),
      ),
      body: FlutterSplashScreen.gif(
        backgroundColor: Colors.white,
        gifPath: "assets/gifs/RecipeAppLogo.gif",
        gifWidth: MediaQuery.of(context).size.width,
        gifHeight: MediaQuery.of(context).size.height,
        asyncNavigationCallback: () async {
          await Future.delayed(const Duration(seconds: 3));
          if (context.mounted) {
            Navigator.of(context).pushNamed(AppRouter.ROUTE_LOGIN);
          }
          //  var response = await userRepository.getUserData();
          // if(response.status == 200 && response.data.isAuthenticated){
          //  GoRouter.of(context).goNamed("home");
          // }
          // else{
          //     // GoRouter.of(context).goNamed("/");
          // }
        },
      ),
    );
  }
}
