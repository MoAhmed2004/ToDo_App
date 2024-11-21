import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase/firebaseAuthCodes.dart';
import 'package:todo/style/DialogUtils.dart';
import 'package:todo/style/reusable_components/customElevatedButton.dart';
import 'package:todo/style/reusable_components/customFormField.dart';
import 'package:todo/style/reusable_components/validation.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/signup/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController=TextEditingController();
    passwordController=TextEditingController();
  }

  @override
  dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/back.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Login'),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key:formKey ,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Customformfield(label:"Email Address" ,
                        keyboard: TextInputType.emailAddress,
                        controller: emailController,
                        validator: Validation.emailValidator
                    ),

                    SizedBox(height: height*0.02,),
                    Customformfield(label:"Password" ,
                      keyboard: TextInputType.visiblePassword,
                      controller: passwordController,
                      isPassword: true,
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please Enter Password';
                        }
                        if(value.length<8){
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },),

                    SizedBox(height: height*0.06,),
                    CustomElevatedButton(onPress: (){
                      login();
                    },
                      title: 'Login',),
                    SizedBox(height: height*0.06,),

                    TextButton(
                        onPressed: (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    }, child: const Text(
                      "OR Create Account")),


                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
  login()async{
    if(formKey.currentState!.validate()){
      try{
        DialogUtils.ShowLoading(context);
       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }on FirebaseAuthException catch(e){
        Navigator.of(context).pop();
        if (e.code == FireBaseAuthCodes.userNotFound) {
          DialogUtils.ShowMessage(context,
              message: "No user found fot that email",
              OKButton: "OK",
              onOKPressed: (){
                Navigator.of(context).pop();
              }
          );
        } else if (e.code == FireBaseAuthCodes.wrongPassword) {
          DialogUtils.ShowMessage(context,
              message: "Wrong password",
              OKButton: "OK",
              onOKPressed: (){
                Navigator.of(context).pop();
              }
          );
        }
      }

    }
  }
}
