import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCard extends StatelessWidget {
  const FormCard({
    Key? key,
    this.userNameController,
    this.passwordController,
    required this.formKey,
    this.passwordIsVisible,
    this.togglePasswordVisibility,
    this.usernameValidate,
    this.passwordValidate,
    this.passwordFocusNode,
  }) : super(key: key);
  final TextEditingController? userNameController;
  final TextEditingController? passwordController;
  final GlobalKey formKey;
  final bool? passwordIsVisible;
  final Function()? togglePasswordVisibility;
  final FormFieldValidator<String>? passwordValidate;
  final FormFieldValidator<String>? usernameValidate;
  final FocusNode? passwordFocusNode;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 1),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(45),
                  letterSpacing: .6,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Text(
                'Username',
                style: TextStyle(fontSize: ScreenUtil().setSp(26)),
              ),
              TextFormField(
                validator: usernameValidate,
                controller: userNameController,
                decoration: const InputDecoration(
                  hintText: 'username',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Text(
                'PassWord',
                style: TextStyle(fontSize: ScreenUtil().setSp(26)),
              ),
              TextFormField(
                focusNode: passwordFocusNode,
                validator: passwordValidate,
                controller: passwordController,
                obscureText: passwordIsVisible ?? false,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 12.0),
                  suffixIcon: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Icon(
                        passwordIsVisible == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey[200],
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      togglePasswordVisibility?.call();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
