import 'package:trello/blocs/bloc.dart';
import 'package:trello/configs/config.dart';
import 'package:trello/models/model.dart';
import 'package:trello/utils/utils.dart';
import 'package:trello/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On login
  Future<void> onLogin() async {
    AppBloc.signCubit.onLogin(username: '', password: '');
  }

  ///On QR Scan Login
  void onLoginByCode() async {
    final result = await Navigator.pushNamed(context, Routes.qrScan);
    if (result != null) {
      AppBloc.signCubit.onLoginByToken(result as String);
    }
  }

  ///On Privacy
  void onPrivacy() {
    Navigator.pushNamed(
      context,
      Routes.webView,
      arguments: WebViewModel(
        title: 'privacy',
        url: "https://saleboltapp.com/privacy-policy.html",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignCubit, SignState>(
        builder: (context, login) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                      image: AssetImage(Images.icon),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'SaleBolt',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Text(
                                    'Tìm kiếm doanh số bán hàng mới cho Envato Market Author.',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                AppButton(
                                  'Đăng nhập bằng Envato',
                                  icon: Image.asset(
                                    Images.envato,
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: onLogin,
                                  type: ButtonType.outline,
                                  loading: login == SignState.signIn,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ứng dụng này được cung cấp bởi Envato API và sẽ không lưu trữ tên người dùng và mật khẩu của bạn.',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      AppButton(
                        'privacy',
                        onPressed: onPrivacy,
                        mainAxisSize: MainAxisSize.max,
                        type: ButtonType.text,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Theme.of(context).cardColor,
                    child: Icon(
                      Icons.qr_code_scanner_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: onLoginByCode,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
