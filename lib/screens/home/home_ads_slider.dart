import 'package:tradelait/assets/screens/assets_home.dart';
import 'package:tradelait/cashflow/screens/cashflow_home.dart';
import 'package:tradelait/expenses/screens/expense_list_screen.dart';
import 'package:tradelait/payments/screens/payment_list_screen.dart';
import 'package:tradelait/printing/screens/invoicing_home.dart';
import 'package:tradelait/screens/home/home_ads_cont.dart';
import 'package:tradelait/screens/home/slider_container_full.dart';

import 'package:tradelait/brokers/screens/broker_home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeAdsSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      CarouselSlider(
        items: [
          //1st Image of Slider
          HomeAdsCont(
            assetImage: AssetImage("assets/page_images/brokers.png"),
            sliderText: 'brokers \n & Payments',
            sliderDescription:
                'Accurate broker Data Management \n With Easy Payment Processing And Recording',
            screen: brokerHomeScreen(),
          ),

          //2nd Image of Slider
          HomeAdsCont(
            assetImage: AssetImage("assets/page_images/payments.png"),
            sliderText: 'Expenses & \nExpenditures',
            sliderDescription:
                'Easy Expenses Processing And Recording \n With Detailed Reporting',
            screen: ExpenseListScreen(),
          ),

          //3rd Image of Slider
          HomeAdsCont(
            assetImage: AssetImage("assets/page_images/invoicing.png"),
            sliderText: 'Invoices \n & Receipts',
            sliderDescription:
                'Seamless Receipt Generation & Printing \n With Smooth Invoicing',
            screen: InvoicingHomeScreen(),
          ),

          //4th Image of Slider

          //5th Image of Slider
          HomeAdsCont(
            assetImage: AssetImage("assets/page_images/assets.png"),
            sliderText: 'Assets & \nValuation',
            sliderDescription:
                'Comfortable School Assets Management \n With Concise Forecasting Data',
            screen: AssetsHomeScreen(),
          ),

          //6th Image of Slider
          HomeAdsCont(
            assetImage: AssetImage("assets/page_images/cashflow.png"),
            sliderText: 'Cashflow & \nReporting',
            sliderDescription:
                'Easy Income & Expenditure Reporting \n With Comprehensive Data Reporting',
            screen: CashflowHomeScreen(),
          ),
        ],

        //Slider Container properties
        options: CarouselOptions(
          height: 150.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    ]);
  }
}
