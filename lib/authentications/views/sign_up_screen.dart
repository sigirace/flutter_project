import 'package:flutter/material.dart';
import 'package:flutter_project/authentications/view_models/sign_up_view_model.dart';
import 'package:flutter_project/authentications/views/widgets/button_widget.dart';
import 'package:flutter_project/authentications/views/widgets/text_form_field_widget.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/gaps.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/utils/validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = 'sign_up';
  static const routePath = '/sign_up';

  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onCreateAccountButtonPressed() {
    if (_formKey.currentState!.validate()) {
      final userData = ref.read(signUpForm);
      ref.read(signUpForm.notifier).state = userData.copyWith(
        email: _emailController.text,
        password: _passwordController.text,
      );
      ref.read(signUpProvider.notifier).signUp(context);
    }
  }

  void _onLoginButtonPressed() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(signUpProvider).isLoading;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(
            left: Width.w50,
            right: Width.w50,
            top: Height.h100 * 2,
            bottom: Height.h50,
          ),
          child: Column(
            children: [
              Container(
                height: Height.h100 * 1.5,
                alignment: Alignment.center,
                child: Text(
                  "정보를 입력해주세요",
                  style: TextStyle(
                    fontSize: FontSize.fs20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormFieldWidget(
                            hintText: 'Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                          ),
                          Gaps.v16,
                          TextFormFieldWidget(
                            hintText: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                            validator: validatePassword,
                          ),
                        ],
                      ),
                    ),
                    Gaps.v24,
                    ButtonWidget(
                      text: isLoading ? '가입 요청중...' : '가입하기',
                      onTap: _onCreateAccountButtonPressed,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _onLoginButtonPressed,
                child: Text(
                  '계정이 있으신가요?',
                  style: TextStyle(
                    fontSize: FontSize.fs12,
                    color: Colors.black,
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
