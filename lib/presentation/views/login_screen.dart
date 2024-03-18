// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'package:test/utils/constants/enums.dart';
import 'package:test/utils/constants/globals.dart';
import 'package:test/presentation/router/app_router.dart';
import 'package:test/logic/bloc/6Authentication/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passVisiblity = true;
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
          text: TextSpan(text: AppLocalizations.of(context)!.prmpt_noaccount, style: GoogleFonts.mPlusRounded1c(textStyle: const TextStyle(color: Colors.black54)), children: [
            TextSpan(
              text: AppLocalizations.of(context)!.prmpt_signup,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = () => Navigator.of(context).pushReplacementNamed(AppRouter.ROUTE_SIGNUP),
            ),
          ]),
        ),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          //FIXME - Make History
          if (state.status == UserLoginStatus.READY || state.status == UserLoginStatus.LOGGEDOUT) {
            var importedLoginHistory = state.history!.last.split('|');
            var importedEmail = importedLoginHistory[0];
            var importedPass = importedLoginHistory[1];
            controller_email.text = importedEmail;
            controller_pass.text = importedPass;
          }
        },
        builder: (context, state) {
          return (state.status == UserLoginStatus.IDLE || state.status == UserLoginStatus.LOGGEDIN)
              ? const Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(AppLocalizations.of(context)!.login,
                            style: GoogleFonts.mPlusRounded1c(
                              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                            )),
                      ),
                      const SizedBox(height: 30),
                      //Assign Email
                      TextFormField(
                        controller: controller_email,
                        validator: (value) => (value == null || value.isEmpty || !value.contains('.com')) ? AppLocalizations.of(context)!.val_email : null,
                        enableInteractiveSelection: true,
                        selectionControls: MaterialTextSelectionControls(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.email,
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
                        validator: (value) => (value == null || value.length < 8) ? AppLocalizations.of(context)!.val_pass : null,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.pass,
                            hintStyle: GoogleFonts.mPlusRounded1c(),
                            suffixIcon: controller_pass.text.length > 0
                                ? IconButton(
                                    onPressed: () => controller_pass.clear(),
                                    icon: const Icon(Icons.cancel, color: Colors.black, size: 20),
                                  )
                                : null,
                            // suffixIcon: IconButton(
                            //   onPressed: () {
                            //     //FIXME - passVisiblity wont get updated after change. Needs a setState but I don't want to use it with bloc. Open for any suggestions.
                            //     passVisiblity = !passVisiblity;
                            //   },
                            //   icon: Icon(passVisiblity ? Icons.visibility : Icons.visibility_off, color: Colors.black, size: 20),
                            // ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(20.0))),
                      ),
                      const SizedBox(height: 15),
                      OutlinedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            AuthenticationBloc userAuthBloc = context.read<AuthenticationBloc>();
                            userAuthBloc.emit(state.copyWith(newStatus: UserLoginStatus.IDLE));
                            userAuthBloc.add(LoginAuthEvent(controller_email.text, controller_pass.text));
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05)),
                          elevation: const MaterialStatePropertyAll(5),
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).buttonTheme.colorScheme!.primary),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        ),
                        child: Text(AppLocalizations.of(context)!.login, style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 8),
                      Text(AppLocalizations.of(context)!.prmpt_frgtpass, style: GoogleFonts.mPlusRounded1c(textStyle: const TextStyle(color: Colors.grey))),
                    ]),
                  ),
                );
        },
      ),
    );
  }
}
