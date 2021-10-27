import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vietnam_app/pages/auth/signup_screen.dart';
import 'package:flutter_vietnam_app/pages/home/home_page.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'package:flutter_vietnam_app/services/validation/validation_service.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';
import 'package:flutter_vietnam_app/view_models/login_view_model.dart';
import 'Widgets/form_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginScreenViewModel model = serviceLocator<LoginScreenViewModel>();
  
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();
  FocusNode _passwordFocusNode;

  bool _isSubmitted;
  bool _passwordIsVisible;
  String _loginFeedback;
  bool _loginInProgress;

  final ServiceMain _userService = serviceLocator<ServiceMain>();
  final ValidationService _validationService = serviceLocator<ValidationService>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  String successMessage = '';

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _loginInProgress = false;
    _isSubmitted = false;
    _passwordIsVisible = false;

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose(){
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                child: Image.asset(
                    "assets/images/com_lang_vong_sqr-removebg-preview.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(child: Image.asset("assets/images/image_02.png"))
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 300.0),
              child: Column(
                children: <Widget>[
                  FormCard(
                      formKey: _formKey,
                      userNameController: _usernameController,
                      passwordController: _passwordController,
                      togglePasswordVisibility: _togglePasswordVisibility,
                      passwordIsVisible: _passwordIsVisible,
                      usernameValidate: _validateEmail,
                      passwordValidate: _validatePassword,
                      passwordFocusNode: _passwordFocusNode),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          _setLoginInProgress(true);
                          await signIn().then((user) {
                            if (user != null) {
                              print(
                                  'Logged in successfully with $user');
                              setState(() {
                                successMessage =
                                    'Logged in successfully.\nYou can now navigate to Home Page.';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              });
                              //  _submitForm();
                            } else {
                              print('Error while Login.');
                            }
                          });
                          _setLoginInProgress(false);
                        },
                        child: Container(
                          width: ScreenUtil().setWidth(330),
                          height: ScreenUtil().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: _loginInProgress
                              ? Center(child: _getLoadingIndicator(Colors.blue))
                              : Center(
                                  child: Text("SIGNIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
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
                      Text(
                        "New User? ",
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                        child: Text("SignUp",
                            style: TextStyle(
                              color: Color(0xFF5d74e3),
                            )),
                      )
                    ],
                  )
                ],
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
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  Future<String> signIn() async {
    try {
      String _emailId = _usernameController.text;
      String _password = _passwordController.text;

      print(_emailId);
      print(_password);

      FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: _emailId, password: _password))
          .user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      return user.uid;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        setState(() {
          errorMessage = 'User Not Found!!!';
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        setState(() {
          errorMessage = 'Wrong Password!!!';
        });
        break;
    }
  }

  String _validateEmail(String value) {
    if (!_isSubmitted) return null;
    return _validationService.validateEmail(value);
  }

  String _validatePassword(String value) {
    if (!_isSubmitted) return null;

    return _validationService.validateUserPassword(value);
  }

  bool _validateForm() {
    if (_loginFeedback != null) {
      _setLoginFeedback(null);
    }
    return _formKey.currentState.validate();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordIsVisible = !_passwordIsVisible;
    });
  }

  void _setLoginFeedback(String feedback) {
    setState(() {
      _loginFeedback = feedback;
    });
  }

  void _setLoginInProgress(bool loginInProgress) {
    setState(() {
      _loginInProgress = loginInProgress;
    });
  }

  Widget _getLoadingIndicator(Color color) {
    return SizedBox(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(strokeWidth: 2.0),
    );
  }
}
