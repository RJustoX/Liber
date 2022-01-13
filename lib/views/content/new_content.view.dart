import 'package:flutter/material.dart';
import 'package:nicotine/components/single_select.dialog.dart';
import 'package:nicotine/controllers/new_content.controller.dart';
import 'package:nicotine/models/_index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/button/default_primary_button.component.dart';
import 'package:nicotine/components/input/default_text_input.component.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:provider/provider.dart';

class NewContentView extends StatefulWidget {
  const NewContentView({
    required this.isTip,
    required this.callback,
  });

  final bool isTip;
  final VoidCallback callback;

  @override
  _NewContentViewState createState() => _NewContentViewState();
}

class _NewContentViewState extends State<NewContentView> {
  late UserStore _uStore;
  late VicioStore _vStore;
  NewContentController? _controller;
  ReportModel? newReport;
  bool loading = false;
  String? reasonImage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _uStore = Provider.of<UserStore>(context);
    _vStore = Provider.of<VicioStore>(context);
    _controller ??= NewContentController();
    newReport ??= ReportModel();
    super.didChangeDependencies();
    _initialFetch();
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
                      child: _controller!.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
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
                                    widget.isTip ? 'Nova dica' : 'Novo relato',
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
                          if (!widget.isTip)
                            DefaultTextInputComponent(
                              title: 'Titulo do relato',
                              hint: 'Insira o titulo do seu relato',
                              validate: true,
                              onSaved: (value) {
                                if (value!.isNotEmpty) newReport!.title = value.trim();
                              },
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: DefaultTextInputComponent(
                              title: widget.isTip ? 'Dica' : 'Conteúdo',
                              validate: true,
                              hint: widget.isTip
                                  ? 'Escreva aqui sua dica'
                                  : 'Escreva aqui seu relato',
                              onSaved: (value) {
                                if (value!.isNotEmpty) newReport!.content = value.trim();
                              },
                            ),
                          ),
                          Text(
                            'Publicar como anônimo',
                            style: TextStyle(
                              color: HexColor('#B0B4C0'),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Transform.scale(
                            scale: 1.50,
                            child: Checkbox(
                              value: newReport!.anonimo,
                              onChanged: (bool? value) {
                                setState(() {
                                  newReport!.anonimo = !newReport!.anonimo;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          DefaultPrimaryButtonComponent(
                            loading: loading,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                newReport!.userId = _uStore.user!.id;
                                newReport!.idVicio = _vStore.vicio!.id;
                                newReport!.likes = 0;

                                setState(() {
                                  loading = true;
                                });

                                await ApiProvider().insertNewReport(newReport!).then(
                                      (value) => widget.callback(),
                                    );
                                Navigator.of(context).pop();
                              }
                            },
                            title: 'Publicar',
                            loadingTitle: 'Publicando',
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
                  child: _controller!.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () async {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => SingleSelectDialogComponent(
                                selectedOption: newReport!.idReason,
                                options: _controller!.getReasonsMap(),
                              ),
                            ))
                                .then((dynamic value) {
                              setState(() {
                                newReport!.idReason = value;
                                reasonImage = _controller!.getReasonImage(value);
                              });
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100.h,
                            backgroundImage: reasonImage != null ? AssetImage(reasonImage!) : null,
                            child: reasonImage != null
                                ? null
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.icons,
                                        color: AppColors.primaryFontColor,
                                        size: 80.h,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        widget.isTip ? 'Selecionar categoria' : 'Selecionar motivo',
                                        style: TextStyle(
                                            color: AppColors.primaryFontColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.sp),
                                      ),
                                    ],
                                  ),
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

  Future<void> _initialFetch() async {
    await _controller!.fetchCategories(_vStore.vicio!.id);
    await _controller!.fetchReasons(_vStore.vicio!.id);

    if (_controller!.message != null && _controller!.message != '')
      ToastUtil.error(_controller!.message!);

    if (mounted) setState(() => _controller!.isLoading = false);
  }
}
