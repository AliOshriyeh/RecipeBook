import 'package:flutter/material.dart';
import 'package:test/presentation/router/app_router.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Online Recipes'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.ROUTE_ONLINE),
          ),
          ListTile(
            title: const Text('Personal Recipe Book'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.ROUTE_LOCAL),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.ROUTE_SETTINGS),
          ),
        ],
      ),
    );
  }
}
