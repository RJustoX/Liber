import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/button/default_primary_button.component.dart';
import 'package:nicotine/components/input/default_text_input.component.dart';
import 'package:nicotine/components/input/default_value_input.component.dart';
import 'package:nicotine/models/goal.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NewGoalView extends StatefulWidget {
  const NewGoalView({
    this.goal,
    required this.callback,
  });

  final GoalModel? goal;
  final VoidCallback callback;

  @override
  _NewGoalViewState createState() => _NewGoalViewState();
}

class _NewGoalViewState extends State<NewGoalView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late GoalModel newGoal;
  late UserStore _uStore;
  bool loading = false;

  @override
  void didChangeDependencies() {
    _uStore = Provider.of<UserStore>(context);

    if (widget.goal != null)
      newGoal = widget.goal!;
    else
      newGoal = GoalModel();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      color: AppColors.primaryColor,
                      height: 250.h,
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 50.r,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 35.w, top: 10.h),
                            child: Text(
                              'Nova meta',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 36.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 120.h, horizontal: 30.w),
                      color: AppColors.backgroundColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DefaultTextInputComponent(
                            title: 'Nome da meta',
                            hint: 'Insira o titulo da sua meta',
                            validate: true,
                            onSaved: (value) {
                              if (value!.isNotEmpty) newGoal.title = value.trim();
                            },
                          ),
                          const SizedBox(height: 20.0),
                          DefaultTextInputComponent(
                            title: 'Deixe alguma anotação',
                            onSaved: (value) {
                              if (value!.isNotEmpty) newGoal.description = value.trim();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: DefaultValueInputComponent(
                              title: 'Valor',
                              onSaved: (String? value) {
                                if (value!.isNotEmpty) newGoal.value = double.parse(value);
                              },
                            ),
                          ),
                          Text(
                            'Ativar meta',
                            style: TextStyle(
                              color: HexColor('#B0B4C0'),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Transform.scale(
                            scale: 1.50,
                            child: Checkbox(
                              value: newGoal.active,
                              onChanged: (bool? value) {
                                setState(() {
                                  newGoal.active = !newGoal.active;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          DefaultPrimaryButtonComponent(
                            loading: loading,
                            onTap: () async {
                              _formKey.currentState!.validate();
                              _formKey.currentState!.save();
                              newGoal.userId = _uStore.user!.id;
                              setState(() {
                                loading = true;
                              });
                              await ApiProvider().insertNewGoal(newGoal).then(
                                    (value) => widget.callback(),
                                  );
                              Navigator.of(context).pop();
                              print(newGoal.toJson());
                            },
                            title: 'Salvar',
                            loadingTitle: 'Salvando',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 150.h,
                left: (0.5.sw - 100.h),
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.h),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                          size: 80.h,
                        ),
                        Text('Adicionar imagem',
                            style: TextStyle(
                              color: AppColors.primaryFontColor,
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
