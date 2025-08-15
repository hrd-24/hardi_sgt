import 'package:flutter/material.dart';
import 'package:hardi_sgt/app/constant/color_app.dart';
import 'package:hardi_sgt/app/pages/login_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool confirmLogout = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Konfirmasi Logout'),
                content: const Text('Apakah kamu yakin ingin logout?'),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(false), // batal logout
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(true), // konfirmasi logout
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );

            // Jika user konfirmasi, jalankan logout
            if (confirmLogout) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
