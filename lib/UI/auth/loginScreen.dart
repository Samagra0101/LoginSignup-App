import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstproject/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firstproject/Widgets/roundButton.dart';
import 'package:firstproject/UI/auth/signupScreen.dart';
import 'package:flutter/services.dart';
import 'package:firstproject/UI/profiledisplay.dart';
import 'package:firstproject/UI/auth/phoneLogin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../profiledisplay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  final _auth = FirebaseAuth.instance;

  String userName = '';
  String userCity = '';
  String userState = '';
  int userPhoneNumber = 0;
  GeoPoint userLocation = GeoPoint(0.0, 0.0);



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });

    _auth.signInWithEmailAndPassword(
        email: email.text.toString(), password: password.text.toString()).then((value)async{
          String userEmail=value.user!.email.toString();
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final userDoc = await FirebaseFirestore.instance.collection('Users')
                .doc(user!.uid)
                .get();

            if (userDoc.exists) {
              // Access user data from the document
              Map<String, dynamic> userData = userDoc.data() as Map<
                  String,
                  dynamic>;
              userName = userData['Name'];
              userCity = userData['City'];
              userState = userData['State'];
              userPhoneNumber = userData['Phone Number'];
              userLocation = userData['Location'];

            }
          }

          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileDisplay(
            userName: userName,
            userCity: userCity,
            userEmail: userEmail,
            userPhoneNumber: userPhoneNumber,
            userState: userState,
            userLocation: userLocation
          )));
          setState(() {
            loading = false;
          });

         }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()async{
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Login',style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.purple,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80),
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
                    title: 'Login',
                    loading: loading,
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        login();

                      }
                    },
                  ),

                  SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ?"),
                      TextButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));

                      },
                          child: Text('SignUp'))
                    ],
                  ),
                  SizedBox(height: 40),

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneLogin()));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.black
                        )
                      ),
                      child: Center(

                        child: Text('Login with Phone Number'),
                      ),
                    ),
                  )




                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
