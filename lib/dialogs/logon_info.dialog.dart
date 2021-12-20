import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/controllers/logon.controller.dart';
import 'package:nicotine/models/vicio.model.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/main.view.dart';
import 'package:provider/provider.dart';

class LogonInfoDialog extends StatefulWidget {
  const LogonInfoDialog();

  @override
  _LogonInfoDialogState createState() => _LogonInfoDialogState();
}

class _LogonInfoDialogState extends State<LogonInfoDialog> {
  List<String> titles = ['Informações adicionais', 'Informações adicionais', 'Vicios', 'Razões'];
  DateFormat _format = DateFormat('dd/MM/yyyy');
  int currentIndex = 0;
  late String vicioId = '';
  PageController? _pageController;
  late LogonController _controller;
  late UserStore _uStore;

  Future<void> _initialFetch() async {
    try {
      await _controller.fetchVicios();
    } catch (error) {
      ToastUtil.error(error.toString());
      print(error.toString());
    }

    if (mounted) setState(() => _controller.loading = false);
  }

  @override
  void initState() {
    super.initState();
    _controller = LogonController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _uStore = Provider.of<UserStore>(context);
    _initialFetch();

    _pageController ??= PageController(initialPage: 0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: SizedBox(),
        title: Text(
          titles[currentIndex],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.sp),
        ),
        centerTitle: true,
      ),
      body: _controller.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  firstPage(),
                  secondPage(),
                  thirdPage(),
                  fourthPage(),
                ],
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            if (currentIndex != 0)
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: Size(150.w, 50.0.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    currentIndex--;
                    _pageController!
                        .previousPage(duration: Duration(milliseconds: 250), curve: Curves.easeIn);
                  });
                },
                child: Text(
                  'Voltar',
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ),
            Spacer(),
            if (!_controller.loading)
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:
                      canStepUp() ? AppColors.primaryColor : AppColors.primaryFontColor,
                  minimumSize: Size(150.w, 50.0.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: canStepUp()
                    ? currentIndex != 3
                        ? () {
                            setState(() {
                              currentIndex++;
                              _pageController!.nextPage(
                                  duration: Duration(milliseconds: 250), curve: Curves.easeOut);
                            });
                          }
                        : () async {
                            await _controller
                                .finalizaCadastro(_uStore.user!, int.parse(vicioId))
                                .then(
                              (_) {
                                ToastUtil.success('Seja bem vindo!');
                                return Navigator.of(context).pushReplacement(
                                  MaterialPageRoute<void>(
                                    builder: (_) {
                                      return MainView();
                                    },
                                  ),
                                );
                              },
                            );
                          }
                    : () {},
                child: Text(
                  currentIndex != 3 ? 'Avançar' : 'Confirmar',
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget firstPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Antes de continuar precisamos de mais algumas informações sobre você, mas é rapidinho.',
          style: TextStyle(
            color: HexColor('#6A7188'),
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        SizedBox(
          height: 300.h,
          width: 400.w,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    'Quando você nasceu?',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: HexColor('#6A7188').withOpacity(0.8),
                    ),
                  ),
                  Spacer(),
                  DateTimeField(
                    initialValue: _uStore.user?.birthDate,
                    autocorrect: true,
                    onChanged: (DateTime? date) {
                      setState(() => _uStore.user!.birthDate = date!);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Clique para inserir',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(FontAwesomeIcons.calendarAlt)),
                    format: _format,
                    onShowPicker: (BuildContext context, DateTime? currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate:
                            _uStore.user!.birthDate ?? DateTime(DateTime.now().year - 18, 5),
                        lastDate: DateTime(DateTime.now().year - 18, 5, 30),
                        errorInvalidText: 'Data inválida',
                      );
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget secondPage() {
    return Center(
      child: SizedBox(
        height: 300.h,
        width: 400.w,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Qual seu sexo:',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: HexColor('#6A7188').withOpacity(0.8),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text(
                                'Por questões biológicas precisamos saber seu sexo de nascimento. esperamos que compreenda :)'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Entendi'))
                            ],
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                RadioListTile<int>(
                  contentPadding: EdgeInsets.all(0),
                  dense: true,
                  value: 1,
                  activeColor: Theme.of(context).primaryColor,
                  groupValue: _uStore.user?.gender,
                  title: Text(
                    'Masculino',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  onChanged: (int? value) {
                    if (value != null)
                      setState(() {
                        _uStore.user!.gender = value;
                      });
                  },
                ),
                RadioListTile<int>(
                  contentPadding: EdgeInsets.all(0),
                  dense: true,
                  value: 2,
                  activeColor: Theme.of(context).primaryColor,
                  groupValue: _uStore.user?.gender,
                  title: Text(
                    'Feminino',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  onChanged: (int? value) {
                    if (value != null)
                      setState(() {
                        _uStore.user!.gender = value;
                      });
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget thirdPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Qual vício gostaria de se desvencilhar?',
          style: TextStyle(
            color: AppColors.primaryFontColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Você poderá escolher outros vícios depois.',
          style: TextStyle(
            color: AppColors.primaryFontColor,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 0.2.sh,
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                color: HexColor('#707070'),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildVicioTiles(),
            ),
          ),
        ),
      ],
    );
  }

  Widget fourthPage() {
    return Column(
      children: <Widget>[
        Text(
          'Por qual razão gostaria de desvencilhar deste vicio?',
          style: TextStyle(
            color: AppColors.primaryFontColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Text(
          'Em Breve!',
          style: TextStyle(
            color: AppColors.primaryFontColor,
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(),
      ],
    );
  }

  List<Widget> buildVicioTiles() {
    List<Widget> tiles = [];
    int lenght = _controller.getVicios().length;
    for (VicioModel vicio in _controller.getVicios()) {
      tiles.add(
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Row(
              children: [
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
                Radio<String>(
                  value: '${vicio.id}',
                  groupValue: '$vicioId',
                  onChanged: (String? value) {
                    setState(() => vicioId = value!);
                  },
                ),
              ],
            ),
          ),
        ),
      );
      if (vicio.id != lenght)
        tiles.add(
          Divider(
            thickness: 1,
            color: HexColor('#707070'),
          ),
        );
    }
    return tiles;
  }

  bool canStepUp() {
    bool result = false;
    switch (currentIndex) {
      case 0:
        result = _uStore.user!.birthDate != null;
        break;
      case 1:
        result = _uStore.user!.gender != null;
        break;
      case 2:
        result = vicioId != '';
        break;
      case 3:
        result = true;
        break;
    }
    return result;
  }
}
