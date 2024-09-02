import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final CarouselSliderController _controller = CarouselSliderController();

  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  int _slideIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        3,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: const SizedBox(
                height: 280,
                child: SharedImageBanner.banner1,
              ),
            ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(padding: EdgeInsets.only(top: 24)),
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            height: 96,
            onPageChanged: (index, reason) {
              setState(() {
                _slideIndex = index;
              });
            },
          ),
          items: pages,
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        AnimatedSmoothIndicator(
          activeIndex: _slideIndex,
          count: pages.length,
          effect: const ExpandingDotsEffect(
              dotHeight: 13, dotWidth: 13, activeDotColor: SharedColors.homerBankPrimaryColor, dotColor: SharedColors.homerBankGreyColor),
        )
      ],
    );
  }
}
