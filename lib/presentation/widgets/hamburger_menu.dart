import 'package:flutter/material.dart';
import 'package:test/data/repositories/supabase_repo.dart';
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
              image: DecorationImage(image: AssetImage("assets/images/drawer0.jpg"), fit: BoxFit.fitHeight, alignment: Alignment.centerLeft),
            ),
            child: SizedBox(), // child: Center(child: Text('Menu', style: TextStyle(fontSize: 30, color: Colors.white))),
          ),
          ListTile(
            title: const Text('Online Recipes'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.ROUTE_ORECIPE),
          ),
          ListTile(
            title: const Text('Online Ingredients'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.ROUTE_OINGREDIENT),
          ),
          ListTile(
            title: const Text('Personal Recipe Book'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.ROUTE_LOCAL),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () => Navigator.of(context).pushNamed(AppRouter.ROUTE_SETTINGS),
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              final SupaRecipeRepository repo = SupaRecipeRepository();
              Navigator.of(context).pushNamed(AppRouter.ROUTE_LOGIN);
              repo.logout();
            },
          ),
        ],
      ),
    );
  }
}
