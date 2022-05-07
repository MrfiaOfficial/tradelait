import 'package:tradelait/assets/screens/assets_home.dart';
import 'package:tradelait/cashflow/screens/cashflow_home.dart';
import 'package:tradelait/payments/screens/payment_list_screen.dart';
import 'package:tradelait/printing/screens/invoicing_home.dart';
import 'package:tradelait/screens/home/slider_container.dart';

import 'package:tradelait/students/screens/student_list_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      CarouselSlider(
        items: [
          //1st Image of Slider
          SliderCont(
            assetImage: AssetImage("assets/tradelait_slider_student.png"),
            sliderText: 'Students',
            sliderDescription: 'Accurate Student Data Management',
            screen: StudentListScreen(),
          ),

          //2nd Image of Slider
          SliderCont(
            assetImage: AssetImage("assets/tradelait_slider_payments.png"),
            sliderText: 'Payments',
            sliderDescription: 'Easy Payment Processing and Recording',
            screen: PaymentListScreen(),
          ),

          //3rd Image of Slider
          SliderCont(
            assetImage: AssetImage("assets/tradelait_slider_invoicing.png"),
            sliderText: 'Invoicing',
            sliderDescription: 'Seamless Receipt Generation & Printing',
            screen: InvoicingHomeScreen(),
          ),

          //4th Image of Slider
          SliderCont(
            assetImage: AssetImage("assets/tradelait_slider_cashflow.png"),
            sliderText: 'Cashflow',
            sliderDescription: 'Easy Income & Expenditure Reporting',
            screen: CashflowHomeScreen(),
          ),

          //5th Image of Slider
          /* SliderCont(
            assetImage: AssetImage("assets/tradelait_slider_staff.png"),
            sliderText: 'Staff',
            sliderDescription: 'Effective Staff Records Management',
            screen: StaffHomeScreen(),
          ),
 */
          //6th Image of Slider
          SliderCont(
            assetImage: AssetImage("assets/tradelait_slider_assets.png"),
            sliderText: 'Assets',
            sliderDescription: 'Comfortable School Assets Management',
            screen: AssetsHomeScreen(),
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
