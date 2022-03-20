import 'package:flutter/material.dart';
import 'package:nicotine/components/single_select.dialog.dart';
import 'package:nicotine/controllers/new_content.controller.dart';
import 'package:nicotine/models/_index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/button/default_primary_button.component.dart';
import 'package:nicotine/components/input/default_text_input.component.dart';
import 'package:nicotine/models/new_content.model.dart';
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
    this.isEdit = false,
    this.tipToEdit,
    this.reportToEdit,
  });

  final bool isTip, isEdit;
  final VoidCallback callback;
  final TipModel? tipToEdit;
  final ReportModel? reportToEdit;

  @override
  _NewContentViewState createState() => _NewContentViewState();
}

class _NewContentViewState extends State<NewContentView> {
  late UserStore _uStore;
  late VicioStore _vStore;
  late bool isTip;
  late bool isEdit;
  NewContentController? _controller;
  NewContentModel? newContent;
  bool loading = false;
  String? reasonImage;
  CategoryModel? category;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() async {
    _uStore = Provider.of<UserStore>(context);
    _vStore = Provider.of<VicioStore>(context);
    isEdit = widget.isEdit;
    isTip = widget.isTip;
    _controller ??= NewContentController();

    if (isEdit) {
      if (isTip) {
        newContent ??= NewContentModel(
          id: widget.tipToEdit!.id,
          idVicio: widget.tipToEdit!.idVicio,
          idCategory: widget.tipToEdit!.idCategory,
          userId: widget.tipToEdit!.userId,
          content: widget.tipToEdit!.content,
          anonimo: widget.tipToEdit!.anonimo,
        );
      } else {
        newContent!.id = widget.reportToEdit!.id;
        newContent!.idVicio = widget.reportToEdit!.idVicio;
        newContent!.idReason = widget.reportToEdit!.idReason;
        newContent!.title = widget.reportToEdit!.title;
        newContent!.userId = widget.reportToEdit!.userId;
        newContent!.content = widget.reportToEdit!.content;
        newContent!.anonimo = widget.reportToEdit!.anonimo;
      }
    } else {
      newContent ??= NewContentModel();
    }
    print(newContent!.toJson());
    super.didChangeDependencies();
    await _initialFetch();
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
                              isTip ? 'Nova dica' : 'Novo relato',
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
                      child: _controller!.isLoading
                          ? Padding(
                              padding: EdgeInsets.only(top: 200.h),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (!isTip)
                                  DefaultTextInputComponent(
                                    title: 'Titulo do relato',
                                    hint: 'Insira o titulo do seu relato',
                                    initialValue: widget.reportToEdit != null
                                        ? widget.reportToEdit!.title
                                        : null,
                                    validate: true,
                                    onSaved: (value) {
                                      if (value!.isNotEmpty) newContent!.title = value.trim();
                                    },
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                                  child: DefaultTextInputComponent(
                                    title: isTip ? 'Dica' : 'Conteúdo',
                                    validate: true,
                                    hint:
                                        isTip ? 'Escreva aqui sua dica' : 'Escreva aqui seu relato',
                                    initialValue: isEdit ? newContent!.content : null,
                                    maxLines: isTip ? 10 : 15,
                                    minLines: 4,
                                    onSaved: (value) {
                                      if (value!.isNotEmpty) newContent!.content = value.trim();
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
                                    value: newContent!.anonimo,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        newContent!.anonimo = !newContent!.anonimo;
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

                                      if (canSave() == '') {
                                        setState(() {
                                          loading = true;
                                        });

                                        newContent!.userId = _uStore.user!.id;
                                        newContent!.idVicio = _vStore.vicio!.id;
                                        newContent!.likes = 0;

                                        if (isTip) {
                                          await ApiProvider().insertNewTip(newContent!).then(
                                                (value) => widget.callback(),
                                              );
                                        } else {
                                          await ApiProvider().insertNewReport(newContent!).then(
                                                (value) => widget.callback(),
                                              );
                                        }

                                        Navigator.of(context).pop();
                                      } else {
                                        ToastUtil.error(canSave());
                                      }
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
                  child: GestureDetector(
                    onTap: _controller!.isLoading
                        ? () {}
                        : () async {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => SingleSelectDialogComponent(
                                selectedOption:
                                    isTip ? newContent!.idCategory : newContent!.idReason,
                                options: isTip
                                    ? _controller!.getCategoriesMap()
                                    : _controller!.getReasonsMap(),
                              ),
                            ))
                                .then((dynamic value) {
                              setState(() {
                                if (isTip) {
                                  newContent!.idCategory = value;
                                  category = _controller!.getCategory(value);
                                } else {
                                  newContent!.idReason = value;
                                  reasonImage = _controller!.getReasonImage(value);
                                }
                              });
                            });
                          },
                    child: CircleAvatar(
                      backgroundColor: category != null ? HexColor(category!.color) : Colors.white,
                      radius: 100.h,
                      backgroundImage: reasonImage != null ? AssetImage(reasonImage!) : null,
                      child: _controller!.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : reasonImage != null
                              ? null
                              : category != null
                                  ? Icon(
                                      category!.icon,
                                      color: Colors.black,
                                      size: 100.h,
                                    )
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
                                          isTip ? 'Selecionar categoria' : 'Selecionar motivo',
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

  String canSave() {
    String result = '';

    if (isTip) {
      result = newContent!.idCategory != 0 ? '' : 'Selecione uma categoria';
    } else {
      result = newContent!.idReason != 0 ? '' : 'Selecione um motivo';
    }

    return result;
  }

  Future<void> _initialFetch() async {
    if (_controller!.isLoading) {
      if (isTip) {
        await _controller!.fetchCategories(_vStore.vicio!.id);
        category = _controller!.getCategory(newContent!.idCategory);
      } else {
        await _controller!.fetchReasons(_vStore.vicio!.id);
      }

      if (_controller!.message != null && _controller!.message != '')
        ToastUtil.error(_controller!.message!);

      if (mounted) setState(() => _controller!.isLoading = false);
    }
  }
}
