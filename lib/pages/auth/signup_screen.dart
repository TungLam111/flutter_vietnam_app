import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/pages/auth/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vietnam_app/view_models/signup_notifier.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SignupScreenViewModel>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SignupScreenViewModel>(
        builder: (
          BuildContext context,
          SignupScreenViewModel value,
          Widget? child,
        ) =>
            SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Form(
                  key: value.getFormKey,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/mua_roi_sqr-removebg-preview.png',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 20,
                            top: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0,
                              ),
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Username'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                validator: value.validateEmail,
                                controller: value.usernameController,
                                decoration: const InputDecoration(
                                  hintText: 'username',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Password'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                validator: value.validatePassword,
                                controller: value.passwordController,
                                decoration: const InputDecoration(
                                  hintText: 'password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Confirm Password'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                validator: value.validateConfirmPassword,
                                controller: value.passwordConfirmController,
                                decoration: const InputDecoration(
                                  hintText: 'Confirm password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    //
                  },
                  child: Container(
                    height: ScreenUtil().setHeight(100),
                    width: ScreenUtil().setWidth(330),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFF17ead9),
                          Color(0xFF6078ea),
                        ],
                      ),
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: value.signUpProgress
                        ? Center(child: _getLoadingIndicator(Colors.blue))
                        : const Center(
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const LoginScreen(),
                    ),
                  );
                },
                child:
                    const Text('LogIn', style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLoadingIndicator(Color color) {
    return SizedBox(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
