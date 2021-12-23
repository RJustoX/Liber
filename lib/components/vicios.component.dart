import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/components/shared/dialog.component.dart';
import 'package:nicotine/views/home/vicio.view.dart';
import 'package:nicotine/models/vicio.model.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/views/splash_screen.dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViciosComponents extends StatefulWidget {
  const ViciosComponents({
    required this.vicios,
  });
  final List<VicioModel> vicios;

  @override
  State<ViciosComponents> createState() => _ViciosComponentsState();
}

class _ViciosComponentsState extends State<ViciosComponents> {
  @override
  Widget build(BuildContext context) {
    print(widget.vicios.length);
    List<Widget> buildViciosAvatar() {
      List<Widget> result = [
        SizedBox(
          width: 15.w,
        ),
      ];

      for (VicioModel vicio in widget.vicios) {
        result.add(InkWell(
          onTap: () => showDialog(
              context: context,
              builder: (_) {
                return DialogComponent(
                  content: 'Gostaria de acessar o vicio: ${vicio.name}?',
                  confirmAction: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    await sharedPreferences.setInt('vicio', vicio.id);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (_) {
                          return SplashScreenDialog();
                        },
                      ),
                    );
                  },
                );
              }),
          child: CircleAvatar(
            child: Image.asset(vicio.icon!),
            radius: 40.r,
          ),
        ));

        result.add(SizedBox(
          width: 15.w,
        ));
      }
      return result;
    }

    return Row(
      children: [
        ...buildViciosAvatar(),
        if (widget.vicios.length != 3)
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) {
                  return VicioView();
                },
              ),
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 40.r,
              ),
              radius: 40.r,
            ),
          ),
      ],
    );
  }
}
