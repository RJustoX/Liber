import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicotine/components/bottomSheet/bottom_sheet_row.component.dart';
import 'package:nicotine/components/bottomSheet/bottom_sheet_row_tile.component.dart';
import 'package:nicotine/components/vicios.component.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:nicotine/providers/firebase.provider.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/utils/image.util.dart';
import 'package:nicotine/views/home/edit_profile.view.dart';
import 'package:nicotine/views/login.view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileView extends StatefulWidget {
  const ProfileView(
    this.callbackMethod,
  );

  final VoidCallback callbackMethod;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserStore? _uStore;
  VicioStore? _vStore;
  bool uploading = false, loading = true;
  double percent = 0;
  String? ref;
  late String avatarUrl;

  @override
  void didChangeDependencies() async {
    _uStore ??= Provider.of<UserStore>(context);
    _vStore ??= Provider.of<VicioStore>(context);
    ref = 'images/${_uStore!.user!.id}/avatar/img-${DateTime.now().toString()}.jpg';

    if (_uStore!.user!.avatar != '') {
      avatarUrl = await FirebaseProvider().getUserAvatar(_uStore!.user!.id);
      setState(() {
        print(avatarUrl);
        loading = false;
      });
    }
    super.didChangeDependencies();
  }

  pickAndUploadImage(ImageSource source) async {
    XFile? file = await ImageUtil.getImage(source);
    if (file != null) {
      UploadTask task = await ImageUtil.upload(
        file.path,
        ref!,
      );

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            percent = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          avatarUrl = await FirebaseStorage.instance.ref(ref).getDownloadURL();

          await ApiProvider().changeUserAvatar(_uStore!.user!.id, avatarUrl);
          setState(() {
            uploading = false;
            print(_uStore!.user!.avatar);
          });
        }
      });
    }
  }

  Future<bool> Function()? _onWillPop() {
    widget.callbackMethod();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    color: AppColors.primaryColor,
                    height: 250.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 50.r,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditProfileView(),
                                  ),
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.userEdit,
                                color: Colors.white,
                                size: 30.r,
                              ),
                              tooltip: 'Editar perfil',
                            ),
                            IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Atenção!'),
                                    content: Text('Quer mesmo sair da sua conta?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancelar')),
                                      TextButton(
                                          onPressed: () async {
                                            SharedPreferences sharedPreferences =
                                                await SharedPreferences.getInstance();
                                            await sharedPreferences.clear();
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) => LoginView(),
                                              ),
                                            );
                                          },
                                          child: Text('Confirmar'))
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                                size: 40.r,
                              ),
                              tooltip: 'Sair da conta',
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 35.w, top: 10.h),
                          child: Text(
                            _uStore!.user!.nickname,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 35.w),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.trophy,
                                size: 22.r,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                '${_vStore!.vicio?.score ?? 0}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 120.h, horizontal: 30.w),
                    color: AppColors.backgroundColor,
                    child: Column(
                      children: <Widget>[
                        ViciosComponents(
                          vicios: _uStore!.user!.vicios!,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 30.0.h),
                          padding: EdgeInsets.all(20.0.r),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _uStore!.user!.name,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.sp,
                                ),
                              ),
                              Text(
                                _uStore!.user!.email,
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 150.h,
                left: (0.5.sw - 100.h),
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

                      //pickAndUploadImage();
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        !loading && !uploading ? CachedNetworkImageProvider(avatarUrl) : null,
                    radius: 100.h,
                    child: uploading
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload,
                                color: Colors.white,
                                size: 60.r,
                              ),
                              Text('Carregando: ${percent.round()}%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ))
                            ],
                          )
                        : _uStore!.user!.avatar != ''
                            ? null
                            : Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 80.h,
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
