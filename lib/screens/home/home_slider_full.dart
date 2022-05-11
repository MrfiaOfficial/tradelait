import 'package:tradelait/assets/screens/assets_home.dart';
import 'package:tradelait/cashflow/screens/cashflow_home.dart';
import 'package:tradelait/expenses/screens/expense_list_screen.dart';
import 'package:tradelait/deposits/screens/deposit_list_screen.dart';
import 'package:tradelait/printing/screens/invoicing_home.dart';
import 'package:tradelait/screens/home/slider_container_full.dart';

import 'package:tradelait/brokers/screens/broker_home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSliderFull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      CarouselSlider(
        items: [
          //1st Image of Slider
          SliderContFull(
            assetImage: AssetImage("assets/page_images/students.png"),
            sliderText: 'brokers \n & Payments',
            sliderDescription:
                'Accurate broker Data Management \n With Easy Payment Processing And Recording',
            screen: BrokerHomeScreen(),
          ),

          //2nd Image of Slider
          SliderContFull(
            assetImage: AssetImage("assets/page_images/payments.png"),
            sliderText: 'Expenses & \nExpenditures',
            sliderDescription:
                'Easy Expenses Processing And Recording \n With Detailed Reporting',
            screen: ExpenseListScreen(),
          ),

          //3rd Image of Slider
          SliderContFull(
            assetImage: AssetImage("assets/page_images/invoicing.png"),
            sliderText: 'Invoices \n & Receipts',
            sliderDescription:
                'Seamless Receipt Generation & Printing \n With Smooth Invoicing',
            screen: InvoicingHomeScreen(),
          ),

          //4th Image of Slider

          //5th Image of Slider
          SliderContFull(
            assetImage: AssetImage("assets/page_images/assets.png"),
            sliderText: 'Assets & \nValuation',
            sliderDescription:
                'Comfortable School Assets Management \n With Concise Forecasting Data',
            screen: AssetsHomeScreen(),
          ),

          //6th Image of Slider
          SliderContFull(
            assetImage: AssetImage("assets/page_images/cashflow.png"),
            sliderText: 'Cashflow & \nReporting',
            sliderDescription:
                'Easy Income & Expenditure Reporting \n With Comprehensive Data Reporting',
            screen: CashflowHomeScreen(),
          ),
        ],

        //Slider Container properties
        options: CarouselOptions(
          height: 300.0,
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
