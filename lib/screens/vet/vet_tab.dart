import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class VetTab extends StatelessWidget {
  const VetTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _VetBanner(colorScheme: colorScheme),
          const SizedBox(height: 32),
          Tooltip(
            message: 'Próximamente',
            child: ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.document_scanner),
              label: const Text('Escanear hocico'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: theme.textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Cómo funciona',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const _StepCard(
            step: '1',
            title: 'Apunta la cámara',
            description: 'Enfoca el hocico de la mascota dentro de la silueta guía.',
          ),
          const SizedBox(height: 10),
          const _StepCard(
            step: '2',
            title: 'Narix busca',
            description: 'El servidor compara el hocico con la base de datos en segundos.',
          ),
          const SizedBox(height: 10),
          const _StepCard(
            step: '3',
            title: 'Contacta al dueño',
            description: 'Si hay coincidencia, recibes el nombre y teléfono del dueño.',
          ),
          const SizedBox(height: 40),
          Text(
            'Escaneos recientes',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _EmptyState(
            icon: Icons.search_off,
            message: 'No hay escaneos recientes',
            hint: 'Los escaneos realizados en esta sesión aparecerán aquí.',
          ),
        ],
      ),
    );
  }
}

class _VetBanner extends StatelessWidget {
  const _VetBanner({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.local_hospital, size: 48, color: colorScheme.onSecondaryContainer),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Escanea el hocico,\nencontrá al dueño',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.title,
    required this.description,
  });

  final String step;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              child: Text(step, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Previews ──────────────────────────────────────────────────────────────────

ThemeData _narixTheme() =>
    ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true);

@Preview(name: 'Vet Tab – Light', size: Size(390, 844))
Widget previewVetTabLight() => MaterialApp(
      theme: _narixTheme(),
      home: const Scaffold(body: VetTab()),
    );

@Preview(name: 'Vet Tab – Dark', size: Size(390, 844), brightness: Brightness.dark)
Widget previewVetTabDark() => MaterialApp(
      theme: _narixTheme(),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const Scaffold(body: VetTab()),
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
