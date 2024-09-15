import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/auth/pages/login_screen.dart';

import '../manager/auth_provider.dart';

class CreateAccountScreen extends StatelessWidget {
  static const String routeName = "createAcc";
  CreateAccountScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Container(
          width: double.infinity,
          // height: double.infinity,
          decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              image: const DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
          child: Consumer<AuthProvider>(
            builder: (context, provider, child) {
              return Scaffold(
                // resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        const Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                        ),
                        TextFormField(
                          controller: provider.nameController,
                          decoration: InputDecoration(
                              hintText: "Name",
                              labelText: "Name",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                              )),
                          validator: (value) {
                            if (value == null || value!.trim().isEmpty) {
                              return "Name is requard";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          controller: provider.phoneController,
                          decoration: InputDecoration(
                              hintText: "Phone",
                              labelText: "Phone",
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                              )),
                          validator: (value) {
                            if (value == null || value!.trim().isEmpty) {
                              return "Phone is requard";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          controller: provider.emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              labelText: "Email",
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                              )),
                          validator: (value) {
                            if (value == null || value!.trim().isEmpty) {
                              return "Email is Requard";
                            } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(value.trim())) {
                              return "Email is Invalid";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          controller: provider.passwordController,
                          obscureText: provider.isSecure,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                              hintText: "Password",
                              labelText: "Password",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    provider.changeSecure();
                                  },
                                  icon: Icon(provider.isSecure
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "password is Requard";
                            } else if (value.length < 6) {
                              return "password is must be 6 or more numbers ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await provider.createAccount(context);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Create Account",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.login,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: const Text("You have account ..? Login"))
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
