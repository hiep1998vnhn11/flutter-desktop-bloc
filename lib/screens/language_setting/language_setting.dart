import 'package:trello/blocs/bloc.dart';
import 'package:trello/configs/config.dart';
import 'package:trello/utils/language.dart';
import 'package:trello/utils/utils.dart';
import 'package:trello/widgets/widget.dart';
import 'package:flutter/material.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({Key? key}) : super(key: key);

  @override
  _LanguageSettingState createState() {
    return _LanguageSettingState();
  }
}

class _LanguageSettingState extends State<LanguageSetting> {
  final textLanguageController = TextEditingController();

  List<Locale> listLanguage = AppLanguage.supportLanguage;
  Locale languageSelected = AppBloc.languageCubit.state;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textLanguageController.dispose();
    super.dispose();
  }

  ///On filter language
  void onFilter(String text) {
    if (text.isEmpty) {
      setState(() {
        listLanguage = AppLanguage.supportLanguage;
      });
      return;
    }
    setState(() {
      listLanguage = listLanguage.where(((item) {
        return UtilLanguage.getGlobalLanguageName(item.languageCode)
            .toUpperCase()
            .contains(text.toUpperCase());
      })).toList();
    });
  }

  ///On change language
  void onChangeLanguage() {
    UtilOther.hiddenKeyboard(context);
    AppBloc.languageCubit.onUpdate(languageSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'change_language',
        ),
        actions: [
          AppButton(
            'Áp dụng',
            onPressed: onChangeLanguage,
            type: ButtonType.text,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 8,
              ),
              child: AppTextInput(
                labelText: 'language',
                hintText: 'search',
                controller: textLanguageController,
                maxLines: 1,
                onChanged: onFilter,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Widget? trailing;
                  final item = listLanguage[index];
                  if (item == languageSelected) {
                    trailing = Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    );
                  }
                  return AppListTitle(
                    title: UtilLanguage.getGlobalLanguageName(
                      item.languageCode,
                    ),
                    trailing: trailing,
                    onPressed: () {
                      setState(() {
                        languageSelected = item;
                      });
                    },
                    border: item != listLanguage.last,
                  );
                },
                itemCount: listLanguage.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
