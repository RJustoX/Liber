import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/components/bottom_buttons.component.dart';
import 'package:nicotine/components/input/text_input.dialog.dart';
import 'package:nicotine/components/shared/select_tile.component.dart';
import 'package:nicotine/models/_index.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/date.util.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/splash_screen.dialog.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView();

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late UserStore _uStore;
  late UserModel _updateUser;

  @override
  void didChangeDependencies() {
    _uStore = Provider.of<UserStore>(context);
    _updateUser = UserModel(
      id: _uStore.user!.id,
      name: _uStore.user!.name,
      email: _uStore.user!.email,
      nickname: _uStore.user!.nickname,
      birthDate: _uStore.user!.birthDate,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: DefaultAppBarComponent(
        context,
        title: 'Editar perfil',
        centerTitle: true,
        haveLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: <Widget>[
            SelectTileComponent(
              title: 'Nome',
              hint: _updateUser.name,
              inputType: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<String?>(builder: (_) {
                    return InputDialogComponent(
                      title: 'Nome',
                      hint: '',
                      value: _updateUser.name,
                    );
                  }),
                ).then((String? value) {
                  if (value != null) {
                    setState(() {
                      _updateUser.name = value;
                    });
                  }
                });
              },
            ),
            SelectTileComponent(
              title: 'Nickname',
              hint: _updateUser.nickname,
              inputType: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<String?>(builder: (_) {
                    return InputDialogComponent(
                      title: 'Nickname',
                      hint: '',
                      value: _updateUser.nickname,
                    );
                  }),
                ).then((String? value) {
                  if (value != null) {
                    setState(() {
                      _updateUser.nickname = value;
                    });
                  }
                });
              },
            ),
            SelectTileComponent(
              title: 'Email',
              hint: _updateUser.email,
              inputType: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<String?>(builder: (_) {
                    return InputDialogComponent(
                      title: 'Email',
                      hint: '',
                      value: _updateUser.email,
                    );
                  }),
                ).then((String? value) {
                  if (value != null) {
                    setState(() {
                      _updateUser.email = value;
                    });
                  }
                });
              },
            ),
            SelectTileComponent(
              title: 'Data de nascimento',
              hint: DateUtil.dateTimeToString(_updateUser.birthDate, dateOnly: true),
              inputType: true,
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: _uStore.user!.birthDate ?? DateTime(DateTime.now().year - 18, 5),
                  lastDate: DateTime(DateTime.now().year - 18, 5, 30),
                  errorInvalidText: 'Data inválida',
                ).then(
                  (DateTime? date) {
                    setState(() => _updateUser.birthDate = date!);
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonsComponent(
        cancelAction: () {
          Navigator.of(context).pop();
        },
        cancelText: 'Voltar',
        confirmAction: () async {
          Map<String, dynamic> map = await ApiProvider().updateUserData(_updateUser);
          ToastUtil.success(map['message']);

          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (_) {
                return SplashScreenDialog();
              },
            ),
          );
        },
        confirmText: 'Salvar',
      ),
    );
  }
}
