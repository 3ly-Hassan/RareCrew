import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rare_crew/core/constants.dart';
import 'package:rare_crew/core/helper_functions.dart';
import 'package:rare_crew/view_models/auth_view_model.dart';
import 'package:rare_crew/views/dashboard_view.dart';

class AuthScreen extends StatefulWidget {
  static String routeName = '/Auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _rePasswordFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _rePasswordFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 60.0,
            horizontal: 32.0,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<AuthViewModel>(builder: (context, viewModel, _) {
                    return Text(
                      viewModel.loginPage ? 'Log In' : 'Register',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.lightGreen),
                    );
                  }),
                  const SizedBox(height: 100.0),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    textInputAction: TextInputAction.next,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return Constants.kEmailNullError;
                      } else if (!Constants.emailValidatorRegExp
                          .hasMatch(email)) {
                        return Constants.kInvalidEmailError;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Consumer<AuthViewModel>(builder: (context, viewModel, _) {
                    return TextFormField(
                      onEditingComplete: () => !viewModel.loginPage
                          ? FocusScope.of(context)
                              .requestFocus(_rePasswordFocusNode)
                          : FocusScope.of(context).unfocus(),
                      // FocusManager.instance.primaryFocus?.unfocus(),
                      textInputAction: !viewModel.loginPage
                          ? TextInputAction.next
                          : TextInputAction.done,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return Constants.kPassNullError;
                        } else if (val.length < 8) {
                          return !viewModel.loginPage
                              ? Constants.kShortPassError
                              : null;
                        }
                        return null;
                      },
                      obscureText: viewModel.isSecure,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password',
                          suffixIcon: InkWell(
                            onTap: () {
                              context
                                  .read<AuthViewModel>()
                                  .changePasswordVisibility();
                            },
                            child: Consumer<AuthViewModel>(
                                builder: (context, viewModel, _) {
                              return Icon(
                                viewModel.isSecure
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: Colors.lightGreen,
                              );
                            }),
                          ),
                          suffixIconColor: Colors.lightGreen),
                    );
                  }),
                  const SizedBox(height: 24.0),
                  Consumer<AuthViewModel>(builder: (context, viewModel, _) {
                    return !context.read<AuthViewModel>().loginPage
                        ? TextFormField(
                            textInputAction: TextInputAction.done,
                            focusNode: _rePasswordFocusNode,
                            validator: (val) {
                              if (val != _passwordController.text) {
                                return Constants.kMatchPassError;
                              }

                              return null;
                            },
                            obscureText: viewModel.isSecure,
                            decoration: const InputDecoration(
                              labelText: 'Re-enter your password',
                              hintText: 'Re-enter your password',
                            ),
                          )
                        : const SizedBox();
                  }),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        fixedSize: const Size(double.maxFinite, 60)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (context.read<AuthViewModel>().loginPage) {
                          HelperFuctions.showLoadingIndicator(context);
                          context.read<AuthViewModel>().login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(), () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashBoard(),
                                ));
                          }, () {
                            Navigator.pop(context);
                          });
                        } else {
                          HelperFuctions.showLoadingIndicator(context);
                          context.read<AuthViewModel>().register(
                              _emailController.text.trim(),
                              _passwordController.text.trim(), () {
                            Navigator.pop(context);
                            showCentralToast(
                                text: 'Great, Let\'s Login',
                                state: ToastStates.success);
                          }, () {
                            Navigator.pop(context);
                          });
                        }
                      }
                    },
                    child: Consumer<AuthViewModel>(
                        builder: (context, viewModel, _) {
                      return Text(
                        viewModel.loginPage ? 'Log In' : 'Sign Up',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white,
                            ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16.0),
                  Consumer<AuthViewModel>(builder: (context, viewModel, _) {
                    return Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Text(
                          viewModel.loginPage
                              ? 'don\'t have an account? Register now '
                              : 'Are you registered? Log In',
                        ),
                        onTap: () {
                          _clear();
                          viewModel.togglebetweenloginAndSignUp();
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        )));
  }

  void _clear() {
    _formKey.currentState!.reset();
    _emailController.clear();
    _passwordController.clear();
    _rePasswordController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
