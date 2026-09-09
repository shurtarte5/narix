import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class OwnerTab extends StatelessWidget {
  const OwnerTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _WelcomeBanner(colorScheme: colorScheme),
          const SizedBox(height: 32),
          Tooltip(
            message: 'Próximamente',
            child: ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.add),
              label: const Text('Registrar nueva mascota'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: theme.textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Tooltip(
            message: 'Próximamente',
            child: OutlinedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.location_off),
              label: const Text('Reportar mascota perdida'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Mis mascotas',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _EmptyState(
            icon: Icons.pets,
            message: 'Aún no has registrado mascotas',
            hint: 'Cuando registres una, aparecerá aquí con su foto de hocico.',
          ),
        ],
      ),
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.pets, size: 48, color: colorScheme.onPrimaryContainer),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Registra a tu mascota una vez\ny protégela para siempre',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Previews ──────────────────────────────────────────────────────────────────

ThemeData _narixTheme() =>
    ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true);

@Preview(name: 'Owner Tab – Light', size: Size(390, 844))
Widget previewOwnerTabLight() => MaterialApp(
      theme: _narixTheme(),
      home: const Scaffold(body: OwnerTab()),
    );

@Preview(name: 'Owner Tab – Dark', size: Size(390, 844), brightness: Brightness.dark)
Widget previewOwnerTabDark() => MaterialApp(
      theme: _narixTheme(),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const Scaffold(body: OwnerTab()),
    );

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.message,
    required this.hint,
  });

  final IconData icon;
  final String message;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, size: 64, color: Colors.grey[300]),
        const SizedBox(height: 12),
        Text(
          message,
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          hint,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
