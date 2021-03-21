import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/pages/auth/login_screen.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'package:flutter_vietnam_app/services/validate_service.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

class AnotherUser{
  String userName;
  String name;
  String passWord;

}
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey=GlobalKey<FormState>();
  bool _isSelected = false;
  FocusNode _passwordFocusNode;

  bool _isSubmitted;
  bool _passwordIsVisible;
  String _loginFeedback;
  bool _loginInProgress;
  AnotherUser usr=AnotherUser();

  ValidationService _validationService;
  final ServiceMain _userService = serviceLocator<ServiceMain>();

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }
  
  @override 
  void initState(){
    super.initState();
     _passwordFocusNode = FocusNode();
    _loginInProgress = false;
    _isSubmitted = false;
    _passwordIsVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
          child:Column(
            children:[
              Container(
            padding: const EdgeInsets.all(10),
            child: Form(        
              key:_formKey,
              child: SafeArea(
                child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset("assets/images/image_01.png")),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Register',style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      SizedBox(height: 20,),
                      Text('Username'),
                      SizedBox(height: 5,),
                      AnotherTextField(
                        validator: (value){
                          if(value.isEmpty)
                            return "Please input your user name";
                          else{
                            print(value);
                            setState(() {
                              usr.userName=value;                              
                            });}
                            return null;
                        },
                      ),
                      SizedBox(height: 5,),
                      Text('Full name'),
                      SizedBox(height: 5,),
                      AnotherTextField(
                        validator:(value){
                          if(value.isEmpty)
                              return "Please input your full name";
                          else{
                              print(value);
                              setState(() {
                                usr.name=value;                              
                              });}
                            return null;
                        },
                      ),
                      SizedBox(height: 5,),
                      Text('Password'),
                      SizedBox(height: 5,),
                      AnotherTextField(
                        validator: (value){
                          if(value.isEmpty)
                            return "Please input your password";
                          else{
                            print(value);
                            setState(() {
                                usr.passWord=value;                              
                              });}
                            return null;
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 5,),
                      Text('Confirm Password'),
                      SizedBox(height: 5,),
                      AnotherTextField(
                        validator: (value){
                          if(value.isEmpty)
                            return "Please input your password";
                          else if(value.length<8)
                            return "Password must be more than 8 characters";
                          else if(usr.passWord!=value)
                            return "Password not match! Please try again";
                          else{
                            print(value);
                            setState(() {
                                usr.passWord=value;                              
                              });}
                            return null;
                        },
                        obscureText: true,
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
                          onPressed: (){
                            _submitForm();
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              border: Border.all(width: 0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:Text('Sign Up',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),)
                          ),
                        ),
                      )])
        ),
    );
  }

  Future<void> _submitForm() async {
    _isSubmitted = true;
    if (_validateForm()) {
      await _signup(context);
    }
  }

 Future<void> _signup(BuildContext context) async {
    _setLoginInProgress(true);
    String username = usr.userName;
    String password = usr.passWord;
    String name = usr.name;
    try {
      print("huhu");
      await _userService.signUpWithCredientials(
        name: name,
        username: username, 
        password: password);
          print("kkk");
      Navigator.pop(context); 
     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Login()),
  );
    } on CredentialsMismatchError {
      _setLoginFeedback(
        "auth login credentials mismatch error"
      );
    } on HttpieRequestError {
      _setLoginFeedback(
          "auth login server error");
    } on HttpieConnectionRefusedError {
      _setLoginFeedback(
         "auth login connection error");
    }
    _setLoginInProgress(false);

  }

  String _validateUsername(String value) {
    if (!_isSubmitted) return null;
    return _validationService.validateUserUsername(value.trim());
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
}

typedef StringCallback=String Function(String value);
class AnotherTextField extends StatelessWidget {
  final StringCallback validator;
  final bool obscureText;
  AnotherTextField({this.validator,this.obscureText:false});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(5),),
        child:Container(
          padding: EdgeInsets.only(left: 10),
            child: TextFormField(
              obscureText: obscureText,
              decoration: InputDecoration(
                border:InputBorder.none,),
              style: TextStyle(
                fontSize: 20),
                validator:validator))
      );
  }
}