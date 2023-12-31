import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm/view/login/widgets/input_email_widget.dart';
import 'package:mvvm/view/login/widgets/input_password_widget.dart';
import 'package:mvvm/view/login/widgets/login_button_widget.dart';
import 'package:mvvm/view_models/controller/login/login_controller.dart';

import '../../res/color/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginVM = Get.put(LoginViewModel());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
          title: const Text(
            "Login Screen",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login Now!",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              const SizedBox(
                height: 80,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputEmailWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    InputPasswordWidget(),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              LoginButton(
                formKey: _formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
