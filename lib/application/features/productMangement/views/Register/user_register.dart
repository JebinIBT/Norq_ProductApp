import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinetest/application/features/productMangement/auth_bloc/auth_bloc.dart';
import 'package:machinetest/application/features/productMangement/models/user_model.dart';
import 'package:machinetest/application/features/productMangement/views/Common%20Widget/commonTextfield.dart';
import 'package:machinetest/application/features/productMangement/views/Common%20Widget/commonbutton.dart';


class RegisterPageWrapper extends StatelessWidget {
  const RegisterPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: UserRegister(),
    );
  }
}
class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController =TextEditingController();
  TextEditingController nameController =TextEditingController();
  TextEditingController phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state)
    {
      if (state is Authenticated) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        });
      }

      return
        Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Sign Up", style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
                  const SizedBox(height: 30,),
                  const Text("Enter your user information below or continue with ",
                      style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  const Text(" one of your social accounts", style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
                  const SizedBox(height: 50,),
                  CustomTextfield(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    prefixIcon: Icon(Icons.person),
                  ),

                  const SizedBox(height: 20,),
                  CustomTextfield(
                    controller: phoneController,
                    hintText: 'Phone Number',
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icon(Icons.phone),
                  ),
                  const SizedBox(height: 20,),
                  CustomTextfield(
                    controller: emailController,
                    hintText: 'Email Address',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email),
                  ),

                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(CupertinoIcons.eye_slash_fill),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.grey),
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),

                  ),


                  const SizedBox(height: 70,),
                  CommonButton(title: 'Sign Up', onClick: () {
                    UserModel user = UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text);

                    authBloc.add(SignupEvent(user: user));

                  },),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Does  have an account ?'),
                      TextButton(
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 16, color: Colors.red[400]),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
        );
    });
  }
}



