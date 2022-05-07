import 'package:tradelait/assets/models/asset_model.dart';
import 'package:tradelait/assets/services/asset_service.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/assets/screens/asset_edit_screen.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AssetSingleScreen extends StatelessWidget {
  final String assetUid;
  AssetSingleScreen({required this.assetUid});

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Asset Details',
        ),
      ),
      body: StreamBuilder<AssetModel?>(
        stream: AssetService(uid: currentUser?.uid).streamAsset(assetUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('screen2 ${snapshot.error.toString()}');
            //print(error);
          } else if (snapshot.hasData || snapshot.data != null) {
            var asset = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Palette.firebaseGrey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 10.0,
                        top: 10.0,
                      ),
                      margin: const EdgeInsets.all(10.0),
                      /* child: Expanded(
                        child: (Text('$amount $purpose $date')),
                      ), */
                      child: Column(
                        children: [
                          SizedBox(
                            child: Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      '${asset!.assetName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Asset name'),
                                    leading: Icon(
                                      Icons.house_outlined,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '#${asset.valuePresent}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle:
                                        const Text('Present asset value )'),
                                    leading: Icon(
                                      Icons.wallet_giftcard,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '#${asset.valuePurchased}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle:
                                        const Text('Asset value at purchase)'),
                                    leading: Icon(
                                      Icons.wallet_giftcard,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '#${asset.valueOneYear}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text(
                                        'Asset value in one year time)'),
                                    leading: Icon(
                                      Icons.wallet_giftcard,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '#${asset.valueFiveYears}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text(
                                        'Asset value in five years time)'),
                                    leading: Icon(
                                      Icons.wallet_giftcard,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '#${asset.valueTenYears}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text(
                                        'Asset value in ten years time)'),
                                    leading: Icon(
                                      Icons.wallet_giftcard,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${asset.purpose}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle:
                                        const Text('Purpose of acquisition'),
                                    leading: Icon(
                                      Icons.card_travel_rounded,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${asset.assetGroup}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Asset group'),
                                    leading: Icon(
                                      Icons.manage_accounts_sharp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${asset.assetType}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Asset type'),
                                    leading: Icon(
                                      Icons.person_outlined,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${asset.condition}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle:
                                        const Text('Asset state/condition'),
                                    leading: Icon(
                                      Icons.room_preferences_outlined,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${asset.purchasedDate}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: const Text('Date of asset'),
                                    leading: Icon(
                                      Icons.date_range,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Palette.firebaseWhite,
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text(
                                        'EDIT',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.firebaseNavy,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => AssetEditScreen(
                                          assetUid: asset.assetUid,
                                          currentAssetName:
                                              asset.assetName ?? '',
                                          currentPurpose: asset.purpose ?? '',
                                          currentPurchasedDate:
                                              asset.purchasedDate ?? '',
                                          currentCondition:
                                              asset.condition ?? '',
                                          currentAssetGroup:
                                              asset.assetGroup ?? '',
                                          currentAssetType:
                                              asset.assetType ?? '',
                                          currentValuePurchased:
                                              asset.valuePurchased ?? '',
                                          currentValuePresent:
                                              asset.valuePresent ?? '',
                                          currentValueOneYear:
                                              asset.valueOneYear ?? '',
                                          currentValueFiveYears:
                                              asset.valueFiveYears ?? '',
                                          currentValueTenYears:
                                              asset.valueTenYears ?? '',
                                          createdTimeStamp:
                                              asset.createdTimeStamp ?? '',
                                          credit: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          ;
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Palette.firebaseOrange,
              ),
            ),
          );
        },
      ),
    );
  }
}
