import 'package:flutter/material.dart';

class RouteTidakDikenalPage
    extends StatelessWidget {
  final String routeName;

  const RouteTidakDikenalPage({
    super.key,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Route Tidak Dikenal',
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [
              const Icon(
                Icons.error_outline,
                size: 72,
              ),

              const SizedBox(height: 16),

              Text(
                'Route tidak terdaftar',

                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      fontWeight:
                          FontWeight.bold,
                    ),

                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                'Route yang dipanggil: '
                '$routeName',

                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(
                  Icons.arrow_back,
                ),

                label: const Text(
                  'Kembali',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}