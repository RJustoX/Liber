import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:nicotine/models/disease.model.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/shared/vicio_avatar.component.dart';
import '../../providers/api.provider.dart';

class HealthView extends StatefulWidget {
  const HealthView();

  @override
  _HealthViewState createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> with SingleTickerProviderStateMixin {
  VicioStore? _vStore;
  late List<dynamic> diseases;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    _vStore ??= Provider.of<VicioStore>(context);
    _initialFetch();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Doenças',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.sp,
          ),
        ),
        actions: <Widget>[
          VicioAvatarComponent(_vStore!.vicio!),
          SizedBox(
            width: 20.0.w,
          )
        ],
      ),
      body: Container(
        color: AppColors.backgroundColor,
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Badge(
                toAnimate: true,
                shape: BadgeShape.square,
                badgeColor: Colors.white,
                borderRadius: BorderRadius.circular(8),
                badgeContent: Text(
                  'Estas são as principais doenças derivadas de seu vicío!',
                  style: TextStyle(
                    color: AppColors.primaryFontColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Scrollbar(
                      child: ListView.separated(
                      itemCount: diseases.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.0,
                      ),
                      itemBuilder: ((context, index) {
                        return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    diseases[index].title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      height: 1.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Casos por ano: ',
                                          style: TextStyle(
                                            color: AppColors.primaryFontColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: diseases[index].cases,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Text(diseases[index].description),
                                  ),
                                  Text(
                                    'Fonte: ${diseases[index].ref}',
                                    style: TextStyle(
                                      color: AppColors.primaryFontColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }),
                    )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initialFetch() async {
    if (isLoading) {
      Map<String, dynamic> map = await ApiProvider().getVicioDiseases(_vStore!.vicio!.id);
      print(map);
      diseases = map['values'].map((dynamic t) {
        return DiseaseModel.fromJson(t as Map<String, dynamic>);
      }).toList();
    }

    if (mounted) setState(() => isLoading = false);
  }
}
