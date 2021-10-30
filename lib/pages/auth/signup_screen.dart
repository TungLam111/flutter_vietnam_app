import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/pages/auth/login_screen.dart';
import 'package:flutter_vietnam_app/services/auth/auth_service.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'package:flutter_vietnam_app/services/validation/validate_service_impl.dart';
import 'package:flutter_vietnam_app/services/validation/validation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _passwordFocusNode;

  bool _isSubmitted;
  bool _passwordIsVisible;
  String _loginFeedback;
  bool _loginInProgress;

  final ValidationService _validationService = serviceLocator<ValidationService>();
  final AuthService _authService = serviceLocator<AuthService>();

  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _passwordConfirmController;

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
    _passwordConfirmController = TextEditingController();

    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _passwordConfirmController.addListener(_validateForm);
  }
  
  @override 
  void dispose(){
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 200 ,
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/mua_roi_sqr-removebg-preview.png")),
                  
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
                    decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Username'),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: _validateEmail,
                      controller: _usernameController,
                      decoration: InputDecoration(
                          hintText: "username",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Text('Password'),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: _validatePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "password",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Text('Confirm Password'),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: _validateConfirmPassword,
                      controller: _passwordConfirmController,
                      decoration: InputDecoration(
                          hintText: "Confirm password",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                    ),
                    ],),
                  ),

                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              _submitForm();
            },
            child: Container(
                height: ScreenUtil().setHeight(100),
                width: ScreenUtil().setWidth(330),
                decoration: BoxDecoration(
                   gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _loginInProgress
                    ? Center(child: _getLoadingIndicator(Colors.blue))
                    : Center(
                      child: Text(
                          'SIGNUP',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                    )),
          ),
        ),
        GestureDetector( 
          onTap: (){
                  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
          },
          child: Text("LogIn", style: TextStyle(color: Colors.blue))
        )
      ])),
    );
  }

  Future<void> signUp(email, password) async {
    _setLoginInProgress(true);
    try {
      FirebaseUser user = await _authService.signupWithFirebase(
              emailId: email, password: password);
          
      assert(user != null);
      assert(await user.getIdToken() != null);

      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      //return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
    }
  }

  Future<void> _submitForm() async {
    _isSubmitted = true;
    if (_validateForm()) {
      String _emailId = _usernameController.text;
      String _password = _passwordController.text;
      print(_password);
      await signUp(_emailId, _password);
    }
  }

  // Future<void> _signup(BuildContext context) async {
  //   _setLoginInProgress(true);
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;
  //   String name = "";
  //   try {
  //     print("Start running");
  //     await _userService.signUpWithCredientials(
  //         name: name, username: username, password: password);
  //     print("kkk");
  //     Navigator.pop(context);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => LoginScreen()),
  //     );
  //   } on CredentialsMismatchError {
  //     _setLoginFeedback("auth login credentials mismatch error");
  //   } on HttpieRequestError {
  //     _setLoginFeedback("auth login server error");
  //   } on HttpieConnectionRefusedError {
  //     _setLoginFeedback("auth login connection error");
  //   }
  //   _setLoginInProgress(false);
  // }

  String _validateEmail(String value) {
    if (!_isSubmitted) return null;
    return _validationService.validateEmail(value);
  }

  String _validatePassword(String value) {
    if (!_isSubmitted) return null;

    return _validationService.validateUserPassword(value);
  }

  String _validateConfirmPassword(String value) {
    if (!_isSubmitted) return null;

    if (value != _passwordController.text) {
      return 'Confirm passowrd must be same with passowrd';
    }
    return null;
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
      child: CircularProgressIndicator(
          strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation<Color>(color)),
    );
  }
}
