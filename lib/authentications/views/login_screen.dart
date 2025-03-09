import 'package:flutter/material.dart';
import 'package:flutter_project/authentications/view_models/log_in_view_model.dart';
import 'package:flutter_project/authentications/views/sign_up_screen.dart';
import 'package:flutter_project/authentications/views/widgets/button_widget.dart';
import 'package:flutter_project/authentications/views/widgets/text_form_field_widget.dart';
import 'package:flutter_project/common/widgets/gradient_text.dart';
import 'package:flutter_project/constants/colors.dart';
import 'package:flutter_project/constants/fonts.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_project/constants/gaps.dart';
import 'package:flutter_project/constants/sizes.dart';
import 'package:flutter_project/features/setting/view_models/mode_view_model.dart';
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
    final isLoading = ref.watch(loginProvider).isLoading;
    final isDarkMode = ref.watch(modeViewModelProvider).isDarkMode;
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
                child: GradientText(
                  text: '에프로움',
                  fontSize: FontSize.fs52,
                  fontFamily: FontFamily.sbM,
                  colors: isDarkMode
                      ? AppColors.darkGradientColors
                      : AppColors.gradientColors,
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
                            hintText: '이메일',
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
                      text: isLoading ? '로그인 중...' : '로그인',
                      onTap: _onEnterButtonPressed,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _onSignUpButtonPressed,
                child: Text(
                  '계정이 없다면?',
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
