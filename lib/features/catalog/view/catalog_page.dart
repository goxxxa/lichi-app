import 'package:flutter/material.dart' hide Size;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_bloc.dart';
import 'package:lichi_app/features/cart/view/cart_page.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_bloc.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_event.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_state.dart';
import 'package:lichi_app/features/catalog/widgets/catalog_item.dart';
import 'package:lichi_app/features/catalog/widgets/empty_list.dart';
import 'package:lichi_app/features/catalog/widgets/segmented_picker.dart';
import 'package:lichi_app/features/catalog/widgets/theme_buttons.dart';
import 'package:lichi_app/ui/widgets/error_page.dart';
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
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
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
  late final int page;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    page = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Каталог товаров'),
              background: ColoredBox(color: Colors.white),
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
                  width: 80,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.shopping_bag, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Каждый день тысячи девушек распаковывают пакеты с новинками Lichi и становятся счастливее, ведь очевидно, что новое платье может изменить день, а с ним и всю жизнь!',
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverToBoxAdapter(child: ThemeButtons()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(child: SimpleSegmentedPicker()),
          BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              return state.when(
                idle: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                processing: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: () => const SliverToBoxAdapter(child: ErrorPage()),
                empty: () => const SliverToBoxAdapter(child: EmptyList()),
                loaded: (data) => SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final i1 = index * 2;
                    final i2 = i1 + 1;
                    if (i1 >= data.length) return null;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CatalogItem(
                              images: data[i1].photos,
                              price: data[i1].price.toString(),
                              title: data[i1].name,
                              sizes: data[i1].sizes,
                              colors: data[i1].colors,
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (i2 < data.length)
                            Expanded(
                              child: CatalogItem(
                                images: data[i2].photos,
                                price: data[i2].price.toString(),
                                title: data[i2].name,
                                sizes: data[i2].sizes,
                                colors: data[i2].colors,
                              ),
                            )
                          else
                            const Spacer(),
                        ],
                      ),
                    );
                  }, childCount: (data.length / 2).ceil()),
                ),
              );
            },
          ),
        ],
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
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        page += 1;
      });
      context.read<CatalogBloc>();
    }
  }
}
