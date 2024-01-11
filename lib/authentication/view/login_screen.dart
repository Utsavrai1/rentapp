import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentapp/authentication/bloc/auth_bloc.dart';
import 'package:rentapp/authentication/view/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> passwordVisible = ValueNotifier<bool>(false);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                            "Log In",
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
                            height: 20,
                          ),
                          ValueListenableBuilder(
                              valueListenable: passwordVisible,
                              builder: (_, value, __) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: !value,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          const Icon(Icons.password_rounded),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          passwordVisible.value =
                                              !passwordVisible.value;
                                        },
                                        icon: value
                                            ? Icon(
                                                Icons.visibility,
                                                color: Colors.grey.shade500,
                                              )
                                            : Icon(
                                                Icons.visibility_off,
                                                color: Colors.grey.shade500,
                                              ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      contentPadding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade700),
                                      hintText: "Password",
                                    ),
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.trim().isEmpty) {
                                          return 'Enter a valid password';
                                        } else if (value.trim().length < 6) {
                                          return 'Entered password is not strong';
                                        } else {
                                          return null;
                                        }
                                      } else {
                                        return 'Enter a valid password';
                                      }
                                    },
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 40, left: 40),
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        AttemptingLoginEvent(
                                            email: emailController.text,
                                            password: passwordController.text),
                                      );

                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return BlocConsumer<AuthBloc, AuthState>(
                                        listener: (context, state) async {
                                          if (state is LoginSuccessState) {
                                            context.pushNamed('Home');
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is LoginSuccessState) {
                                            return AlertDialog(
                                              title: const Text('Success!'),
                                              content: const Text(
                                                  'Logged in successfully'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      context.pop(),
                                                  child: const Text('Great!'),
                                                ),
                                              ],
                                            );
                                          } else if (state is LoginFailState) {
                                            return AlertDialog(
                                              title: const Text('Failure'),
                                              content: Text(state.error),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      context.pop(),
                                                  child: const Text('Okay'),
                                                ),
                                              ],
                                            );
                                          } else if (state is LoggingInState) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.login_rounded,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Forgot',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Password?',
                                    style: const TextStyle(
                                        color: Colors.deepPurple, fontSize: 16),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Sign up',
                                    style: const TextStyle(
                                        color: Colors.deepPurple, fontSize: 16),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen(),
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
