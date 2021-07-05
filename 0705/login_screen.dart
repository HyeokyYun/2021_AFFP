import 'package:flutter/material.dart';
import 'package:study0628auth/theme/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    // void showAlertDialog(BuildContext context){
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context){
    //         return CustomAlertDialog(
    //           content: Container(
    //             width: mq.size.width/1.2,
    //             height: mq.size.height/4,
    //           ),
    //         );
    //       }
    //   );
    // }

    final logo = Image.asset(
      "assets/logo.png",
      height: mq.size.height/3,
    );

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintText: "email@example.com",
        labelText: "Email",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final passwordField = Column(
      children: [
        TextFormField(
          controller: _passwordController,
          style: TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            hintText: "Password",
            labelText: "Password",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              child: Text(
                "Forgot Password",
                style: Theme.of(context).textTheme.caption!.copyWith(color:Colors.white),
              ),
              onPressed: (){
                //showAlertDialog(context);
              },
            ),
          ],
        ),
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          emailField,
          passwordField,
        ],
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width/1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          try{
            User? user =
            (await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text
            )).user;
            if(user != null){
              Navigator.of(context).pushNamed(AppRoutes.menu);
            }
          }catch(e){
            print(e);
            _emailController.text = "";
            _passwordController.text = "";
          }
          //TODO: Handle a authentication
          print("Login Pushed");
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        loginButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Not a member?",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.white,
              ),
            ),
            MaterialButton(
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: (){
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
                print("Sign Up Pressed");
              },
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              logo,
              fields,
              Padding(
                padding: EdgeInsets.only(bottom: 70),
                child: bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
