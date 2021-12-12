import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/views/login.view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileView extends StatefulWidget {
  const ProfileView();

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseStorage _fStorage = FirebaseStorage.instance;
  late UserStore _uStore;
  bool uploading = false, loading = true;
  double percent = 0;
  String? ref;
  late Reference avatar;
  late String avatarUrl;

  @override
  void didChangeDependencies() async {
    _uStore = Provider.of<UserStore>(context);
    super.didChangeDependencies();
    avatar = (await _fStorage.ref('images/${_uStore.user!.nickname}/avatar').listAll()).items.last;

    avatarUrl = await avatar.getDownloadURL();
    setState(() {
      print(avatar.name);
      print(avatar.fullPath);
      loading = false;
    });
  }

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<UploadTask> upload(String path) async {
    File file = File(path);

    try {
      ref = 'images/${_uStore.user!.nickname}/avatar/img-${DateTime.now().toString()}.jpg';
      return _fStorage.ref(ref).putFile(file);
    } on FirebaseException catch (error) {
      throw Exception('Erro no upload ${error.code}');
    }
  }

  pickAndUploadImage() async {
    XFile? file = await getImage();
    if (file != null) {
      UploadTask task = await upload(file.path);

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            percent = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          avatarUrl = await FirebaseStorage.instance.ref(ref).getDownloadURL();

          ApiProvider().changeUserAvatar(_uStore.user!.id, avatarUrl);
          setState(() {
            uploading = false;
            print(_uStore.user!.avatar);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                              FontAwesomeIcons.edit,
                              color: Colors.white,
                              size: 35.r,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35.w, top: 10.h),
                        child: Text(
                          _uStore.user!.nickname,
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
                              '250',
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
                      Row(
                        children: [
                          CircleAvatar(
                            child: Image.asset('assets/vicioLogo/tabagismoLogo.png'),
                            radius: 40.r,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          CircleAvatar(
                            child: Image.asset('assets/vicioLogo/alcolismoLogo.png'),
                            radius: 40.r,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 40.r,
                            ),
                            radius: 40.r,
                          ),
                        ],
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
                              _uStore.user!.name,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              _uStore.user!.email,
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                              'Maior tempo sem fazer uso:',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              '3 dias',
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Recorde de logins consecutivos:',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              '8 dias',
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
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
                onTap: pickAndUploadImage,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      !loading //widget._controller.getUserAvatar() != null && !uploading
                          ? CachedNetworkImageProvider(avatarUrl)
                          : null,
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
                      : _uStore.user!.avatar != null
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
    );
  }
}
