import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omoumaimise_map/infrastructure/supabase/supabase_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(supabaseConfigProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Omoumaimise Map')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello world',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text('Environment: ${config.environment.name}'),
              const SizedBox(height: 24),
              if (!config.isConfigured)
                const Text('Supabase is not configured')
              else
                const _PublishedShopList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PublishedShopList extends ConsumerWidget {
  const _PublishedShopList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shops = ref.watch(publishedShopsProvider);

    return shops.when(
      data: (shops) {
        if (shops.isEmpty) {
          return const Text('No published shops');
        }

        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              final shop = shops[index];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(shop.name),
                subtitle: Text(shop.prefecture),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemCount: shops.length,
          ),
        );
      },
      error: (error, stackTrace) => Text('Failed to load shops: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
