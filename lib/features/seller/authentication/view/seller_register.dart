import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/constants/color_constants.dart';
import 'package:frontend_ecommerce/features/shared/carousel_model.dart';
import 'package:frontend_ecommerce/features/seller/authentication/view/seller_register_form.dart';
import 'package:frontend_ecommerce/utils/responsive_layout.dart';

import '../../../../common/styles/font_style.dart';
import '../../../shared/star_rating.dart';

class SellerRegister extends StatelessWidget {
  SellerRegister({super.key});
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
               ResponsiveWidget.isSmallScreen(context) ? const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SellerRegisterForm()
                    ],
                  ),
                ),
              )
                  : Expanded(
                child: renderForm(context, 100, 100, 40, 40),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget renderForm(BuildContext context, double startPadding, double endPadding, double topPadding, double bottomPadding){
    return Container(
      padding: EdgeInsetsDirectional.only(start: startPadding, end: endPadding, top: topPadding, bottom: bottomPadding),
      decoration: const BoxDecoration(
          color: AppColors.sellerSignUpBg,
          boxShadow: [
            BoxShadow(color: AppColors.darkBorder)
          ]
      ),
      child: Container(
        color: AppColors.white,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex:   1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: SellerRegisterForm())
                    ],
                  ),
                ),
                if(!ResponsiveWidget.isSmallScreen(context))Expanded(
                  flex:   1,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: slider(context),
                  ),
                ),
              ],),
          ],
        ),
      ),
    );
  }

  Widget slider(BuildContext context){

    final List<CarouselModel> carouseModel = [
      CarouselModel(imgUrl: 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',desc: "We move at a pace that’s unmatched, rolling out new features while others struggle with outdated systems. While they\’re busy fixing legacy issues, we\’re already implementing the next big thing.Our speed gives us the edge in an ever-evolving market.", rating: 5,designation: 'Founder, catalog',orgFeature: 'Web design agency',writerName: 'Sophie Hall'),
      CarouselModel(imgUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',desc: "We operate at lightning speed, launching updates that outpace competitors’ efforts.While they get bogged down in bureaucracy and old designs, we\’re driving innovation forward.This allows us to stay ahead, continually meeting customer needs with fresh, efficient solutions.", rating: 5,designation: 'Founder, catalog',orgFeature: 'Web design agency',writerName: 'Sophie Hall'),
      CarouselModel(imgUrl: 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',desc: "Our team is built for speed, releasing high-impact features while others wrestle with technical debt. While they remain stuck in the past, we’re moving forward with next-gen solutions. This agility allows us to continuously deliver value, faster than anyone else.", rating: 5,designation: 'Founder, catalog',orgFeature: 'Web design agency',writerName: 'Sophie Hall'),
      CarouselModel(imgUrl: 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',desc: "We push boundaries by releasing products at a rate that’s far beyond industry standards.While our competitors are stuck in legacy code, we’re already integrating the future.Our consistent releases set us apart, keeping our users engaged and satisfied.", rating: 5,designation: 'Founder, catalog',orgFeature: 'Web design agency',writerName: 'Sophie Hall'),
      CarouselModel(imgUrl: 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',desc: "We stay ahead of the curve, constantly deploying new features while others deal with inefficiencies.While they're hindered by design debt, we’re driving growth with innovative releases.Our speed keeps us agile and responsive in a fast-paced market.", rating: 5,designation: 'Founder, catalog',orgFeature: 'Web design agency',writerName: 'Sophie Hall')];

    return CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
        viewportFraction: 1.0,
        autoPlay: true,
        enlargeCenterPage: false,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 5)
      ),
      items: carouseModel
          .map((item) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(child: Image.network(item.imgUrl ?? '', fit: BoxFit.cover)),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.3),
                  ],
                  // ignore: prefer_const_literals_to_create_immutables
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Positioned.fill(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(item.desc ?? '', style: FontStyles.labelLarge
                        .copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          StarRating(
                            color: AppColors.white,
                            onRatingChanged: (value){},
                            rating: item.rating?.toDouble() ?? 0,
                            starCount: 5,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(item.writerName ?? '', style: FontStyles.labelLarge
                              .copyWith(color: AppColors.white,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 7,),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.designation ?? '', style: FontStyles.labelMedium
                                    .copyWith(color: AppColors.inActiveBorder)),
                                const SizedBox(height: 5,),
                                Text(item.orgFeature ?? '', style: FontStyles.labelSmall
                                    .copyWith(color: AppColors.inActiveBorder,fontSize: 10)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => _controller.previousPage(),
                                style:  ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(70.0),
                                      ),
                                    ),
                                surfaceTintColor: WidgetStateProperty.all(
                                  AppColors.focusedBorder
                                )),
                                child: const Text('←', style: TextStyle(color: AppColors.darkBorder)),
                              ),
                              const SizedBox(width: 10,),
                              ElevatedButton(
                                onPressed: () => _controller.nextPage(),
                                style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100.0),
                                      ),
                                    ),
                                    surfaceTintColor: WidgetStateProperty.all(
                                        AppColors.focusedBorder
                                    ),
                                ),
                                child: const Text('→', style: TextStyle(color: AppColors.darkBorder),),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                )),
          ],
        ),
      ))
          .toList(),
    );
  }


}
