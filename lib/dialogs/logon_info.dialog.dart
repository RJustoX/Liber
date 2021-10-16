import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nicotine/controllers/logon.controller.dart';
import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LogonInfoDialog extends StatefulWidget {
  const LogonInfoDialog({
    this.userModel,
  });

  final UserModel? userModel;

  @override
  _LogonInfoDialogState createState() => _LogonInfoDialogState();
}

class _LogonInfoDialogState extends State<LogonInfoDialog> {
  List<String> titles = ['Informações adicionais', 'Informações adicionais', 'Vicios', 'Razões'];
  int currentIndex = 0;
  late String vicioId = '';
  PageController? _pageController;
  late LogonController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LogonController();
    _controller.fetchVicios();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.userModel == null) {}
    _pageController ??= PageController(initialPage: 0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: SizedBox(),
        title: Text(titles[currentIndex]),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: PageView(
          controller: _pageController,
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
                  print(widget.userModel?.birthDate);
                  currentIndex++;
                  _pageController!
                      .nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
                });
              },
              child: Text(
                'Avançar',
                style: TextStyle(
                    color: AppColors.backgroundColor, fontWeight: FontWeight.bold, fontSize: 18.sp),
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
          'Agora precisamos apenas de mais algumas informações para podermos começar XD',
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
                    'Sua data de nascimento:',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  DateTimeField(
                    initialValue: widget.userModel?.birthDate,
                    onChanged: (DateTime? date) {
                      setState(() => widget.userModel?.birthDate = date!);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Clique para inserir',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today)),
                    format: DateFormat('dd/MM/yyyy'),
                    onShowPicker: (BuildContext context, DateTime? currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate:
                            widget.userModel?.birthDate ?? DateTime(DateTime.now().year - 18, 5),
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
                      'Seu sexo:',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                RadioListTile<int>(
                  dense: true,
                  value: 1,
                  activeColor: Theme.of(context).primaryColor,
                  groupValue: widget.userModel?.gender,
                  title: Text(
                    'Masculino',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  onChanged: (int? value) {
                    if (value != null)
                      setState(() {
                        widget.userModel?.gender = value;
                      });
                  },
                ),
                RadioListTile<int>(
                  dense: true,
                  value: 2,
                  activeColor: Theme.of(context).primaryColor,
                  groupValue: 5,
                  title: Text(
                    'Femino',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  onChanged: (int? value) {
                    if (value != null) setState(() {});
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Selecione o vicio que deseja se desvencilhar',
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Flexible(
          flex: 1,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: Colors.white,
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 15.0, right: 10.0, top: index == 0 ? 5.0 : 0),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline),
                        SizedBox(width: 10),
                        Text(_controller.getVicios()[index].name),
                        Spacer(),
                        Radio<String>(
                          value: '${_controller.getVicios()[index].id}',
                          groupValue: '$vicioId',
                          onChanged: (String? value) {
                            setState(() => vicioId = value!);
                          },
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                ),
              )),
        ),
        Spacer(),
      ],
    );
  }

  Widget fourthPage() {
    return Column(
      children: <Widget>[Text('Selecione as razões pelas quais quer se desvencilhar do seu vicio')],
    );
  }
}
