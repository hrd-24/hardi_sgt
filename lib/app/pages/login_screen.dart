import 'package:flutter/material.dart';
import 'package:hardi_sgt/app/constant/color_app.dart';
import 'package:hardi_sgt/app/constant/spacing_app.dart';
import 'package:hardi_sgt/app/widgets/bottom.dart';
import 'package:hardi_sgt/app/widgets/default_button.dart';
import 'package:hardi_sgt/app/widgets/input_decoration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary, AppColor.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/image/weather.png'),
              Padding(
                padding: AppSpacing.p16,
                child: TextFormField(
                  decoration: customInputDecoration('Email', icon: Icons.email),
                ),
              ),
              Padding(
                padding: AppSpacing.p16,
                child: TextFormField(
                  obscureText: _obscureText,
                  decoration: customInputDecoration(
                    'Password',
                    icon: Icons.lock,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.white, 
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: AppSpacing.p16,
                child: LoginButton(
                  text: 'Login',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
