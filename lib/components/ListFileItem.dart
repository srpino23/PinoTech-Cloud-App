import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';

import 'package:pinotech_cloud/screens/FileScreen.dart';

class ListFileItem extends StatefulWidget {
  final Map<String, dynamic> file;

  const ListFileItem({Key? key, required this.file}) : super(key: key);

  @override
  State<ListFileItem> createState() => _ListFileItemState();
}

class _ListFileItemState extends State<ListFileItem> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    String sizeBytesString = widget.file['size'];
    double sizeBytes = double.parse(sizeBytesString);
    double sizeMb = sizeBytes / (1024 * 1024);

    String displaySize;
    if (sizeBytes < 1024 * 1024) {
      displaySize = '${(sizeBytes / 1024).toStringAsFixed(2)} KB';
    } else if (sizeBytes < 1024 * 1024 * 1024) {
      displaySize = '${sizeMb.toStringAsFixed(2)} MB';
    } else {
      displaySize = '${(sizeMb / 1024).toStringAsFixed(2)} GB';
    }

    bool isImageExtension(String extension) {
      final imageExtensions = ['.png', '.jpg', '.jpeg', '.webp', '.gif'];
      return imageExtensions.contains(extension.toLowerCase());
    }

    String extension = widget.file['extension'];
    bool isImage = isImageExtension(extension);

    return Container(
      width: double.infinity,
      height: 70,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xFF222222),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isEditing = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FileScreen(file: widget.file),
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
          padding: EdgeInsets.only(left: 10, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: isImage
                          ? DecorationImage(
                              image: NetworkImage(widget.file['rute']),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: isImage ? null : Color(0xFF141414),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    padding: EdgeInsets.all(10),
                    child: isImage
                        ? SizedBox(height: 10)
                        : SvgPicture.asset(
                            'assets/document.svg',
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  isEditing
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "New name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  isDense: true,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 170,
                              child: Text(
                                widget.file['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              displaySize,
                              style: TextStyle(
                                color: Color(0xFFA1A1A1),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                ],
              ),
              isEditing
                  ? Container(
                      width: 48,
                      height: 48,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isEditing = false;
                          });
                        },
                        child: Center(
                          child: Icon(
                            Icons.save_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 48,
                      height: 48,
                      child: Builder(
                        builder: (context) => GestureDetector(
                          onTap: () {
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 32,
                                              height: 32,
                                              child: Icon(
                                                Icons.share,
                                                color: Colors.blue.shade200,
                                                size: 32,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Share",
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
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          isEditing = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 32,
                                              height: 32,
                                              child: Icon(
                                                Icons.edit_rounded,
                                                color: Colors.blue.shade400,
                                                size: 32,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Edit Name",
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 32,
                                              height: 32,
                                              child: SvgPicture.asset(
                                                'assets/remove.svg',
                                                colorFilter: ColorFilter.mode(
                                                  Color(0xFFFE272F),
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Delete",
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
                          child: Center(
                            child: Text(
                              "•••",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
