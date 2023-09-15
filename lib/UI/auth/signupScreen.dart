import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firstproject/Widgets/roundButton.dart';
import 'package:firstproject/UI/auth/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstproject/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SignUp',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        helperText: 'abc@something.com',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter email !';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        helperText: 'Min 6 characters',
                        prefixIcon: Icon(Icons.lock_open),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter password !';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              RoundButton(
                title: 'SignUp',
                loading: loading,
                onTap: (){
                  if(_formKey.currentState!.validate()){

                    setState(() {
                      loading = true;
                    });
                    _auth.createUserWithEmailAndPassword(
                        email: email.text.toString(),
                        password: password.text.toString()).then((value){
                      setState(() {
                        loading = false;
                      });

                    }).onError((error, stackTrace) {

                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });

                    });

                  }
                },
              ),

              SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?"),
                  TextButton(onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                  },
                      child: Text('Login'))
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
