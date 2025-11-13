import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_event.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_bloc.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_event.dart';

class ErrorPage extends StatelessWidget {
  final String type;
  const ErrorPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Произошла ошибка, пожалуйста, повторите позднее'),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            onPressed: () {
              type == 'catalog'
                  ? context.read<CatalogBloc>().add(LoadInitialProductsData())
                  : context.read<CartBloc>().add(LoadCartItems());
            },
            child: const Text(
              'Повторить',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
