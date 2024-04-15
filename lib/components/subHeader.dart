import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubHeader extends StatelessWidget {
  const SubHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFA1A1A1),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            width: 48,
            height: 48,
            margin: EdgeInsets.only(left: 40, top: 40),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/arrowLeft.svg',
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
    );
  }
}
