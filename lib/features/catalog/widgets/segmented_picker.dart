import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_bloc.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_event.dart';
import 'package:lichi_app/ui/theme/lichi_app_theme.dart';

enum Category {
  all('clothes'),
  dresses('dresses'),
  swimwear('swimsuits'),
  denim('denim'),
  blousesAndTops('blouses_tops'),
  trousers('trousers_jeans'),
  skirts('skirts');

  final String apiName;
  const Category(this.apiName);

  String get displayName {
    switch (this) {
      case Category.all:
        return 'Все';
      case Category.dresses:
        return 'Платья';
      case Category.swimwear:
        return 'Купальники';
      case Category.denim:
        return 'Деним';
      case Category.blousesAndTops:
        return 'Блузы и топы';
      case Category.trousers:
        return 'Брюки';
      case Category.skirts:
        return 'Юбки';
    }
  }
}

class SegmentedPicker extends StatefulWidget {
  const SegmentedPicker({super.key, required this.pageNotifier});

  final ValueNotifier<int> pageNotifier;

  @override
  _SegmentedPickerState createState() => _SegmentedPickerState();
}

class _SegmentedPickerState extends State<SegmentedPicker> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();
    _itemKeys.addAll(List.generate(Category.values.length, (_) => GlobalKey()));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: Category.values.asMap().entries.map((entry) {
                int index = entry.key;
                final isSelected = index == _selectedIndex;
                return GestureDetector(
                  key: _itemKeys[index],
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.pageNotifier.value = 1;
                    _scrollToSelected(index);
                    context.read<CatalogBloc>().add(
                      LoadExactProductsData(type: entry.value.apiName),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(entry.value.displayName, style: AppStyles.h5),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 1,
                          width: isSelected ? 20 : 0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToSelected(int index) {
    final keyContext = _itemKeys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    }
  }
}
