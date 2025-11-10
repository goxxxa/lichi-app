// import 'package:flutter/material.dart';

import 'package:flutter/material.dart' hide Size;
import 'package:lichi_api/lichi_api.dart';

class CatalogItem extends StatefulWidget {
  final List<Photo> images;
  final String price;
  final String title;
  final List<Color> colors;
  final List<Size> sizes;

  const CatalogItem({
    super.key,
    required this.images,
    required this.price,
    required this.title,
    required this.colors,
    required this.sizes,
  });

  @override
  State<CatalogItem> createState() => _CatalogItemState();
}

class _CatalogItemState extends State<CatalogItem> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: SizedBox(
                height: 260,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: widget.images.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.images[index].thumbs.small,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        width: 52,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.images.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    '${widget.price} руб.',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.colors
                        .map(
                          (color) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black12),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (BuildContext context) {
            return FractionallySizedBox(
              heightFactor: 0.5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Выберите размер'),
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var text;
                          if (widget.sizes[index].amount == 0) {
                            text = 'Нет в наличии';
                          } else {
                            text = widget.sizes[index].amount.toString();
                          }
                          ;
                          return Text('${widget.sizes[index].name} $text');
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 5);
                        },
                        itemCount: widget.sizes.length,
                      ),
                    ),
                    Text('Как подобрать размер?'),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          showTopSnack(
                            context,
                            'Товар успешно добавлен в корзину!',
                          );
                        },
                        child: const Text(
                          'Добавить в корзину',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

void showTopSnack(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 2), () => entry.remove());
}
