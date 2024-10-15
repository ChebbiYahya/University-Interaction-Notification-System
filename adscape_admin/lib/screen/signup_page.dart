import 'package:adscape_admin/models/user_model.dart';
import 'package:adscape_admin/screen/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../theme/constants.dart';
import 'package:email_validator/email_validator.dart' as a;
import 'package:form_field_validator/form_field_validator.dart';

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
  TextEditingController _passwordAdminController = TextEditingController();

  bool _passwordVisible = false;
  bool _passwordAdminVisible = false;
  bool satusSignUp = false;
  String password = "isiadmin";

  GlobalKey<FormState> formkeySignUp = GlobalKey<FormState>();
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
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
        child: Row(
          children: [
            if (_size.width > 600)
              Expanded(
                child: Container(
                  color: kBlueColor,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/images/logo_title_white_image.svg",
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/images/sign_up_image.svg"),
                      SizedBox(height: 20),
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
                              text: "Admin",
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
                          hintText: "Entrez votre Nom et prenom",
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
                                errorText:
                                    "* Veuillez saisir votre nom et prenom"),
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
                          prefixIcon: Icon(Icons.alternate_email_outlined),
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
                                "Veuillez saisir une adresse e-mail se terminant par '@isi.utm.tn'"),
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
                          prefixIcon: Icon(Icons.lock_person_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
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
                                  "Le mot de passe ne doit pas comporter plus de 15 caractères"),
                        ]),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                          controller: _passwordAdminController,
                          maxLines: 1,
                          obscureText: !_passwordAdminVisible,
                          decoration: InputDecoration(
                            hintText: "Enter admin password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.lock_person_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordAdminVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordAdminVisible =
                                      !_passwordAdminVisible;
                                });
                              },
                            ),
                          ),
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          validator: (value) {
                            if (value != password) {
                              return 'mot de passe admin invalid';
                            }
                            return null;
                          }),
                      SizedBox(height: 20),
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
                            onPressed: () async {
                              if (formkeySignUp.currentState!.validate()) {
                                final usr = UserModel(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  fullName: _nomController.text.trim(),
                                  role: "Admin",
                                );
                                satusSignUp = (await controller
                                    .createUserController(usr))!;
                                if (satusSignUp) {
                                  UserModel usr = (await controller
                                      .getUserDetailsController());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePages(usr: usr),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Quelque chose ne va pas")));
                                }
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}

class CustomEmailValidator extends TextFieldValidator {
  CustomEmailValidator(String errorText) : super(errorText);

  @override
  bool isValid(String? value) {
    return a.EmailValidator.validate(value!) && value.endsWith("@isi.utm.tn");
  }
}
