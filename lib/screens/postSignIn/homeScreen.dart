



import 'package:ecowise_vendor_v2/Utils/constants.dart';
import 'package:ecowise_vendor_v2/screens/postSignIn/orderDetails.dart';
import 'package:ecowise_vendor_v2/services/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getMyStoreOrders()async{
    Provider.of<orderProvider>(context,listen:false).deInitialiseOrders();
    print("getting store orders");
    await ApiServices().getStoreOrders(storeConstants.token);
    print("got store orders");
    Provider.of<orderProvider>(context,listen: false).InitialiseOrders(storeConstants.storeOrders);
    // Provider.of<orderProvider>(context,listen: false).InitialiseOrders([{}]);
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    //getStoreOrders
    //getMyStoreOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme().backgroundColor,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.menu_rounded,color: AppTheme().textLightColor,),
        ),
        title: Text(
          "Your Orders",
          style: AppTheme().buildTitleStyle1(20, AppTheme().textColor),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: ()async{
            await getMyStoreOrders();
          },
          child:Consumer<orderProvider>(
            builder: (context,orderProvider,child){
              return (orderProvider.gettingOrders)?
              Center(
                child: SpinKitDoubleBounce(
                  color: AppTheme().primaryColor,
                  size: 55,
                ),
              ):
              ListView(
                children: orderProvider.orders.map((e) => orderContainer(e)).toList(),
              );
            },
          )
      ),
    );
  }

  Widget orderContainer(var order){
    String items = "";
    order['items'].forEach((e){
      items += e['item_name'];
      items += ", ";
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: InkWell(
        onTap: ()async{
          bool x = await Navigator.of(context).push(
              MaterialPageRoute(builder: (_)=> OrderDetails(order))
          );
          if(x) getMyStoreOrders();
        },
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Customer Name: ",
                        style: AppTheme().buildTitleStyle1(14, AppTheme().textColor),),
                      Text("Sriraj",
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme().buildGeneralTextStyle(14, AppTheme().textLightColor),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address: ",
                        style: AppTheme().buildTitleStyle1(14, AppTheme().textColor),),
                      Expanded(
                        child: Text(order['address']['full_address'],
                          //overflow: TextOverflow.clip,
                          style: AppTheme().buildGeneralTextStyle(14, AppTheme().textLightColor),),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Items: ",
                        style: AppTheme().buildTitleStyle1(14, AppTheme().textColor),),
                      Text(items,
                        overflow: TextOverflow.fade,
                        style: AppTheme().buildGeneralTextStyle(14, AppTheme().textLightColor),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Expected Points: ",
                        style: AppTheme().buildTitleStyle1(14, AppTheme().textColor),),
                      Text("${order['expected_points']}",
                        overflow: TextOverflow.fade,
                        style: AppTheme().buildGeneralTextStyle(14, AppTheme().textLightColor),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status: ",
                        style: AppTheme().buildTitleStyle1(14, AppTheme().textColor),),
                      Text("${order['status']}",
                        overflow: TextOverflow.fade,
                        style: (order['status']=="completed")?AppTheme().buildTitleStyle1(14,Colors.green):
                        AppTheme().buildGeneralTextStyle(14, AppTheme().textLightColor),)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class orderProvider extends ChangeNotifier{
  bool _gettingOrders = true;
  List _orders = [];

  bool get gettingOrders => _gettingOrders;
  List get orders => _orders;

  deInitialiseOrders(){
    _gettingOrders = true;
    notifyListeners();
  }

  InitialiseOrders(List data){
    _gettingOrders = false;
    _orders = data;
    notifyListeners();
  }
}
