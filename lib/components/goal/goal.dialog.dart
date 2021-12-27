import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/utils/app_colors.dart';

class GoalDialog extends StatelessWidget {
  const GoalDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0.r),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline,
                        size: 35.r,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 35.r,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'R\$: 325,00',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  child: Text(
                    'Tenis de marca',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Sempre quis comprar este tenis, se eu parar de fumar vou conseguir compra-lo',
                  style: TextStyle(
                    color: AppColors.primaryFontColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 15.h),
                  child: Text(
                    'Conseguira comprar em: 12/10/2022',
                    style: TextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size(0.3.sw, 50.h),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.r),
                              topLeft: Radius.circular(15.r),
                            ),
                          ),
                        ),
                        child: Text(
                          'Ativar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        width: 1,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size(0.3.sw, 50.h),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                          ),
                        ),
                        child: Text(
                          'Concluir',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 5.h,
            left: (0.5.sw - 105.r),
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Container(
                height: 105.r,
                width: 105.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Image.network(
                  'https://cdnv2.moovin.com.br/belinhacalcados/imagens/produtos/det/tenis-nike-843895001-sb-check-solar-d880ea4a6c2100f909a78778c8407bbe.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
