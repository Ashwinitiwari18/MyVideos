import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/view/screen/auth/login_screen.dart';
import 'package:getx_tutorial/view/widgets/text_input_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text('Register Screen'),
      )),
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
              const Text(
                'Register',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(
                        "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 50,
                    child: IconButton(
                      onPressed: () => authController.pickImage(),
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                    labelText: "UserName",
                    controller: _userController,
                    icon: Icons.person),
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
                    authController.registerUser(
                        _userController.text,
                        _emailController.text,
                        _passwordController.text,
                        authController.profilePhoto);
                  },
                  child: const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
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
                    'Already have account? ',
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                      onTap: () {
                        Get.offAll(() => LoginScreen());
                      },
                      child: Text(
                        "login",
                        style: TextStyle(color: buttonColor, fontSize: 20),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
