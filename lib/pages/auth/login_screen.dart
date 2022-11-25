import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vietnam_app/pages/auth/signup_screen.dart';
import 'package:flutter_vietnam_app/pages/navigation_tab.dart';
import 'package:flutter_vietnam_app/utils/logg.dart';
import 'package:flutter_vietnam_app/view_models/login_notifier.dart';
import 'package:provider/provider.dart';
import 'widget/form_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StreamSubscription<bool>? isLoginSuccessSub;
  @override
  void initState() {
    super.initState();
    Provider.of<LoginScreenViewModel>(context, listen: false).init();

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      isLoginSuccessSub =
          Provider.of<LoginScreenViewModel>(context, listen: false)
              .isLoginSuccess
              .listen((bool event) {
        if (event == true) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const NavigationTab(),
            ),
            (_) => false,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    isLoginSuccessSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
        750,
        1334,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                child: Image.asset(
                  'assets/images/com_lang_vong_sqr-removebg-preview.png',
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(child: Image.asset('assets/images/image_02.png'))
            ],
          ),
          Consumer<LoginScreenViewModel>(
            builder: (
              BuildContext context,
              LoginScreenViewModel value,
              Widget? child,
            ) =>
                SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 28.0, right: 28.0, top: 300.0),
                child: Column(
                  children: <Widget>[
                    FormCard(
                      formKey: value.getFormKey,
                      userNameController: value.getUsernameController,
                      passwordController: value.getPasswordController,
                      togglePasswordVisibility: value.togglePasswordVisibility,
                      passwordIsVisible: value.getPasswordIsVisible,
                      usernameValidate: value.validateEmail,
                      passwordValidate: value.validatePassword,
                      passwordFocusNode: value.getPasswordFocusNode,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            value.setLoginInProgress(true);
                            await value.signIn().then((String userId) {
                              if (userId.isNotEmpty) {
                                logg('Logged in successfully with $userId');
                                value.setSuccessMessage(
                                  '''Logged in successfully.\nYou can now navigate to Home Page.''',
                                );
                              } else {
                                logg('Error while Login.');
                              }
                            });
                            value.setLoginInProgress(false);
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(330),
                            height: ScreenUtil().setHeight(100),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color:
                                      const Color(0xFF6078ea).withOpacity(.3),
                                  offset: const Offset(0.0, 8.0),
                                  blurRadius: 8.0,
                                )
                              ],
                            ),
                            child: value.getLoginInProgess!
                                ? Center(
                                    child: _getLoadingIndicator(Colors.blue),
                                  )
                                : const Center(
                                    child: Text(
                                      'SIGNIN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'New User? ',
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                              color: Color(0xFF5d74e3),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black),
        ),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  Widget _getLoadingIndicator(Color color) {
    return const SizedBox(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(strokeWidth: 2.0),
    );
  }
}
