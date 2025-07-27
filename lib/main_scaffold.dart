import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavItem(
              icon: Icons.home,
              label: 'Home',
              selected: location == '/',
              onTap: () => context.go('/'),
            ),
            _NavItem(
              icon: Icons.search,
              label: 'Search',
              selected: location == '/search',
              onTap: () => context.go('/search'),
            ),
            _NavItem(
              icon: Icons.bookmark_border,
              label: 'Saved',
              selected: location == '/saved',
              onTap: () => context.go('/saved'),
            ),
            _NavItem(
              icon: Icons.person_2_outlined,
              label: 'Profile',
              selected: location == '/profile',
              onTap: () => context.go('/profile'),
            ),
          ],
        ),
      ),

      body: child,
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : Colors.grey;

    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onTap,
      tooltip: label,
    );
  }
}
