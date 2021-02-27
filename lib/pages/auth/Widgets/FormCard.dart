import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCard extends StatelessWidget {
    final TextEditingController userNameController;
    final TextEditingController passwordController;
    final GlobalKey formKey;
    final bool passwordIsVisible;
    final VoidCallback togglePasswordVisibility;
    final FormFieldValidator<String> passwordValidate;
    final FormFieldValidator<String> usernameValidate;
    final FocusNode passwordFocusNode;
  FormCard({
    this.userNameController,
    this.passwordController,
    this.formKey,
    this.passwordIsVisible,
    this.togglePasswordVisibility,
    this.usernameValidate,
    this.passwordValidate,
    this.passwordFocusNode
  });
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey, 
        child: Container(
      width: double.infinity,
//      height: ScreenUtil.getInstance().setHeight(500),
      padding: EdgeInsets.only(bottom: 1),
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
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Login",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text("Username",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(26))),
            TextFormField(
              validator: usernameValidate,
              controller: userNameController,
              decoration: InputDecoration(
                  hintText: "username",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text("PassWord",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(26))),
            TextFormField(
              focusNode: passwordFocusNode,
              validator: passwordValidate,
              controller: passwordController,
              obscureText: !passwordIsVisible,
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                   suffixIcon: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Icon(
                                      passwordIsVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey[200],
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    togglePasswordVisibility();
                                  },
                                )),
                  
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: ScreenUtil().setSp(28)),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}