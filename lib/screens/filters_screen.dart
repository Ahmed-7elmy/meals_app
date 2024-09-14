import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<Filter, bool> activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          customSwitch(
            context,
            'Gluten-free',
            'Only include gluten-free meals.',
            activeFilters[Filter.glutenFree]!,
            (bool value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, value),
          ),
          customSwitch(
            context,
            'Lactose-free',
            'Only include lactose-free meals.',
            activeFilters[Filter.lactoseFree]!,
            (bool value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactoseFree, value),
          ),
          customSwitch(
            context,
            'Vegan',
            'Only include vegan meals.',
            activeFilters[Filter.vegan]!,
            (bool value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegan, value),
          ),
          customSwitch(
            context,
            'Vegetarian',
            'Only include vegetarian meals.',
            activeFilters[Filter.vegeterian]!,
            (bool value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegeterian, value),
          ),
        ],
      ),
    );
  }

  SwitchListTile customSwitch(
    BuildContext context,
    String title,
    String subtitle,
    bool filter,
    Function(bool newValue) onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
      value: filter,
      onChanged: onChanged,
    );
  }
}
