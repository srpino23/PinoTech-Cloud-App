import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'package:pinotech_cloud/api/api.dart';
import 'package:pinotech_cloud/components/GridFolderItem.dart';
import 'package:pinotech_cloud/components/GridFileItem.dart';
import 'package:pinotech_cloud/components/ListFolderItem.dart';
import 'package:pinotech_cloud/components/ListFileItem.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({Key? key}) : super(key: key);

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  bool orderBy = true;
  bool listView = false;
  bool viewShare = false;

  List<dynamic> folders = [];
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
      setState(() {
        folders = data['folders'] ?? [];
        files = data['files'] ?? [];
        sortData();
        loading = false;
      });
    } catch (error) {
      print('Error al obtener los datos: $error');
      setState(() {
        loading = false;
      });
    }
  }

  void sortData() {
    folders.sort((a, b) {
      String nameA = a['name'].toString().toLowerCase();
      String nameB = b['name'].toString().toLowerCase();
      return orderBy ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
    });

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
              "Archives",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFF222222),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          viewShare = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            viewShare ? Color(0xFF141414) : Color(0xFF27FE75),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "My Drive",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          viewShare = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            viewShare ? Color(0xFF27FE75) : Color(0xFF141414),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Shared Files",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                        folders = [];
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
                : viewShare
                    ? listView
                        ? ShareViewList(
                            folderDataList: folders, fileDataList: files)
                        : ShareViewGrid(
                            folderDataList: folders, fileDataList: files)
                    : listView
                        ? ViewList(folderDataList: folders, fileDataList: files)
                        : ViewGrid(folderDataList: folders, fileDataList: files)
          ],
        ),
      ),
      floatingActionButton: Container(
        child: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
              showPopover(
                context: context,
                backgroundColor: Color(0xFF222222),
                direction: PopoverDirection.bottom,
                bodyBuilder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 60,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                child: Icon(
                                  Icons.cloud_upload_rounded,
                                  color: Color(0xFF27FE75),
                                  size: 32,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Upload",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 170,
                      child: Divider(
                        color: Colors.grey.shade400,
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                child: Icon(
                                  Icons.create_new_folder_rounded,
                                  color: Colors.blue.shade400,
                                  size: 32,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "New Folder",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 170,
                      child: Divider(
                        color: Colors.grey.shade400,
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                child: Icon(
                                  Icons.insert_drive_file_rounded,
                                  color: Colors.blue.shade200,
                                  size: 32,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "New File",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Color(0xFF27FE75),
            foregroundColor: Colors.white,
            elevation: 5,
            shape: CustomFloatingButton(15),
            child: Icon(Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CustomFloatingButton extends ShapeBorder {
  final double radius;

  const CustomFloatingButton(this.radius);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return CustomFloatingButton(radius * t);
  }
}

class ViewGrid extends StatelessWidget {
  final List<dynamic> folderDataList;
  final List<dynamic> fileDataList;

  const ViewGrid(
      {Key? key, required this.folderDataList, required this.fileDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var folderData in folderDataList) {
      widgets.add(GridFolderItem(folder: folderData));
    }

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
  final List<dynamic> folderDataList;
  final List<dynamic> fileDataList;

  const ViewList(
      {Key? key, required this.folderDataList, required this.fileDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var folderData in folderDataList) {
      widgets.add(ListFolderItem(folder: folderData));
    }

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

class ShareViewGrid extends StatelessWidget {
  final List<dynamic> folderDataList;
  final List<dynamic> fileDataList;

  const ShareViewGrid(
      {Key? key, required this.folderDataList, required this.fileDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var fileData in fileDataList) {
      widgets.add(GridFileItem(file: fileData));
    }

    for (var folderData in folderDataList) {
      widgets.add(GridFolderItem(folder: folderData));
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

class ShareViewList extends StatelessWidget {
  final List<dynamic> folderDataList;
  final List<dynamic> fileDataList;

  const ShareViewList(
      {Key? key, required this.folderDataList, required this.fileDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var fileData in fileDataList) {
      widgets.add(ListFileItem(file: fileData));
    }

    for (var folderData in folderDataList) {
      widgets.add(ListFolderItem(folder: folderData));
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(children: widgets),
      ),
    );
  }
}
