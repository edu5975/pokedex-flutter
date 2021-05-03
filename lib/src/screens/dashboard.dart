import 'package:flutter/material.dart';
import 'package:pokedex/src/utils/configuration.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Configuration.colorHeader,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Configuration.colorHeader,
              ),
              accountName: Text('Eduardo'),
              accountEmail: Text('17030434@itcelaya.edu.mx'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://assets.turbologo.com/blog/fr/2019/10/19134208/spiderman-logo-illustration-958x575.jpg'),
              ),
              onDetailsPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.trending_up,
                color: Configuration.colorIcons,
              ),
              title: Text('Pokedex'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/pokedex');
              },
              trailing: Icon(
                Icons.chevron_right,
                color: Configuration.colorIcons,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
