import 'package:flutter/material.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/view/widgets/text_input_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                labelText: 'Email',
                controller: _emailController,
                icon: Icons.email,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => authController
                    .sendPassowrdResetEmail(_emailController.text),
                child: const Text(
                  "Send Reset password link",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
