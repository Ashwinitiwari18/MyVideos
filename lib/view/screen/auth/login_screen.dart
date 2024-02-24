import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/view/screen/auth/forgot_password.dart';
import 'package:getx_tutorial/view/screen/auth/register_screen.dart';
import 'package:getx_tutorial/view/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Login Screen'))),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My Videos',
                style: TextStyle(
                    color: buttonColor,
                    fontSize: 35,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Log In',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                    labelText: "Email",
                    controller: _emailController,
                    icon: Icons.email),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  labelText: "Password",
                  controller: _passwordController,
                  icon: Icons.lock,
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: InkWell(
                  onTap: () {
                    authController.loginUser(
                        _emailController.text, _passwordController.text);
                  },
                  child: const Center(
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have account? ',
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                      onTap: () {
                        Get.offAll(() => RegisterScreen());
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: buttonColor, fontSize: 20),
                      )),
                ],
              ),
              const SizedBox(height: 15,),
              InkWell(
                onTap: () => Get.to(ForgotPasswordScreen()),
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
