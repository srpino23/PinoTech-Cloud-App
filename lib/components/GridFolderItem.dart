import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';

class GridFolderItem extends StatefulWidget {
  final Map<String, dynamic> folder;

  final void Function(String folderId) selectFolder;

  const GridFolderItem({
    Key? key,
    required this.folder,
    required this.selectFolder,
  }) : super(key: key);

  @override
  State<GridFolderItem> createState() => _GridFolderItemState();
}

class _GridFolderItemState extends State<GridFolderItem> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    int numberOfFolders = widget.folder['folders'].length;
    int numberOfFiles = widget.folder['files'].length;

    int numberOfItems = numberOfFiles + numberOfFolders;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF222222),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = false;
                });
                widget.selectFolder(widget.folder['_id']['\$oid']);
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
                width: 80,
                height: 80,
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(10),
                child: {
                      0: SvgPicture.asset(
                        'assets/folder.svg',
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      )
                    }[numberOfItems] ??
                    SvgPicture.asset(
                      'assets/filledFolder.svg',
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                            width: 120,
                            child: Text(
                              widget.folder['name'],
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
                            '${numberOfItems} Files',
                            style: TextStyle(
                              color: Color(0xFFA1A1A1),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                isEditing
                    ? Container(
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
          )
        ],
      ),
    );
  }
}
