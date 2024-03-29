import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/components/sign_in_with.dart';
import 'package:kushi_3/components/textfield.dart';
import 'package:kushi_3/pages/selectGender.dart';
import 'package:kushi_3/pages/signup.dart';

class SignIn extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 25,),

            const Text(
              "Sign In",
              style: TextStyle(
                fontWeight: FontWeight.w700,

                color: Colors.black,
                fontSize: 29,
              ),
            ),

            const SizedBox(height: 25,),

            MyTextField(
              hintText: "Phone Number",
              obscureText: false,
              controller: _usernameController,
            ),
            const SizedBox(height: 25,),
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 50,),
            MyButton(text: "Sign in", onTap: () async {
              try{
                UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _usernameController.text.trim(),
                    password: _passwordController.text.trim()
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectGender()),
                );
              }
              catch (e){
                print("Failed to sign in: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Failed to sign in. Please check your credentials."),
                  ),
                );
              }
            },
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: () {},
                  child: Text("Forgot password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,


                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height:50,),

            const Text("Sign In With", style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),),
            const Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'assets/icons/google.png',),
                SizedBox(width: 10,),
                SquareTile(imagePath: 'assets/icons/apple.png',)


              ],
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",

                    style:TextStyle(

                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context){
                          return SignUp();
                        })
                    );
                  },
                      child:  Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 10,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.0,


                        ),
                      ))

                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
