import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/widgets/default_scaffold.dart';
import 'package:stock_management/widgets/scaffold_no_appbar.dart';

import '../controllers/auth_controller.dart';

final AuthController _auth = AuthController();

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LogInScreenState();
  }
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _loading = false;
  late bool _passwordVisible = true;
  late bool _error = false;

  String _errorMessage = 'Error occured, try again';

  @override
  initState() {
    super.initState();
    if (_auth.currentUser != null) {
      Navigator.of(context).popAndPushNamed('/');
    }
  }

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message!;
      });
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldNoAppBar(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                  color: Color(0xFF122E40),
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.none,
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail),
                hintText: 'name@example.com',
              ),
              validator: (value) {
                if (value is String) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.key),
                  suffixIcon: IconButton(
                    icon: _passwordVisible
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )),
              validator: (value) {
                if (value is String) {
                  if (value.isEmpty) {
                    return 'Please enter a password';
                  }
                }
                return null;
              },
            ),
            _loading
                ? Column(children: const [
                    SizedBox(height: 20),
                    Text("Loading..."),
                    SizedBox(height: 20),
                  ])
                : _error
                    ? Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    : const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                child: const Text('Login'),
                onPressed: () {
                  // It returns true if the form is valid, otherwise returns false
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    _login().then((value) {
                      setState(() {
                        _loading = false;
                        _error = false;
                      });
                      if (_auth.currentUser != null) {
                        Navigator.of(context).pushNamed('/');
                      }
                    }).catchError((e) {
                      setState(() {
                        _loading = false;
                        _error = true;
                      });
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/signup');
                    },
                    child: const Text('Register'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
