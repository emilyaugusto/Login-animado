import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: login_page(),
    );
  }
}

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  String _animationType = 'idle';
  String _correctPassword = 'admin';

  TextEditingController _passwordController = TextEditingController();

  FocusNode _passwordNode = FocusNode();
  FocusNode _emailNode = FocusNode();

  @override
  void initState() {
    this._passwordNode.addListener(() {
      if (this._passwordNode.hasFocus) {
        setState(() => this._animationType = 'hands_up');
      } else {
        setState(() => this._animationType = 'hands_down');
      }
    });

    this._emailNode.addListener(() {
      if (this._emailNode.hasFocus) {
        setState(() => this._animationType = 'test');
      } else {
        setState(() => this._animationType = 'idle');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 50, 56, 1),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            Container(
              height: 300,
              width: 300,
              child: FlareActor(
                "assets/Teddy.flr",
                alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
                animation: this._animationType,
                callback: (currentAnimation) {
                  setState(() => this._animationType = 'idle');
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    focusNode: this._emailNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                  Divider(),
                  TextFormField(
                    focusNode: this._passwordNode,
                    obscureText: true,
                    controller: this._passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Senha",
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    currentFocus.unfocus();

    await Future.delayed(Duration(milliseconds: 300));

    if (_passwordController.text.compareTo(_correctPassword) == 0) {
      setState(() => _animationType = 'success');
    } else {
      setState(() => this._animationType = 'fail');
    }
  }
}
