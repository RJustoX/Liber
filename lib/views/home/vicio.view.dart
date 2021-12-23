import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/components/shared/dialog.component.dart';
import 'package:nicotine/controllers/vicio.controller.dart';
import 'package:nicotine/models/vicio.model.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/splash_screen.dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VicioView extends StatefulWidget {
  const VicioView();

  @override
  _VicioViewState createState() => _VicioViewState();
}

class _VicioViewState extends State<VicioView> {
  VicioController? vicioController;
  late UserStore _uStore;

  @override
  void didChangeDependencies() {
    _uStore = Provider.of<UserStore>(context);
    super.didChangeDependencies();
    vicioController ??= VicioController(_uStore);
    initialFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarComponent(
        context,
        title: 'Vícios',
        centerTitle: true,
        haveLeading: true,
      ),
      body: vicioController!.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildViciosWidget(
                  'Meus vícios',
                  vicioController!.getMyVicios(),
                  false,
                ),
                if (vicioController!.getOtherVicios() != null)
                  buildViciosWidget(
                    'Outros vícios',
                    vicioController!.getOtherVicios()!,
                    true,
                  ),
              ],
            ),
    );
  }

  Widget buildViciosWidget(String title, List<VicioModel> vicios, bool add) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                )),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color: HexColor('#707070'),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildVicioTiles(vicios, add),
              ),
            ),
          ],
        ));
  }

  Future<void> initialFetch() async {
    await vicioController!.fetchVicios();

    if (mounted) setState(() => vicioController!.isLoading = false);
  }

  List<Widget> buildVicioTiles(List<VicioModel> vicios, bool add) {
    List<Widget> tiles = [];
    for (VicioModel vicio in vicios) {
      tiles.add(
        GestureDetector(
          onTap: add
              ? () => showDialog(
                  context: context,
                  builder: (_) {
                    return DialogComponent(
                      content: 'Deseja adicionar o vicio: ${vicio.name} ao seu perfil?',
                      confirmAction: () async {
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        setState(() {
                          Navigator.of(context).pop();
                          vicioController!.isLoading = true;
                        });
                        String message = await vicioController!.setNewVicio(vicio.id);
                        await sharedPreferences.setInt('vicio', vicio.id);
                        ToastUtil.success(message);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (_) {
                              return SplashScreenDialog();
                            },
                          ),
                        );
                      },
                    );
                  })
              : () {},
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  SizedBox(height: 50.h, width: 50.w, child: Image.asset(vicio.icon!)),
                  SizedBox(width: 10),
                  Text(
                    vicio.name,
                    style: TextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  if (add)
                    Icon(
                      Icons.add,
                      size: 35.r,
                      color: AppColors.primaryColor,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
      if (vicios.last != vicio)
        tiles.add(
          Divider(
            thickness: 1,
            color: HexColor('#707070'),
          ),
        );
    }
    return tiles;
  }
}
