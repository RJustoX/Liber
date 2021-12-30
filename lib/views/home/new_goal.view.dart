import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicotine/components/bottomSheet/bottom_sheet_row.component.dart';
import 'package:nicotine/components/bottomSheet/bottom_sheet_row_tile.component.dart';
import 'package:nicotine/components/button/default_primary_button.component.dart';
import 'package:nicotine/components/input/default_text_input.component.dart';
import 'package:nicotine/components/input/default_value_input.component.dart';
import 'package:nicotine/models/goal.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/utils/image.util.dart';
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
  XFile? file;
  File? image;
  bool uploading = false, loading = false;
  double percent = 0;
  String? ref;

  @override
  void didChangeDependencies() {
    _uStore = Provider.of<UserStore>(context);
    ref = 'images/${_uStore.user!.id}/goals/img-${DateTime.now().toString()}.jpg';

    if (widget.goal != null)
      newGoal = widget.goal!;
    else
      newGoal = GoalModel();

    super.didChangeDependencies();
  }

  pickAndUploadImage(ImageSource source) async {
    file = await ImageUtil.getImage(source);
    if (file != null) {
      image = File(file!.path);
      UploadTask task = await ImageUtil.upload(file!.path, ref!);

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            percent = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          newGoal.avatar = await FirebaseStorage.instance.ref(ref).getDownloadURL();

          setState(() {
            uploading = false;
          });
        }
      });
    }
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
                            initialValue: widget.goal?.title,
                            validate: true,
                            onSaved: (value) {
                              if (value!.isNotEmpty) newGoal.title = value.trim();
                            },
                          ),
                          const SizedBox(height: 20.0),
                          DefaultTextInputComponent(
                            title: 'Deixe alguma anotação',
                            initialValue: widget.goal?.description,
                            onSaved: (value) {
                              if (value!.isNotEmpty) newGoal.description = value.trim();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: DefaultValueInputComponent(
                              title: 'Valor',
                              initialValue: widget.goal?.value.toString(),
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
                              if (widget.goal == null) {
                                await ApiProvider().insertNewGoal(newGoal).then(
                                      (value) => widget.callback(),
                                    );
                                Navigator.of(context).pop();
                              } else {
                                await ApiProvider().updateGoal(newGoal).then(
                                      (value) => widget.callback(),
                                    );
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                            },
                            title: widget.goal == null ? 'Salvar' : 'Atualizar',
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
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: AppColors.primaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        builder: (BuildContext context) => BottomSheetRowComponent(
                          tiles: <BottomSheetRowTileComponent>[
                            BottomSheetRowTileComponent(
                              title: 'Camera',
                              icon: Icons.camera_alt_outlined,
                              onTap: () => pickAndUploadImage(ImageSource.camera),
                            ),
                            BottomSheetRowTileComponent(
                              title: 'Galeria',
                              icon: Icons.file_copy_sharp,
                              onTap: () => pickAndUploadImage(ImageSource.gallery),
                            ),
                          ],
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100.h,
                      backgroundImage: getPreviewImage(),
                      child: (image != null || widget.goal?.avatar != null)
                          ? SizedBox()
                          : uploading
                              ? Icon(Icons.upload)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.black,
                                      size: 80.h,
                                    ),
                                    Text(
                                      'Adicionar imagem',
                                      style: TextStyle(
                                        color: AppColors.primaryFontColor,
                                        fontWeight: FontWeight.w600,
                                      ),
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

  ImageProvider? getPreviewImage() {
    ImageProvider? result;
    if (image != null) {
      result = FileImage(image!);
    } else if (widget.goal?.avatar != null) {
      result = NetworkImage(widget.goal!.avatar!);
    }

    return result;
  }
}
