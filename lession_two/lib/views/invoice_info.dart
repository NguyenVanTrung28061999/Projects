import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lession_two/resources/widget/custom_button.dart';
import 'package:lession_two/resources/widget/text_custom_input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceInfo extends StatefulWidget {
  const InvoiceInfo({Key? key}) : super(key: key);

  @override
  _InvoiceInfoState createState() => _InvoiceInfoState();
}

class _InvoiceInfoState extends State<InvoiceInfo> {
  TextEditingController? nameController, soLuongController;
  String thanhTien = 'chưa xác định';
  FocusNode? nodeSecond, nodeFirst, nodeLast;
  bool? vipCheck;
  double? toTalPriceSend;
  int? toTalCustomerVip;
  int? toTalCustomer;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    soLuongController = TextEditingController();
    vipCheck = false;
    nodeFirst = FocusNode();
    nodeSecond = FocusNode();
    nodeLast = FocusNode();
    toTalPriceSend = 0.0;
    toTalCustomer = 0;
    toTalCustomerVip = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Online Book Selling App',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: const Text(
                    'Invoice Information',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  color: Colors.green,
                  width: 410,
                  height: 20,
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Name Customer :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Container(
                        width: 300,
                        child: TextCustomInputWidget(
                            controller: nameController, focusNode: nodeFirst)))
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: const Text(
                        'Quantity Book :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    flex: 5,
                    child: Container(
                        padding: const EdgeInsets.only(left: 15, top: 5),
                        width: 300,
                        child: TextCustomInputWidget(
                            controller: soLuongController,
                            focusNode: nodeSecond)))
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 120),
                  child: Checkbox(
                      activeColor: Colors.orange,
                      value: vipCheck,
                      onChanged: (value) {
                        setState(() {
                          vipCheck = value;
                        });
                      }),
                ),
                const Text(
                  'Customer Vip',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: const Text(
                        'ToTal Price :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    flex: 5,
                    child: Container(
                      height: 40,
                      child: Card(
                        color: Colors.black12,
                        child: Container(
                          padding: const EdgeInsets.only(top: 6, left: 80),
                          child: Text(
                            '$thanhTien',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomButton(
                      onPressed: () {
                        setState(() {
                          double giamGia = (10 /
                              100 *
                              20000 *
                              double.parse(soLuongController!.text));
                          thanhTien = totalPrice(
                            price: 20000,
                            quantity: double.parse(soLuongController!.text),
                            giamGia: giamGia,
                            checkVip: vipCheck!,
                          );
                        });
                      },
                      textButton: 'Tính TT'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomButton(
                      onPressed: () {
                        // toTalCustomer! +=1;
                        toTalPriceSend =
                            toTalPriceSend! + double.parse(thanhTien!);
                        toTalCustomer = toTalCustomer! + 1;
                        if (vipCheck == true) {
                          toTalCustomerVip = toTalCustomerVip! + 1;
                        }
                        setState(() {
                          sendData(
                              toTalPrice: toTalPriceSend!,
                              toTalCustomer: toTalCustomer!,
                              toTalCustomerVip: toTalCustomerVip!.toString());
                        });
                        this.clearForm();
                        FocusScope.of(context).requestFocus(nodeFirst);
                      },
                      textButton: 'Tiếp'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomButton(
                      onPressed: () {
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text(
                                  'Tổng doanh thu hiện tại :',
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: Text('$toTalPriceSend'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close')),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('HelloWorld!'),
                                  )
                                ],
                              );
                            });
                        // var route = MaterialPageRoute(builder: context)=> StatisticalInfo())
                      },
                      textButton: 'Thống Kê'),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: 410,
                  height: 40,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: const Text(
                    'Statistical Infomation',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  color: Colors.green,
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, left: 5),
                      child: const Text(
                        'Total Customer :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, left: 5),
                      child: Text(
                        '$toTalCustomer',
                        style: TextStyle(fontSize: 16),
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(top: 20, left: 5),
                      child: const Text(
                        'Total Customer Are Vip :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(top: 20, left: 5),
                      child: Text(
                        '$toTalCustomerVip',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, left: 5),
                      child: const Text(
                        'Total Revenue :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(top: 20, left: 5),
                      child: Text(
                        '$toTalPriceSend',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                  width: 410,
                  height: 40,
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(''),
                  color: Colors.green,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text(
                                  'Message for you',
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: const Text('Do you want Exit App?'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close')),
                                  TextButton(
                                    onPressed: () {
                                      SystemNavigator.pop();
                                    },
                                    child: const Text('Yes'),
                                  )
                                ],
                              );
                            });
                      },
                      iconSize: 40,
                      icon: const Icon(Icons.exit_to_app)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  clearForm() {
    nameController!.clear();
    soLuongController!.clear();
    thanhTien = 'Chua Xác Định';
  }

  sendData(
      {required double toTalPrice,
      required int toTalCustomer,
      required String toTalCustomerVip}) {
    toTalPrice += double.parse(thanhTien!);
    toTalCustomer += 1;
    toTalCustomerVip += 1.toString();
  }

  saveInformationToLocalstorage(
      {required double toTalPrice,
      required int toTalCustomer,
      required String toTalCustomerVip}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setDouble("toTal_price", toTalPrice);
    await prefs.setInt("toTal_customer", toTalCustomer);
    await prefs.setString('toTal_customer_vip', toTalCustomerVip);
  }
}

String totalPrice(
    {required double price,
    required double quantity,
    required double giamGia,
    required bool checkVip}) {
  giamGia = (10 / 100 * price * quantity);
  if (checkVip == true) {
    return (price * quantity - giamGia).toStringAsFixed(0);
  }
  return (price * quantity).toStringAsFixed(0);
}
