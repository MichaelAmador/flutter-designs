import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:designs/src/src.dart';
import 'package:provider/provider.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<ThemeChanger>().theme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Designs on flutter'),
        backgroundColor: appTheme.colorScheme.secondary,
      ),
      body: const _Options(),
      drawer: const _Drawer(),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options();

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<ThemeChanger>().theme;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: routes.length,
      separatorBuilder: (context, index) => Divider(
        color: appTheme.primaryColorLight,
      ),
      itemBuilder: (context, index) => ListTile(
        leading: FaIcon(
          routes[index].icon,
          color: appTheme.colorScheme.secondary,
        ),
        title: Text(routes[index].title),
        trailing: Icon(
          Icons.arrow_forward,
          color: appTheme.colorScheme.secondary,
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => routes[index].screen,
            )),
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<ThemeChanger>();
    final secondaryColor =
        context.watch<ThemeChanger>().theme.colorScheme.secondary;

    return Drawer(
      child: Container(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: secondaryColor,
                  child: const Text(
                    'ML',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
            ),
            const Expanded(child: _Options()),
            ListTile(
              leading: Icon(
                Icons.lightbulb_outline,
                color: secondaryColor,
              ),
              title: const Text('Dark mode'),
              trailing: Switch.adaptive(
                value: appTheme.darkTheme,
                onChanged: (value) => appTheme.darkTheme = value,
                activeColor: secondaryColor,
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.add_to_home_screen_outlined,
                  color: secondaryColor,
                ),
                title: const Text('Custom theme'),
                trailing:
                    // Switch.adaptive(
                    //   value: true,
                    //   onChanged: (value) {},
                    //   activeColor: Colors.blue,
                    // ),
                    CupertinoSwitch(
                  value: appTheme.customTheme,
                  onChanged: (value) => appTheme.customTheme = value,
                  activeColor: secondaryColor,
                )),
          ],
        ),
      ),
    );
  }
}
