import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:thread_clone/features/authentication/widgets/form_button.dart';
import 'package:thread_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:thread_clone/features/settings/view_models/darkmode_config_vm.dart';

class SignUpScreen extends ConsumerWidget {
  static const routeURL = "/signup";
  static const routeName = 'signup';

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    context.go("/login");
  }

  String? _emailValidator(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Map<String, String> formData = {
      "email": "",
      "password": "",
    };

    void _onSignupTap() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        ref.read(signUpProvider.notifier).signUp(
              formData["email"]!,
              formData["password"]!,
              context,
            );
        context.goNamed(
          MainNavScreen.routeName,
          pathParameters: {
            "tab": "",
          },
        );
      }
    }

    final isDark = ref.watch(darkModeConfigViewModelProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "English (US)",
          style: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size24,
        ),
        child: Column(
          children: [
            Gaps.v72,
            Center(
              child: SvgPicture.asset(
                'assets/icons/square-threads.svg',
                height: 110,
                width: 110,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Gaps.v72,
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Mobile number or email",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    validator: _emailValidator,
                    onSaved: (value) => formData["email"] = value!,
                  ),
                  Gaps.v12,
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                    onSaved: (value) => formData["password"] = value!,
                  ),
                  Gaps.v12,
                  GestureDetector(
                    onTap: _onSignupTap,
                    child: FormButton(
                      text: "Sign up",
                      disabled: ref.watch(signUpProvider).isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.11,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _onLoginTap(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size12,
                ),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Already have an account? ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? Colors.grey.shade300
                            : Colors.grey.shade900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gaps.v12,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.meta,
                  size: Sizes.size18,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                ),
                Gaps.h8,
                Text(
                  "Meta",
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
