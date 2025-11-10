import 'package:flutter/material.dart' hide Size;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/features/cart/view/cart_page.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_bloc.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_event.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_state.dart';
import 'package:lichi_app/features/catalog/widgets/catalog_item.dart';
import 'package:lichi_app/features/catalog/widgets/empty_list.dart';
import 'package:lichi_app/features/catalog/widgets/segmented_picker.dart';
import 'package:lichi_app/error_page.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CatalogBloc()..add(LoadInitialProductsData()),
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
  late final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // --- AppBar ---
          SliverAppBar(
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Каталог товаров'),
              background: ColoredBox(color: Colors.white),
            ),
            actions: [
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) =>  CartPage(cartItems: []),
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.shopping_bag, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _themeButton('Темная тема', false),
                  const SizedBox(width: 16),
                  _themeButton('Светлая тема', true),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(child: SimpleSegmentedPicker()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
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
                              colors: [],
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
                                colors: [],
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

  Widget _themeButton(String text, bool dark) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: dark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: TextStyle(
            color: dark ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart' hide Size;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lichi_app/cart/view/cart_page.dart';
// import 'package:lichi_app/catalog/bloc/catalog_bloc.dart';
// import 'package:lichi_app/catalog/bloc/catalog_event.dart';
// import 'package:lichi_app/catalog/bloc/catalog_state.dart';
// import 'package:lichi_app/catalog/widgets/catalog_item.dart';
// import 'package:lichi_app/catalog/widgets/segmented_picker.dart';

// class CatalogPage extends StatelessWidget {
//   const CatalogPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CatalogBloc()..add(LoadProductsData()),
//       child: CatalogView(),
//     );
//   }
// }

// class CatalogView extends StatefulWidget {
//   const CatalogView({super.key});

//   @override
//   State<CatalogView> createState() => _CatalogView();
// }

// class _CatalogView extends State<CatalogView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Center(child: Text('Каталог товаров')),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           InkWell(
//             onTap: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute<void>(
//                   builder: (BuildContext context) => const CartPage(),
//                 ),
//               );
//             },
//             borderRadius: BorderRadius.circular(12),
//             child: Container(
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     children: [
//                       Icon(Icons.shopping_bag, color: Colors.white),
//                       const SizedBox(width: 10),
//                       Text(
//                         '1',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 70),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               'Каждый день тысячи девушек распаковывают пакеты с новинками Lichi и становятся счастливее, ведь очевидно, что новое платье может изменить день, а с ним и всю жизнь!',
//               style: const TextStyle(fontSize: 14),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: null,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Темная тема',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               InkWell(
//                 onTap: null,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Светлая тема',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           const SimpleSegmentedPicker(),
//           BlocBuilder<CatalogBloc, CatalogState>(
//             builder: (context, state) {
//               return state.when(
//                 idle: () => const CircularProgressIndicator(),
//                 processing: () => const CircularProgressIndicator(),
//                 loaded: (data) {
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: 3,
//                       itemBuilder: (context, index) {
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             CatalogItem(
//                               image: data[index * 2].image,
//                               price: data[index * 2].currency,
//                               title: data[index * 2].description,
//                               sizes: data[index * 2].sizes,
//                             ),
//                             CatalogItem(
//                               image: data[index * 2 + 1].image,
//                               price: data[index * 2 + 1].currency,
//                               title: data[index * 2 + 1].description,
//                               sizes: data[index * 2 + 1].sizes,
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   );
//                 },
//                 empty: () => const CircularProgressIndicator(),
//                 error: () => Text('error'),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
