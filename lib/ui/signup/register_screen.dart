import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase/firebaseAuthCodes.dart';
import 'package:todo/style/DialogUtils.dart';
import 'package:todo/style/reusable_components/customElevatedButton.dart';
import 'package:todo/style/reusable_components/customFormField.dart';
import 'package:todo/style/reusable_components/validation.dart';
import 'package:todo/ui/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController=TextEditingController();
    ageController=TextEditingController();
    emailController=TextEditingController();
    passwordController=TextEditingController();
    passwordConfirmationController=TextEditingController();
  }
  
  @override
  dispose(){
    super.dispose();
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return  Container(
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
          title: Text('Create Account'),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        body:Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key:formKey ,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Customformfield(label: "Full Name",
                    keyboard:TextInputType.name ,
                    controller:nameController ,
                      validator:(value){
                      return Validation.nameValidator(value,"Please Enter Your Name");
                      }

                    ),

                    SizedBox(height: height*0.02,),
                    Customformfield(label:"Email Address" ,
                        keyboard: TextInputType.emailAddress,
                        controller: emailController,
                    validator: Validation.emailValidator
                    ),

                    SizedBox(height: height*0.02,),
                    Customformfield(label:"Age" ,
                        keyboard: TextInputType.number,
                        controller: ageController,
                        validator:(value){
                      Validation.nameValidator(value,
                          "Please Enter Your Age");

                    }),
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
                          SizedBox(height: height*0.02,),
                          Customformfield(label:"Password Confirmation" ,
                          keyboard: TextInputType.visiblePassword,
                          controller: passwordConfirmationController,
                          isPassword: true,
                          validator: (value)
                        {
                        if(value==null || value.isEmpty){
                          return 'Please Enter Password';
                        }
                        if(value!=passwordController.text){
                          return 'Password does not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height*0.06,),
                    CustomElevatedButton(onPress: (){
                      createAccount();

                    },
                      title: 'Create Account',),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  createAccount()async{
  if(formKey.currentState!.validate()){
   try{
     DialogUtils.ShowLoading(context);
     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email:emailController.text ,
         password: passwordController.text
     );
      Navigator.of(context).pop();
      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName,(route) => false,);
   }on FirebaseAuthException catch(e){
     if (e.code == FireBaseAuthCodes.weakPassword) {
       DialogUtils.ShowMessage(context,
           message: "Password is too weak",
           OKButton: "OK",
           onOKPressed: (){
             Navigator.of(context).pop();
           }
       );
     } else if (e.code == FireBaseAuthCodes.emailAlreadyInUse) {
       DialogUtils.ShowMessage(context,
           message: "Email is already in use",
           OKButton: "OK",
           onOKPressed: (){
             Navigator.of(context).pop();
           }
       );
     }
   }
   catch(e){

   }

    }
    
  }
}
