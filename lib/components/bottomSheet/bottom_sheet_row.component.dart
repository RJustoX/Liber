import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/components/bottomSheet/bottom_sheet_row_tile.component.dart';

class BottomSheetRowComponent extends StatelessWidget {
  const BottomSheetRowComponent({
    required this.tiles,
  });

  final List<BottomSheetRowTileComponent> tiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: tiles,
      ),
    );
  }
}
