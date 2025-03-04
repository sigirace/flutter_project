import 'package:flutter/material.dart';
import 'package:flutter_project/common/widgets/button_widget.dart';
import 'package:flutter_project/common/widgets/text_field_widget.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/gaps.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'sign_up';
  static const routePath = '/sign_up';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 모든 포커스를 강제로 해제
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onCreateAccountButtonPressed() {
    // TODO: 회원가입 로직 추가
    print(emailController.text);
    print(passwordController.text);
  }

  void _onLoginButtonPressed() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('🔥 MOOD 🔥'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: Sizes.size50,
            right: Sizes.size50,
            top: Sizes.size100,
            bottom: Sizes.size50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Join!',
                    style: TextStyle(
                      fontSize: FontSize.fs20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v50,
                  TextFieldWidget(
                    hintText: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Gaps.v16,
                  TextFieldWidget(
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  Gaps.v24,
                  ButtonWidget(
                    text: 'Create Account',
                    onTap: _onCreateAccountButtonPressed,
                  ),
                ],
              ),
              ButtonWidget(
                text: 'Log in →',
                onTap: _onLoginButtonPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
