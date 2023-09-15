import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstproject/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firstproject/Widgets/roundButton.dart';
import 'package:firstproject/UI/auth/verifycode.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool loading = false;
  final phonenumber = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 90),
            TextFormField(
              controller: phonenumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your Phone Number'
              ),
            ),
            SizedBox(height: 80),

            RoundButton(title: 'Login',loading: loading, onTap: (){

              setState(() {
                 loading = true;
              });
             _auth.verifyPhoneNumber(
               phoneNumber: phonenumber.text,
                 verificationCompleted: (_){
                   setState(() {
                      loading = false;
                   });

                 },
                 verificationFailed: (e){
                   setState(() {
                     bool loading = false;
                   });
                 Utils().toastMessage(e.toString());
                 },
                 codeSent: (String verificationId, int? token){
                 Navigator.push(context, MaterialPageRoute(
                     builder: (context) => VerifyCodeScreen(verificationId: verificationId,) ));
                 setState(() {
                    loading = false;
                 });
                 },
                 codeAutoRetrievalTimeout: (e){
                 Utils().toastMessage(e.toString());
                 setState(() {
                    loading = false;
                 });
                 });
            })
          ],
        ),
      ),
    );
  }
}
