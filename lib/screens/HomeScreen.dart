import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pinotech_cloud/api/api.dart';
import 'package:pinotech_cloud/components/RoundedProgressBar.dart';
import 'package:pinotech_cloud/components/ListFileItem.dart';
import 'package:pinotech_cloud/screens/AccountScreen.dart';
import 'package:pinotech_cloud/screens/HelpScreen.dart';

class HomeScreen extends StatefulWidget {
  final void Function() logOut;
  final void Function(int) goShare;

  const HomeScreen({Key? key, required this.logOut, required this.goShare})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {};
  List<dynamic> files = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      data = await Api.obtenerDatos();
      setState(() {
        files = data['files'] ?? [];
        loading = false;
      });
    } catch (error) {
      print('Error al obtener los datos: $error');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Color(0xFF222222),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              painter: RoundedProgressBarPainter(
                                backgroundColor: Color(0xFF149643),
                                valueColor: Color(0xFF27FE75),
                                value: 0.8,
                                strokeWidth: 10,
                              ),
                              child: Container(
                                width: 70,
                                height: 70,
                              ),
                            ),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..scale(-1.0, 1.0, 1.0),
                              child: Text(
                                "80%",
                                style: TextStyle(
                                  color: Color(0xFF27FE75),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Avalible Storage",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "409 GB / 512 GB",
                            style: TextStyle(
                              color: Color(0xFFA1A1A1),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF222222),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: EdgeInsets.all(30),
                          child: Icon(
                            Icons.help_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF222222),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          widget.goShare(1);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: EdgeInsets.all(30),
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF222222),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AccountScreen(logOut: widget.logOut),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: EdgeInsets.all(30),
                          child: SvgPicture.asset(
                            'assets/account.svg',
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Recent files",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ViewList(
                    fileDataList: files,
                  ),
                ),
        ],
      ),
    );
  }
}

class ViewList extends StatelessWidget {
  final List<dynamic> fileDataList;

  const ViewList({
    Key? key,
    required this.fileDataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var fileData in fileDataList) {
      widgets.add(ListFileItem(file: fileData));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: widgets),
      ),
    );
  }
}
