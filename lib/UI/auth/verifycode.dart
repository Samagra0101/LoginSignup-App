import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widgets/roundButton.dart';
import '../../utils/utils.dart';
import 'package:firstproject/UI/profilePage.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key , required this.verificationId}) : super(key:key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verifycode = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 90),
            TextFormField(
              controller: verifycode,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: 'Enter the 6 digit code'
              ),
            ),
            SizedBox(height: 80),

            RoundButton(title: 'Verify',loading: loading, onTap: ()async{
              setState(() {
                loading = true;

              });
              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verifycode.text.toString());

              try{
                await _auth.signInWithCredential(credential);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              }catch(e){
                setState(() {
                  loading = false;

                });
                Utils().toastMessage(e.toString());
              }

            })
          ],
        ),
      ),
    );
  }
}
