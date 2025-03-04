import 'package:flutter/material.dart';
import 'package:flutter_project/authentications/view_models/log_in_view_model.dart';
import 'package:flutter_project/authentications/views/sign_up_screen.dart';
import 'package:flutter_project/common/widgets/button_widget.dart';
import 'package:flutter_project/common/widgets/text_form_field_widget.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/gaps.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/utils/validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = 'login';
  static const routePath = '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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

  void _onEnterButtonPressed() {
    if (_formKey.currentState!.validate()) {
      ref.read(loginProvider.notifier).login(
            _emailController.text,
            _passwordController.text,
            context,
          );
    }
  }

  void _onSignUpButtonPressed() {
    context.push(SignUpScreen.routePath);
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
                    'Welcome!',
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
                    text: 'Enter',
                    onTap: _onEnterButtonPressed,
                  ),
                ],
              ),
              ButtonWidget(
                text: 'Create an account →',
                onTap: _onSignUpButtonPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
