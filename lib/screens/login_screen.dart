import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/sign_up_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/snackbar.dart';
import '../responsive/mobile_screen.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_Screen.dart';
import '../widgets/text_input_fileds.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTeController = TextEditingController();
  final passTeController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailTeController.dispose();
    passTeController.dispose();
  }

  void loginUser() async {
    isLoading = true;
    setState(() {});
    String result = await AuthMethods()
        .logIn(emailTeController.text.trim(), passTeController.text.trim());
    if (result == 'Success') {

      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const ResponsiveLayout(
            webScreenLayout: WebScreen(),
            mobileScreenLayout: MobileScreen(),
          );
        }));
      }
    } else {
      if (mounted) {
        showSnackBar(context, result);
      }
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Hero(
                tag: 'instalogo',
                child: SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  color: primaryColor,
                  height: 64,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              MyTextFiled(
                controller: emailTeController,
                hintText: 'email',
                obscure: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 22,
              ),
              MyTextFiled(
                controller: passTeController,
                hintText: 'password',
                obscure: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 22,
              ),
              InkWell(
                onTap: loginUser,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      color: Colors.blue),
                  child:     isLoading?const Center(child: CircularProgressIndicator()):const Text('log in'),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't Have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "SignUp",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
