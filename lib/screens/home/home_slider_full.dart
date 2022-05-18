import 'package:tradelait/academy/screens/academy_home.dart';
import 'package:tradelait/assets/screens/assets_home.dart';
import 'package:tradelait/cashflow/screens/cashflow_home.dart';
import 'package:tradelait/expenses/screens/expense_list_screen.dart';
import 'package:tradelait/deposits/screens/deposit_list_screen.dart';
import 'package:tradelait/printing/screens/invoicing_home.dart';
import 'package:tradelait/screens/home/slider_container_full.dart';

import 'package:tradelait/brokers/screens/broker_home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/signals/screens/signal_list_screen.dart';

class HomeSliderFull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      CarouselSlider(
        items: [
          SliderContFull(
            assetImage: AssetImage("assets/page_images/payments.png"),
            sliderText: 'Profitable Signals',
            sliderDescription:
                'Your timely and profitable trade signals for Forex, Crypto, Stocks, etc.',
            screen: SignalListScreen(),
          ),

          SliderContFull(
            assetImage: AssetImage("assets/page_images/brokers.png"),
            sliderText: 'Brokers, \nDeposits & \nWithdrawals',
            sliderDescription:
                'Manage your deposits and withdrawals with your different brokers',
            screen: BrokerHomeScreen(),
          ),

          //3rd Image of Slider
          SliderContFull(
            assetImage: AssetImage("assets/page_images/invoicing.png"),
            sliderText: 'Academy & Training',
            sliderDescription:
                'Learn and equip yourself with practical knowledge in trading forex, crypto, stocks, insurance, etc.',
            screen: AcademyHomeScreen(),
          ),
        ],

        //Slider Container properties
        options: CarouselOptions(
          height: 350.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.6,
        ),
      ),
    ]);
  }
}
