import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/components/bottom_buttons.component.dart';
import 'package:nicotine/components/shared/select_tile.component.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/date.util.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView();

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late UserStore _uStore;
  @override
  void didChangeDependencies() {
    _uStore = Provider.of<UserStore>(context);
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
              hint: _uStore.user!.name,
              inputType: true,
            ),
            SelectTileComponent(
              title: 'Nickname',
              hint: _uStore.user!.nickname,
              inputType: true,
            ),
            SelectTileComponent(
              title: 'Email',
              hint: _uStore.user!.email,
              inputType: true,
            ),
            SelectTileComponent(
              title: 'Data de nascimento',
              hint: DateUtil.dateTimeToString(_uStore.user!.birthDate, dateOnly: true),
              inputType: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonsComponent(
        cancelAction: () {},
        cancelText: 'Voltar',
        confirmAction: () {},
        confirmText: 'Salvar',
      ),
    );
  }
}
