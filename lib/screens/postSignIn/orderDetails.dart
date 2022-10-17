

import 'package:ecowise_vendor_v2/UI/snackBar.dart';
import 'package:ecowise_vendor_v2/Utils/constants.dart';
import 'package:ecowise_vendor_v2/services/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:slider_button/slider_button.dart';

class OrderDetails extends StatefulWidget {
  var order;

  //const OrderDetails({Key?key}) : super(key: key);
  OrderDetails(this.order);

  @override
  _OrderDetailsState createState() => _OrderDetailsState(order);
}

class _OrderDetailsState extends State<OrderDetails> {
  var order;
  String items = "";

  _OrderDetailsState(this.order);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    order['items'].forEach((e){
      items += e['item_name'];
      items += ", ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context, false);
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: SizeConfig.heightPercent * 75,
                  width: SizeConfig.width,
                  //color: AppTheme().primaryColor,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme().gradientColor1,
                            AppTheme().gradientColor2,
                          ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Customer Name: ",
                              style:
                              AppTheme().buildTitleStyle1(15, AppTheme().textColor),
                            ),
                            Expanded(
                              child: Text(
                                "Sriraj",
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme()
                                    .buildGeneralTextStyle(15, Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address: ",
                              style:
                              AppTheme().buildTitleStyle1(15, AppTheme().textColor),
                            ),
                            Expanded(
                              child: Text(
                                order['address']['full_address'],
                                overflow: TextOverflow.fade,
                                style: AppTheme()
                                    .buildGeneralTextStyle(15, Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Items: ",
                              style:
                              AppTheme().buildTitleStyle1(16, AppTheme().textColor),
                            ),
                            Expanded(
                              child: Text(
                                items,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme()
                                    .buildGeneralTextStyle(16, Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Expected Points :",
                              style:
                              AppTheme().buildTitleStyle1(15, AppTheme().textColor),
                            ),
                            Expanded(
                              child: Text(
                                "${order['expected_points']}",
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme()
                                    .buildGeneralTextStyle(15, Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Status :",
                              style:
                              AppTheme().buildTitleStyle1(15, AppTheme().textColor),
                            ),
                            Expanded(
                              child: Text(
                                "${order['status']}",
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme()
                                    .buildGeneralTextStyle(15, Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              (order['status']!="completed")?Consumer<approving>(
                  builder: (context, approvingProvider,child){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (approvingProvider.approvingOrder)?
                        JumpingDotsProgressIndicator(numberOfDots: 3,):
                        SliderButton(
                          action: () async{
                            bool isApproved = await approvingProvider.approveOrder(storeConstants.token,
                                order['_id'], order['expected_points']);

                            if(isApproved){
                              snackBar(context,"Order Completed temporarily!!", Colors.green);
                              Navigator.pop(context,true);
                            }else{
                              snackBar(context, "An Error Occurred!!", Colors.red);
                            }
                          },
                          label: const Text(
                            "Slide to Approve the Order",
                            style: TextStyle(
                                color: Color(0xff4a4a4a),
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          icon: const Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 25.0,
                              )),
                          shimmer: true,
                          radius: 20,
                          width: 280,
                          buttonSize: 60,
                          buttonColor: AppTheme().primaryColor,
                          backgroundColor: AppTheme().backgroundColor,
                        )
                      ],
                    );
                  }
              ):Container(),
            ],
          )),
    );
  }
}

class approving extends ChangeNotifier{
  bool _approvingOrder = false;

  bool get approvingOrder => _approvingOrder;

  approveOrder(String token,String orderId,expectedPoints)async{
    _approvingOrder = true;
    notifyListeners();

    print("Approving the order");
    bool isApproved = await ApiServices().approveOrder(token, orderId, expectedPoints);

    _approvingOrder = false;
    notifyListeners();
    return isApproved;
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 90);

    var firstStart = Offset(size.width * 0.5, size.height);
    var firstEnd = Offset(size.width, size.height - 90);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    path.lineTo(size.width, 0);

    path.close();
    return path;
  }
}
