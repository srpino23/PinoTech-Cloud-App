import 'package:flutter/material.dart';

import 'package:pinotech_cloud/api/api.dart';
import 'package:pinotech_cloud/components/GridFileItem.dart';
import 'package:pinotech_cloud/components/ListFileItem.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  bool orderBy = true;
  bool listView = false;

  List<dynamic> files = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final data = await Api.obtenerDatos();
      filterData(data);
      sortFilesByName();
      setState(() {
        loading = false;
      });
    } catch (error) {
      print('Error al obtener los datos: $error');
      setState(() {
        loading = false;
      });
    }
  }

  void filterData(dynamic data) {
    if (data is List) {
      for (var item in data) {
        filterData(item);
      }
    } else if (data is Map) {
      if (data.containsKey('extension')) {
        String extension = data['extension'];
        if (extension == '.png' ||
            extension == '.jpg' ||
            extension == '.jpeg' ||
            extension == '.webp' ||
            extension == '.gif') {
          files.add(data);
        }
      }
      data.values.forEach((value) => filterData(value));
    }
  }

  void sortFilesByName() {
    files.sort((a, b) {
      String nameA = a['name'].toString().toLowerCase();
      String nameB = b['name'].toString().toLowerCase();
      return orderBy ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Photos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        files = [];
                        orderBy = !orderBy;
                        fetchData();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          orderBy
                              ? Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                  size: 38,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: Colors.white,
                                  size: 38,
                                ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF222222),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 34,
                    height: 34,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          listView = !listView;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: listView
                          ? Icon(
                              Icons.grid_view_rounded,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.view_headline_rounded,
                              color: Colors.white,
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
                : listView
                    ? ViewList(fileDataList: files)
                    : ViewGrid(fileDataList: files),
          ],
        ),
      ),
    );
  }
}

class ViewGrid extends StatelessWidget {
  final List<dynamic> fileDataList;

  const ViewGrid({Key? key, required this.fileDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var fileData in fileDataList) {
      widgets.add(GridFileItem(file: fileData));
    }

    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        padding: EdgeInsets.only(top: 0, bottom: 10),
        children: widgets,
      ),
    );
  }
}

class ViewList extends StatelessWidget {
  final List<dynamic> fileDataList;

  const ViewList({Key? key, required this.fileDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var fileData in fileDataList) {
      widgets.add(ListFileItem(file: fileData));
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(children: widgets),
      ),
    );
  }
}
