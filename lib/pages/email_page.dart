import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_flutter/pages/login_page.dart';
import 'package:project_flutter/pages/mysql.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  State<EmailPage> createState() => _EmailPage();
}

class _EmailPage extends State<EmailPage> {
  final db = Mysql();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userinfo = prefs.getString('id')!;
    });

    try {
      setState(() {
        final String? userinfo = prefs.getString('id');
        print('확인 $userinfo');
      });
    } catch (e) {}
  }

  void updateEmail() async {
    db.getConnection().then((conn) {
      String sqlQuery = 'update User set email=? where user_id=?';
      conn.query(sqlQuery, [emailController.text, userinfo]);
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('정보를 수정했습니다.'),
          duration: Duration(milliseconds: 700),
        ));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff1160aa),
        centerTitle: true,
        title: const Text(
          '이메일 변경',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          hintText: '이메일',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '다시 입력해주세요';
                          } else if (!value.contains("@") ||
                              !value.contains(".")) {
                            return "유효한 이메일을 입력해주세요";
                          }
                          return null;
                        }),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 50,
                    width: 370,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff1160aa), // Background color
                      ),
                      child: Text('확인'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          toast(context, "수정 완료!");
                          updateEmail();
                          print(userinfo);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toast(BuildContext context, String s) {}
}
