// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/data/data_providers/local/sharepref_prov.dart';
import 'package:test/data/repositories/supabase_repo.dart';
import 'package:test/presentation/router/app_router.dart';
import 'package:test/utils/constants/globals.dart';
import 'package:toastification/toastification.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SupaRecipeRepository repo = SupaRecipeRepository();
  AuthenticationBloc() : super(AuthenticationIdle()) {
    on<InitAuthEvent>((event, emit) async {
      print("object");
      var loginValue = await ShrPrefProvider().getStrList('LOGIN-KEY+VALUE') ?? [];
      print("LOGIN VALUE: $loginValue");
      emit(AuthenticationIdle());
    });

    on<LoginAuthEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      var authRes = await repo.login(event.email, event.pass);
      if (authRes.runtimeType == User && authRes.aud == 'authenticated') {
        var loginValue = await ShrPrefProvider().getStrList('LOGIN-KEY+VALUE') ?? [];
        var newLoginValue = event.email + "|" + event.pass;
        if (!loginValue.contains(newLoginValue)) loginValue.add(newLoginValue);
        await ShrPrefProvider().setStrList('LOGIN-KEY+VALUE', loginValue);

        toastification.show(
          context: loginscr_scafkey.currentState!.context,
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          title: 'Login Successful',
          description: 'Signed in as ${event.email}',
          alignment: Alignment.bottomCenter,
          autoCloseDuration: const Duration(seconds: 4),
          animationBuilder: (context, animation, alignment, child) => FadeTransition(opacity: animation, child: child),
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: highModeShadow,
        );

        Navigator.of(loginscr_scafkey.currentState!.context).pushReplacementNamed(AppRouter.ROUTE_HOME);
      } else {
        //FIXME - Modify The Snackbar - Factorize it
        SnackBar prompt = SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.orange.shade600, width: 2)), child: Text(authRes.toString())));
        ScaffoldMessenger.of(loginscr_scafkey.currentState!.context).showSnackBar(prompt);
      }
    });
  }
}
