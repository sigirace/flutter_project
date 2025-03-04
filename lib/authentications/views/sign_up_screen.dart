import 'package:flutter/material.dart';
import 'package:flutter_project/authentications/view_models/sign_up_view_model.dart';
import 'package:flutter_project/common/widgets/button_widget.dart';
import 'package:flutter_project/common/widgets/text_form_field_widget.dart';
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
                    text: isLoading ? 'Sing Up...' : 'Create Account',
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
