// Import lib modules
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ressources_relationnelles/utils/utils.dart';
import 'package:ressources_relationnelles/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController =  TextEditingController();
  TextEditingController _emailController =  TextEditingController();
  TextEditingController _passwordController =  TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  FocusNode _nameFocusNode =  FocusNode();
  FocusNode _emailFocusNode =  FocusNode();
  FocusNode _passFocusNode =  FocusNode();
  FocusNode _confirmPassFocusNode =  FocusNode();
  String _name, _email, _password, _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Stack(children: <Widget>[
          ClipPath(
              clipper: BottomShapeClipper(),
              child: Container(
                color: colorCurve,
              )),
          SingleChildScrollView(
            child: SafeArea(
              top: true,
              bottom: false,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.getWidthPx(20), vertical: size.getWidthPx(20)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back,color: colorCurve,),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          SizedBox(width: size.getWidthPx(10)),
                          _signUpGradientText(),
                        ],
                      ),
                      SizedBox(height: size.getWidthPx(10)),
                      _textAccount(),
                      SizedBox(height: size.getWidthPx(30)),
                      registerFields()
                    ]),
              ),
            ),
          )
        ]));
  }

  RichText _textAccount() {
    return RichText(
      text: TextSpan(
          text: "Deja inscrit ? ",
          children: [
            TextSpan(
              style: TextStyle(color: Color.fromRGBO(15, 175, 150, 1)),
              text: 'Je me connecte',
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pop(context),
            )
          ],
          style: TextStyle(fontFamily: 'Exo2',color: Colors.black87, fontSize: 16)),
    );
  }

  GradientText _signUpGradientText() {
    return GradientText("Inscription",
        gradient: LinearGradient(colors: [
          Color.fromRGBO(15, 175, 150, 1),
          Color.fromRGBO(99, 255, 150, 1)
        ]),
        style: TextStyle(fontFamily: 'Exo2',fontSize: 36, fontWeight: FontWeight.bold));
  }

  BoxField _nameWidget() {
    return BoxField(
        controller: _nameController,
        focusNode: _nameFocusNode,
        hintText: "Mon nom",
        lableText: "Nom",
        obscureText: false,
        onSaved: (String val) {
          _name = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        icon: Icons.person,
        iconColor: colorCurve);
  }

  BoxField _emailWidget() {
    return BoxField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        hintText: "Mon adresse mail",
        lableText: "Email",
        obscureText: false,
        onSaved: (String val) {
          _email = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passFocusNode);
        },
        icon: Icons.email,
        iconColor: colorCurve);
  }

  BoxField _passwordWidget() {
    return BoxField(
        controller: _passwordController,
        focusNode: _passFocusNode,
        hintText: "Mon mot de passe",
        lableText: "Mot de passe",
        obscureText: true,
        icon: Icons.lock_outline,
        onSaved: (String val) {
          _password = val;
        },
        iconColor: colorCurve);
  }

  BoxField _confirmPasswordWidget() {
    return BoxField(
        controller: _confirmPasswordController,
        focusNode: _confirmPassFocusNode,
        hintText: "Confirmer mon mot de passe",
        lableText: "Confirmer mon mot de passe",
        obscureText: true,
        icon: Icons.lock_outline,
        onSaved: (String val) {
          _confirmPassword = val;
        },
        iconColor: colorCurve);
  }

  Container _signUpButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(size.getWidthPx(12)),
        child: Text(
          "Je m'inscris",
          style: TextStyle(fontFamily: 'Exo2',color: Colors.white, fontSize: 20.0),
        ),
        color: colorCurve,
        onPressed: () {
          // Going to DashBoard
        },
      ),
    );
  }

  GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: size.getWidthPx(20),
        backgroundColor: Colors.white,
        child: Image.asset(assetIcon),
      ),
    );
  }

  registerFields() => Container(
    child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _nameWidget(),
            _emailWidget(),
            _passwordWidget(),
            _confirmPasswordWidget(),
            _signUpButtonWidget(),
          ],
        )),
  );
}