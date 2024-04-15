import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pinotech_cloud/components/subHeader.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hidePassword1 = true;
  bool hidePassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeader(),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 40),
              child: Text(
                "Sign-up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 40, right: 40),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: SvgPicture.asset(
                      'assets/mail.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  hintText: "Username",
                  hintStyle: TextStyle(
                    color: Color(0xFFA1A1A1),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFFA1A1A1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFF27FE75),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(25.0),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 40, right: 40),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: SvgPicture.asset(
                      'assets/mail.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  hintText: "E-mail address",
                  hintStyle: TextStyle(
                    color: Color(0xFFA1A1A1),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFFA1A1A1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFF27FE75),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(25.0),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 40, right: 40),
              child: TextField(
                obscureText: hidePassword1,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: SvgPicture.asset(
                      'assets/lock.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          hidePassword1 = !hidePassword1;
                        });
                      },
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: hidePassword1
                          ? SvgPicture.asset(
                              'assets/eyeOff.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/eye.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                    ),
                  ),
                  hintText: "Create password",
                  hintStyle: TextStyle(
                    color: Color(0xFFA1A1A1),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFFA1A1A1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFF27FE75),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(25.0),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 40, right: 40),
              child: TextField(
                obscureText: hidePassword2,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: SvgPicture.asset(
                      'assets/lock.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          hidePassword2 = !hidePassword2;
                        });
                      },
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: hidePassword2
                          ? SvgPicture.asset(
                              'assets/eyeOff.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/eye.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                    ),
                  ),
                  hintText: "Repeat password",
                  hintStyle: TextStyle(
                    color: Color(0xFFA1A1A1),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFFA1A1A1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFF27FE75),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(25.0),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 40, right: 40),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF27FE75),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Sign-up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
