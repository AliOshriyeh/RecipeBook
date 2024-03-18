// ignore_for_file: non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'package:test/utils/constants/policies.dart';
import 'package:test/presentation/router/app_router.dart';
import 'package:test/data/repositories/supabase_repo.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passVisiblity = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller_email = TextEditingController();
  TextEditingController controller_phone = TextEditingController();
  TextEditingController controller_pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(text: AppLocalizations.of(context)!.prmpt_hasaccount, style: GoogleFonts.mPlusRounded1c(textStyle: const TextStyle(color: Colors.black54)), children: [
            TextSpan(text: AppLocalizations.of(context)!.prmpt_login, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue), recognizer: TapGestureRecognizer()..onTap = () => Navigator.of(context).pushReplacementNamed(AppRouter.ROUTE_LOGIN)),
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
              child: Text(AppLocalizations.of(context)!.signup,
                  style: GoogleFonts.mPlusRounded1c(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context)!.txt_fillform,
                  style: GoogleFonts.ephesis(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
                  )),
            ),
            const SizedBox(height: 20),
            //Assign Email
            TextFormField(
              controller: controller_email,
              validator: (value) => (value == null || value.isEmpty || !value.contains('.com')) ? AppLocalizations.of(context)!.val_email : null,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.email,
                  hintStyle: GoogleFonts.mPlusRounded1c(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(20.0))),
            ),
            const SizedBox(height: 8),
            //Assign Phone
            TextFormField(
              controller: controller_phone,
              validator: (value) => (value == null || value.isEmpty || value.length < 11) ? AppLocalizations.of(context)!.val_phone : null,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.phone,
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
                  final SupaRecipeRepository repo = SupaRecipeRepository();
                  var authRes = await repo.signup(controller_email.text, controller_pass.text, controller_phone.text);
                  if (authRes.runtimeType == User && authRes.aud == 'authenticated') {
                    Navigator.of(context).pushNamed(
                      AppRouter.ROUTE_LOGIN,
                      arguments: {'EMAIL': controller_email.text, 'PASS': controller_pass.text},
                    );
                  } else {
                    //FIXME - Modify The Snackbar - Factorize it
                    SnackBar prompt = SnackBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        content: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.deepOrange, width: 2),
                            ),
                            child: Text(authRes.toString())));

                    ScaffoldMessenger.of(context).showSnackBar(prompt);
                  }
                }
              },
              style: ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05)),
                elevation: const MaterialStatePropertyAll(5),
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
              child: Text(AppLocalizations.of(context)!.signup, style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 8),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(text: AppLocalizations.of(context)!.txt_accept + '\n', style: const TextStyle(color: Colors.grey), children: [
                //FIXME - Navigate to Term and conditions page
                TextSpan(
                  text: AppLocalizations.of(context)!.txt_term,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                        builder: (context) => const SingleChildScrollView(child: Padding(padding: EdgeInsets.all(20.0), child: Text(termNpolicy))),
                      );
                    },
                ),

                const TextSpan(text: " and "),
                TextSpan(
                  text: AppLocalizations.of(context)!.txt_policy,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                        builder: (context) => const Padding(padding: EdgeInsets.all(20.0), child: Text(termNpolicy)),
                      );
                    },
                )
              ]),
            ),
            const SizedBox(height: 50),
          ]),
        ),
      ),
    );
  }
}
