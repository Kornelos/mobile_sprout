import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:mobile_sprout/providers/user_provider.dart';
import 'package:mobile_sprout/screens/sign_in_view.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    UserProvider userProvider = Provider.of<UserProvider>(context);

    Widget userWidget = userProvider.getUser() != null ? ListTile(
      leading: GoogleUserCircleAvatar(
        identity: userProvider.getUser()!,
      ),
      title: Text(userProvider.getUser()!.displayName ?? ''),
      subtitle: Text(userProvider.getUser()!.email),
    ): Container();

    return Container(
      child: ListView(children: [
        Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Settings",
              style: _theme.textTheme.headline1,
            )),
        userWidget,
        ListTile(
          title: Text(
            'Dark Mode',
            style: _theme.textTheme.button,
          ),
          trailing: DarkModeSwitch(),
        ),
        ListTile(
          title: Text('Language', style: _theme.textTheme.button),
          trailing: Text('English', style: _theme.textTheme.caption),
        ),
        ListTile(
          title: Text('Log out', style: _theme.textTheme.button),
          trailing: Icon(Icons.logout),
          onTap: ()=>logout(context,userProvider),
        ),
      ]),
    );
  }

  void logout(BuildContext context, UserProvider userProvider) {
    userProvider.logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInView()));
  }
}

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({Key? key}) : super(key: key);

  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool isOn = false;

  void toggleSwitchAndChangeTheme(SettingsProvider provider) {
    setState(() {
      provider.changeTheme();
      isOn = !isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    isOn = settingsProvider.isDarkTheme();
    return Switch(
      value: isOn,
      onChanged: (bool) => {toggleSwitchAndChangeTheme(settingsProvider)},
    );
  }
}
