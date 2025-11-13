import 'package:cart_storage_repository/cart_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_event.dart';
import 'package:lichi_app/features/cart/bloc/cart_state.dart' hide LoadedState;
import 'package:lichi_app/features/cart/view/cart_page.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_bloc.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_event.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_state.dart';
import 'package:lichi_app/features/catalog/widgets/catalog_card.dart';
import 'package:lichi_app/features/catalog/widgets/empty_list.dart';
import 'package:lichi_app/features/catalog/widgets/segmented_picker.dart';
import 'package:lichi_app/features/catalog/widgets/theme_buttons.dart';
import 'package:lichi_app/ui/ui.dart';
import 'package:lichi_repository/lichi_repository.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatalogBloc>(
          create: (_) =>
              CatalogBloc(lichiRepository: context.read<LichiRepository>())
                ..add(LoadInitialProductsData()),
        ),
        BlocProvider<CartBloc>(
          create: (_) =>
              CartBloc(storageRepository: context.read<CartStorageRepository>())
                ..add(LoadCartItems()),
        ),
      ],
      child: const CatalogView(),
    );
  }
}

class CatalogView extends StatefulWidget {
  const CatalogView({super.key});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  late final ScrollController _scrollController;
  late final ValueNotifier<int> _currentPageNotifier;
  late final int page;

  @override
  void initState() {
    _scrollController = ScrollController();
    _currentPageNotifier = ValueNotifier<int>(1);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: DefaultTextStyle(
                  style:
                      Theme.of(context).appBarTheme.titleTextStyle ??
                      const TextStyle(color: Colors.white),
                  child: const Text('Каталог товаров'),
                ),
                centerTitle: true,
              ),
              actions: [
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => BlocProvider.value(
                        value: context.read<CartBloc>(),
                        child: CartPage(),
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        int itemCount = 0;
                        state.whenOrNull(
                          loaded: (clothes) => itemCount = clothes.length,
                        );
                        return Row(
                          children: [
                            Text(
                              itemCount.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.shopping_bag,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Text(
                'Каждый день тысячи девушек распаковывают пакеты с новинками Lichi и становятся счастливее, ведь очевидно, что новое платье может изменить день, а с ним и всю жизнь!',
                style: AppStyles.h6,
                textAlign: TextAlign.center,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(child: ThemeButtons()),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(
              child: SegmentedPicker(pageNotifier: _currentPageNotifier),
            ),
            BlocBuilder<CatalogBloc, CatalogState>(
              builder: (context, state) {
                return state.when(
                  idle: () => const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  processing: () => SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  error: () =>
                      SliverToBoxAdapter(child: ErrorPage(type: 'catalog')),
                  empty: () => const SliverToBoxAdapter(child: EmptyList()),
                  loaded: (clothes, category) => SliverList(
                    delegate: SliverChildBuilderDelegate((context, rowIndex) {
                      final rowItems = clothes
                          .skip(rowIndex * 2)
                          .take(2)
                          .toList();
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: CatalogCard(clothes: rowItems[0])),
                            const SizedBox(width: 10),
                            Expanded(child: CatalogCard(clothes: rowItems[1])),
                          ],
                        ),
                      );
                    }, childCount: (clothes.length / 2).ceil()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _currentPageNotifier.value += 1;
      print(_currentPageNotifier.value);
      context.read<CatalogBloc>().add(
        LoadMoreData(
          type: 'dresses',
          page: _currentPageNotifier.value.toString(),
        ),
      );
    }
    ;
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.99);
  }
}
