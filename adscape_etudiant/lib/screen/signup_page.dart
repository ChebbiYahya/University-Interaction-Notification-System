import 'package:adscape_etudiant/controllers/auth_controller.dart';
import 'package:adscape_etudiant/screen/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../theme/constants.dart';
import 'package:email_validator/email_validator.dart' as a;

import 'home_pages.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();

  bool _isChecked = false;
  bool _passwordVisible = false;
  bool satusSignUp = false;

  GlobalKey<FormState> formkeySignUp = GlobalKey<FormState>();
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Center(
            child: SvgPicture.asset(
              "assets/images/logo_title_image.svg",
              height: 40,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: formkeySignUp,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/sign_up_image.svg"),
                        SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Bienvenue sur \nl'Application ",
                              ),
                              TextSpan(
                                text: "Etudiant",
                                style: TextStyle(
                                  color: kBlueColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Créer un compte",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _nomController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Entrez votre Nom",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          validator: MultiValidator(
                            [
                              RequiredValidator(
                                  errorText: "* Veuillez saisir votre nom"),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _prenomController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Entrez votre prenom",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          validator: MultiValidator(
                            [
                              RequiredValidator(
                                  errorText: "* Veuillez saisir votre prenom"),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Entrez votre adresse e-mail",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          validator: MultiValidator(
                            [
                              RequiredValidator(
                                  errorText:
                                      "* Veuillez saisir votre adresse e-mail"),
                              EmailValidator(
                                  errorText:
                                      "Veuillez saisir une adresse e-mail valide"),
                              CustomEmailValidator(
                                  "Veuillez saisir une adresse e-mail se terminant par '@etudiant-isi.utm.tn'"),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          maxLines: 1,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            hintText: "Entrez votre mot de passe",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    "* Veuillez saisir votre mot de passe"),
                            MinLengthValidator(6,
                                errorText:
                                    "Le mot de passe doit comporter au moins 6 caractères"),
                            MaxLengthValidator(15,
                                errorText:
                                    "Le mot de passe ne doit pas comporter plus de 15 caractères")
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          _isChecked = newValue!;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headline5!,
                          //.copyWith(fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Je suis d'accord avec ",
                            ),
                            TextSpan(
                              text: "les Conditions d'utilisation ",
                              style: TextStyle(
                                color: kBlueColor,
                              ),
                            ),
                            TextSpan(
                              text: "et ",
                            ),
                            TextSpan(
                              text: "Politique de confidentialité ",
                              style: TextStyle(
                                color: kBlueColor,
                              ),
                            ),
                            TextSpan(
                              text: "de medConnect.",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: kBlueColor,
                      ),
                      onPressed: _isChecked
                          ? () async {
                              if (formkeySignUp.currentState!.validate()) {
                                final user = UserModel(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  fullName:
                                      "${_nomController.text.trim()} ${_prenomController.text.trim()}",
                                  role: "Etudiant",
                                );
                                satusSignUp = (await controller
                                    .createUserController(user))!;
                                if (satusSignUp) {
                                  UserModel usr = (await controller
                                      .getUserDetailsController())!;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePages(usr: usr),
                                    ),
                                  );
                                }
                              }
                            }
                          : null,
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: kWhiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                    );
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline5!,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Déjà inscrit ? ",
                        ),
                        TextSpan(
                          text: "Connectez-vous ici",
                          style: TextStyle(
                              color: kBlueColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomEmailValidator extends TextFieldValidator {
  CustomEmailValidator(String errorText) : super(errorText);

  @override
  bool isValid(String? value) {
    return a.EmailValidator.validate(value!) &&
        value.endsWith("@etudiant-isi.utm.tn");
  }
}
