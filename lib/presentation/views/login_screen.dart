// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/data/data_providers/local/sharepref_prov.dart';
import 'package:test/logic/bloc/6Authentication/authentication_bloc.dart';
import 'package:test/utils/constants/globals.dart';
import 'package:toastification/toastification.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/data/repositories/supabase_repo.dart';
import 'package:test/presentation/router/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passVisiblity = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller_email = TextEditingController();
  TextEditingController controller_pass = TextEditingController();

//FIXME - MAKE It connected to SignUp
  // Map args = Map<String, Object>.from(ModalRoute.of(context)!.settings.arguments as Map);
  // controller_email.text = args['EMAIL'];
  // controller_pass.text = args['PASS'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: loginscr_scafkey,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(text: "You Don't Have an Account Yet? ", style: GoogleFonts.mPlusRounded1c(textStyle: const TextStyle(color: Colors.black54)), children: [
            TextSpan(
              text: "Sign Up Now!",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = () => Navigator.of(context).pushReplacementNamed(AppRouter.ROUTE_SIGNUP),
            ),
          ]),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Login",
                  style: GoogleFonts.mPlusRounded1c(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )),
            ),
            const SizedBox(height: 30),
            //Assign Email
            TextFormField(
              controller: controller_email,
              validator: (value) => (value == null || value.isEmpty || !value.contains('.com')) ? "Enter A Valid Email" : null,
              enableInteractiveSelection: true,
              selectionControls: MaterialTextSelectionControls(),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: GoogleFonts.mPlusRounded1c(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(20.0))),
            ),
            const SizedBox(height: 8),
            //Assign Password
            TextFormField(
              obscureText: passVisiblity,
              controller: controller_pass,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) => (value == null || value.length < 8) ? "Password is TOO Short!!" : null,
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: GoogleFonts.mPlusRounded1c(),
                  suffixIcon: IconButton(
                    onPressed: () => passVisiblity = !passVisiblity,
                    icon: Icon(passVisiblity ? Icons.visibility : Icons.visibility_off, color: Colors.black, size: 20),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(20.0))),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  AuthenticationBloc userAuthBloc = context.read<AuthenticationBloc>();
                  userAuthBloc.add(LoginAuthEvent(controller_email.text, controller_pass.text));
                }
              },
              style: ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05)),
                elevation: const MaterialStatePropertyAll(5),
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
              child: const Text("Login", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 8),
            Text("Forgot Password? ", style: GoogleFonts.mPlusRounded1c(textStyle: const TextStyle(color: Colors.grey))),
          ]),
        ),
      ),
    );
  }
}
