import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:rentapp/authentication/bloc/auth_bloc.dart';
import 'package:rentapp/authentication/view/password_screen.dart';

class OtpScreen extends StatelessWidget {
  final String emailId;
  final String name;
  OtpScreen({super.key, required this.emailId, required this.name});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade500, width: 3),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final focusedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border:
          Border.all(color: const Color.fromRGBO(114, 178, 238, 1), width: 3),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  final errorPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.red.shade900, width: 3),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                            "Enter Otp",
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
                            child: Pinput(
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              errorPinTheme: errorPinTheme,
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return 'Enter Otp';
                                  } else if (value.length != 6) {
                                    return 'Enter 6 digit otp';
                                  } else {
                                    return null;
                                  }
                                } else {
                                  return 'Enter Otp';
                                }
                              },
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              controller: otpController,
                            ),
                          ),
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
                              onPressed: () {
                                if (formKey.currentState!.validate() &&
                                    otpController.text.isNotEmpty &&
                                    otpController.text.length == 6) {
                                  context.read<AuthBloc>().add(
                                        VerifyingEmailEvent(
                                          email: emailId,
                                          otp: otpController.text,
                                        ),
                                      );
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return BlocConsumer<AuthBloc, AuthState>(
                                        listener: (context, state) async {
                                          if (state is VerifyMailSuccessState) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PasswordScreen(
                                                  emailId: emailId,
                                                  name: name,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is VerifyMailSuccessState) {
                                            return AlertDialog(
                                              title: const Text('Success!'),
                                              content: const Text(
                                                  'Email Verified Successfully'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      context.pop(),
                                                  child: const Text('Great!'),
                                                ),
                                              ],
                                            );
                                          } else if (state
                                              is VerifyMailFailState) {
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
                                          } else if (state is VerifyMailState) {
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
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
