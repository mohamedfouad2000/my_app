import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/core/storage/secure_storage.dart';
import 'package:my_app/core/utils/service_locator.dart';
import 'package:my_app/features/auth/data/models/user.dart';
import 'package:my_app/features/auth/presenation/cubit/auth_cubit.dart';
import 'package:my_app/features/auth/presenation/screens/signup_screen.dart';
import 'package:my_app/features/home/presentation/screens/chat_home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Log In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// Email
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Password
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Sign In Button
                  ElevatedButton(
                    onPressed: () {
                      final email = emailController.text;
                      final password = passwordController.text;

                      context.read<AuthCubit>().login(
                            email: email,
                            password: password,
                          );
                    },
                    child: Text(state.isLoading ? "Loading..." : "Sign In"),
                  ),

                  const SizedBox(height: 20),

                  /// Go To Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (BuildContext context, AuthState state) {
      if (state.isLoggedIn) {
        final storage = sl<SecureStorage>();
        storage.write(AppConstants.keyUserId, state.user!.uid);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "✅ Logged In Successfully Welcome ${state.user?.displayName}"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  ChatHomeScreen(user: AppUser.fromFirebaseUser(state.user!))),
        );
      } else if (state.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("❌ Error: ${state.message}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
