import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentapp/authentication/login_screen.dart';
import 'package:rentapp/authentication/password_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Colors.deepPurple.shade400,
          body: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      elevation: 20,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.deepPurple.shade400,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                            ),
                            child: TextFormField(
                              controller: nameController,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  contentPadding: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade700),
                                  hintText: "Name"),
                              validator: (value) {
                                if (value != null) {
                                  if (value.trim().isEmpty) {
                                    return 'Enter a name';
                                  } else {
                                    return null;
                                  }
                                } else {
                                  return 'Enter a name';
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                            ),
                            child: TextFormField(
                              controller: emailController,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.alternate_email_rounded),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  contentPadding: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade700),
                                  hintText: "Email-id"),
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ValueListenableBuilder(
                            valueListenable: isLoading,
                            builder: (_, value, __) {
                              return value
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.deepPurple.shade400,
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(
                                          right: 40, left: 40),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.deepPurple.shade400,
                                          Colors.deepPurple.shade400
                                        ]),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      width: 400,
                                      child: TextButton.icon(
                                        style: TextButton.styleFrom(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PasswordScreen(),
                                              ),
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.navigate_next,
                                          color: Colors.white,
                                        ),
                                        label: const Text(
                                          "Next",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Already have an account?',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Log in',
                                    style: const TextStyle(
                                        color: Colors.deepPurple, fontSize: 16),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                        );
                                      },
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
