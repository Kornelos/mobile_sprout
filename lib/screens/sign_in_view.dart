import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/providers/user_provider.dart';
import 'package:mobile_sprout/screens/navigation_screen.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  GoogleSignInAccount? _currentUser;



  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(userProvider, _theme),
    ));
  }

  Future<void> _handleSignIn(UserProvider provider) async {
    try {
      var account = await provider.signIn();
      provider.setUser(account!);
    } catch (error) {
      print(error);
    }
  }


  Widget _buildBody(UserProvider userProvider, ThemeData themeData) {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavigationScreen()));
      return Container();
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Mobile Sprout", style: themeData.textTheme.headline1,),
          SignInButton(
            Buttons.Google,
            onPressed: () => _handleSignIn(userProvider),
          ),
        ],
      );
    }
  }
}
