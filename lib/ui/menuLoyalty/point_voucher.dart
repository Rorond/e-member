import 'dart:convert';
import 'dart:io';

import 'package:emembers/constants.dart';
import 'package:emembers/data/models/customer_point.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/tenants.dart';
import 'package:emembers/data/models/viewVoucherHeader.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/voucherType.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/services/customer_point_service.dart';
import 'package:emembers/ui/menuLoyalty/detailAssignVoucher.dart';
import 'package:emembers/ui/ticket/ticketing_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:emembers/data/models/redeemVoucher.dart';

class VoucherPointWidget extends StatefulWidget {
  final int initialMenuIndex;
  final User? user;
  final ProjectList? project;
  const VoucherPointWidget(
      {super.key, this.user, this.project, required this.initialMenuIndex});

  @override
  State<VoucherPointWidget> createState() => VoucherPointWidgetState();
}

class VoucherPointWidgetState extends State<VoucherPointWidget> {
  late int activeMenuIndex;
  List<tenantListData> tenantData = [];
  List<viewVoucherHeaderData> voucherData = [];
  List<voucherTypeListData> voucherList = [];
  bool isLoading = true;
  List<redeemVoucherData> dataListRedeemVoucher = [];
  List<viewVoucherHeaderData> assignedVouchers = [];
  late final List<viewVoucherHeaderData> historyVouchers;
  var modelsRedeemVoucher;
  int userPoints = 0;

  bool isViewVoucherActive = true;
  bool isAssignVoucherActive = false;
  bool isHistoryPointActive = false;

  viewVoucherHeaderData? selectedVoucher;

  void _setActiveMenu(int menuIndex) {
    setState(() {
      activeMenuIndex = menuIndex;
      isViewVoucherActive = menuIndex == 0;
      isAssignVoucherActive = menuIndex == 1;
      isHistoryPointActive = menuIndex == 2;

      if (isViewVoucherActive) {
        fetchTenantsVoucher();
      } else if (isAssignVoucherActive) {
        fetchReedemVoucher();
      } else {
        fetchHistoryVouchers();
      }

      fetchCustomerPoint();
    });
  }

  void fetchHistoryVouchers() {
    setState(() {
      historyVouchers = [];
    });
  }

  Future fetchCustomerPoint() async {
    var result = await CustomerPointService().fetchCustomerPoint(widget.user!);
    userPoints = result.length > 0 ? result[0].customerTotalPoint! : 0;
    setState(() {});
  }

  Future<bool> updateCustomerPoint(CustomerPoint customerPoint) async {
    return CustomerPointService().updateCustomerPoint(
      widget.user!,
      customerPoint,
    );
  }

  Future<void> fetchTenantsVoucher() async {
    isLoading = true;
    Uri uri = Uri.parse(Constants.apiLoyalty +
        '/loyalty/tenants?WhereClause=projectID=' +
        widget.project!.id.toString() +
        '&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=TenantName');
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('entity')) {
        List<dynamic> dataset = jsonResponse['entity'];
        tenantData = tenantListData.fromJsonList(dataset);

        Uri uriVoucher = Uri.parse(Constants.apiLoyalty +
            "/loyalty/viewVoucherHeader?" +
            "WhereClause=" +
            Uri.encodeComponent("v.tenantID='${tenantData.first.tenantId}' "
                "AND ValidEnd > '${DateTime.now().toIso8601String()}' "
                "AND VoucherQuantity > 0 "
                "AND ProjectID=${widget.project!.id}") +
            "&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=TenantName");
        final responseVoucher = await http.get(uriVoucher, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

        if (responseVoucher.statusCode == 200) {
          Map<String, dynamic> jsonResponseVoucher =
              json.decode(responseVoucher.body);
          if (jsonResponseVoucher.containsKey('entity')) {
            List<dynamic> datasetVoucher = jsonResponseVoucher['entity'];

            voucherData = viewVoucherHeaderData.fromJsonList(datasetVoucher);
          }
        }
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> updateVoucherQuantity(viewVoucherHeaderData voucher) async {
    int tempIndex = voucherList.indexWhere(
        (element) => element.voucherTypeID == voucher.voucherTypeID);
    Map dataVoucherType = {
      "voucherTypeID": voucher.voucherTypeID,
      "tenantID": voucherList[tempIndex].tenantID,
      "voucherTypeName": voucherList[tempIndex].voucherTypeName,
      "voucherTypeDescription": voucherList[tempIndex].voucherTypeDescription,
      "termsAndConditions": voucherList[tempIndex].termsAndConditions,
      "validFrom": voucherList[tempIndex].validFrom,
      "validEnd": voucherList[tempIndex].validEnd,
      "voucherRedeemType": voucherList[tempIndex].voucherRedeemType,
      "voucherMinimumTransaction":
          voucherList[tempIndex].voucherMinimumTransaction,
      "voucherAmount": voucherList[tempIndex].voucherAmount,
      "voucherMultiply": voucherList[tempIndex].voucherMultiply,
      "voucherStatus": "Active",
      "voucherQuantity": voucherList[tempIndex].voucherQuantity - 1,
      "ChangedBy":
          widget.user!.userId.toString() + " - " + widget.user!.userName
    };
    String bodyVoucherType = json.encode(dataVoucherType);
    Uri url = Uri.parse(Constants.apiGateway + "/loyalty/voucherType");
    var response = await http.put(
      url,
      body: bodyVoucherType,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
        'Access-Control-Allow-Headers':
            'Origin, X-Requested-With, Content-Type, Accept',
        'Access-Control-Allow-Credentials': 'true'
      },
    );

    if (response == 200) {
      print("Success update quantity voucher");
      setState(() {});
      return true;
    }
    setState(() {});
    return false;
  }

  Future<void> fetchListVoucher() async {
    isLoading = true;
    var modelVoucherType;
    Uri voucherTypeURL = Uri.parse(Constants.apiGateway +
        "/loyalty/voucherTypes?PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=voucherTypeName");

    var responseVoucherType =
        await http.get(voucherTypeURL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept',
      'Access-Control-Allow-Credentials': 'true'
    });
    if (responseVoucherType.statusCode == 200) {
      print(responseVoucherType.body);
      var dataVoucherType = jsonDecode(responseVoucherType.body);
      if (dataVoucherType["entity"] != null) {
        var dataset = dataVoucherType["entity"];
        modelVoucherType = voucherTypeListData.fromJsonList(dataset);
      }
    }
    if (modelVoucherType != null) {
      for (int i = 0; i < modelVoucherType.length; i++) {
        for (int j = 0; j < tenantData.length; j++) {
          if (modelVoucherType[i].tenantID.contains(tenantData[j].tenantId)) {
            voucherList.add(modelVoucherType[i]);
          }
        }
      }
    }

    setState(() {});
  }

  Future<void> fetchReedemVoucher() async {
    Uri redeemVoucherURL = Uri.parse(Constants.apiGateway +
        "/loyalty/RedeemVouchers?WhereClause=customerID=" +
        widget.user!.userId.toString() +
        "AND IsUsed = 0" +
        "&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=redeemDate");
    var responseRedeemVoucher =
        await http.get(redeemVoucherURL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept',
      'Access-Control-Allow-Credentials': 'true'
    });
    if (responseRedeemVoucher.statusCode == 200) {
      print(responseRedeemVoucher.body);
      var data = jsonDecode(responseRedeemVoucher.body);
      if (data["entity"] != null) {
        var dataset = data["entity"];
        modelsRedeemVoucher = redeemVoucherData.fromJsonList(dataset);
      }
    }

    dataListRedeemVoucher = [];
    for (int x = 0; x < modelsRedeemVoucher.length; x++) {
      for (int y = 0; y < voucherList.length; y++) {
        if (modelsRedeemVoucher[x]
            .voucherTypeID
            .contains(voucherList[y].voucherTypeID)) {
          dataListRedeemVoucher.add(modelsRedeemVoucher[x]);
        }
      }
    }

    assignedVouchers = [];
    dataListRedeemVoucher.forEach((redeemVoucher) {
      voucherData.forEach((voucher) {
        if (voucher.voucherTypeID == redeemVoucher.voucherTypeID) {
          assignedVouchers.add(voucher);
        }
      });
    });

    // // JIKA VOUCHER NYA TIDAK BOLEH DUPLIKAT PAKAI YANG INI
    // assignedVouchers = voucherData.where((voucher) {
    //   return dataListRedeemVoucher.any((redeemVoucher) =>
    //       redeemVoucher.voucherTypeID == voucher.voucherTypeID);
    // }).toList();
    setState(() {});
  }

  Future<bool> submitRedeemVoucher(viewVoucherHeaderData voucher) async {
    Map dataRedeemVoucher = {
      "voucherTypeID": voucher.voucherTypeID,
      "customerID": widget.user!.userId,
      "redeemDate": DateTime.now().toString(),
      "CreatedBy":
          widget.user!.userId.toString() + " - " + widget.user!.userName
    };
    String bodyRedeemVoucher = json.encode(dataRedeemVoucher);
    Uri urlRedeemVoucher =
        Uri.parse(Constants.apiGateway + "/loyalty/redeemVoucher");
    var responseRedeemVoucher = await http.post(
      urlRedeemVoucher,
      body: bodyRedeemVoucher,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
        'Access-Control-Allow-Headers':
            'Origin, X-Requested-With, Content-Type, Accept',
        'Access-Control-Allow-Credentials': 'true'
      },
    );
    if (responseRedeemVoucher.statusCode == 200) {
      print(responseRedeemVoucher.statusCode);
      return true;
    }

    setState(() {});
    return false;
  }

  @override
  void initState() {
    super.initState();
    fetchCustomerPoint();
    fetchTenantsVoucher();
    fetchListVoucher();
    activeMenuIndex = widget.initialMenuIndex;
    _setActiveMenu(activeMenuIndex);
    userPoints = userPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'User Point',
          style: ListTittleProfile,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                  alignment: AlignmentDirectional(0.04, 1.38),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 120,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('$userPoints Point', style: AppTittle1),
                            Divider(color: Colors.black),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildInfoCard(
                                  icon: Icons.point_of_sale_outlined,
                                  label: 'Poin',
                                  onTap: () {
                                    _setActiveMenu(0);
                                  },
                                  isActive: activeMenuIndex == 0,
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                  color: Theme.of(context).dividerColor,
                                ),
                                buildInfoCard(
                                  icon: Icons.history_edu_rounded,
                                  label: 'Voucher',
                                  onTap: () {
                                    _setActiveMenu(1);
                                  },
                                  isActive: activeMenuIndex == 1,
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                  color: Theme.of(context).dividerColor,
                                ),
                                buildInfoCard(
                                  icon: Icons.history,
                                  label: 'History',
                                  onTap: () {
                                    _setActiveMenu(2);
                                  },
                                  isActive: activeMenuIndex == 2,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: isViewVoucherActive
                    ? _buildViewVoucher()
                    : isAssignVoucherActive
                        ? _buildAssignVoucherContent()
                        : _buildHistoryVoucherContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.blue : Colors.grey,
              size: 32,
            ),
            Text(
              label,
              style: MenuApps.copyWith(
                color: isActive ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewVoucher() {
    return Column(
      children: [
        Container(
          child: Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Text("Redeem Point", style: AppTittle1),
          ),
        ),
        if (voucherData.isNotEmpty)
          Column(
            children: voucherData.map((voucher) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: AssetImage('assets/images/bgkartu.png')
                                as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  voucher.voucherTypeName,
                                  style: ListTittleProfile,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      voucher.requiredPoint.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text('Point', style: AppTittle),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(voucher.voucherQuantity.toString(),
                                        style: AppTittle),
                                    SizedBox(width: 8),
                                    Text('Tersedia', style: bodyText),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showRedeemDialog(context, voucher);
                            },
                            child: Text(
                              'Redeem',
                              style: ButtonTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        else
          Center(
            child: Text('Tidak ada voucher yang tersedia', style: bodyText),
          ),
        SizedBox(height: 20),
      ],
    );
  }

  void _showRedeemDialog(BuildContext context, viewVoucherHeaderData voucher) {
    if (userPoints < voucher.requiredPoint) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Poin Tidak Cukup"),
            content:
                Text("Poin Anda tidak mencukupi untuk menukarkan voucher ini."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Redeem"),
          content: Text("Apakah Anda yakin ingin menukarkan voucher ini?"),
          actions: [
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Ya"),
              onPressed: () async {
                bool submit = await submitRedeemVoucher(voucher);
                if (submit) {
                  CustomerPoint customerPoint = CustomerPoint();
                  customerPoint.pointMethod = "Minus";
                  customerPoint.customerId = widget.user!.userId;
                  customerPoint.customerTotalPoint = voucher.requiredPoint;

                  await updateCustomerPoint(customerPoint);
                  await updateVoucherQuantity(voucher);
                  await fetchTenantsVoucher();
                  await fetchCustomerPoint();
                }
                // submitData(voucher);

                Navigator.of(context).pop();
                setState(() {
                  userPoints -= voucher.requiredPoint;
                  voucher.voucherQuantity--;
                  if (voucher.voucherQuantity == 0) {
                    voucherData.remove(voucher);
                  }
                  assignedVouchers.add(voucher);
                });

                // SIMPAN SEMENTARA VOUCHER YANG DI REDEEM
                // JANGAN LUPA NANTIK DI UBAH KE DATABASE
                // await DataSharedPreferences()
                //     .saveAssignedVouchers(assignedVouchers);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAssignVoucherContent() {
    return Column(
      children: [
        if (assignedVouchers.isNotEmpty)
          Column(
            children: assignedVouchers.map((voucher) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailAssignVoucher(
                          voucher: voucher,
                          user: widget.user!,
                          clubData: widget.project!,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: AssetImage('assets/images/bgkartu.png')
                                  as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  voucher.voucherTypeName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      voucher.requiredPoint.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Point',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _showAssignDialog(context, voucher);
                              },
                              child: Text('Gunakan'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        else
          Center(
            child: Text(
                'Tidak ada voucher yang siap digunakan,Redeem poin anda terlebih dahulu di menu Poin.',
                style: bodyText),
          ),
      ],
    );
  }

  void _showAssignDialog(BuildContext context, viewVoucherHeaderData voucher) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Assign Voucher"),
          content: Text(
              "Selamat voucher anda sudah bisa digunakan di halaman checkout"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  assignedVouchers.add(voucher);
                  voucherData.remove(voucher);
                  selectedVoucher = voucher;
                });
                Navigator.of(context).pop();
                Navigator.pop(context, voucher);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CheckoutRoute(),
                //   ),
                // );

                String imgUrls = Constants.apiImage +
                    "/Project/" +
                    widget.project!.imageUrl +
                    "?v=" +
                    DateTime.now().toString();

                Navigator.push(
                    context,
                    ProductListRoute(
                      project: widget.project!,
                      user: widget.user!,
                      img: imgUrls,
                    ));
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHistoryVoucherContent() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: historyVouchers.length,
      itemBuilder: (context, index) {
        final voucher = historyVouchers[index];
        return ListTile(
          title: Text(voucher.voucherTypeName),
          subtitle: Text("${voucher.requiredPoint} Point"),
          trailing: Text("Used on: ${voucher.tenantName}"),
        );
      },
    );
  }

  Future submitData(viewVoucherHeaderData voucher) async {
    var modelVoucherType;
    Uri voucherTypeURL = Uri.parse(Constants.apiLoyalty +
        "/loyalty/voucherTypes?PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=voucherTypeName");

    // var responseProduct = await WebClient(User(jwt: "")).get(priceURL);
    var responseVoucherType =
        await http.get(voucherTypeURL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept',
      'Access-Control-Allow-Credentials': 'true'
    });
    if (responseVoucherType.statusCode == 200) {
      print(responseVoucherType.body);
      var dataVoucherType = jsonDecode(responseVoucherType.body);
      if (dataVoucherType["entity"] != null) {
        var dataset = dataVoucherType["entity"];
        modelVoucherType = voucherTypeListData.fromJsonList(dataset);
      }
      voucherList = modelVoucherType;
    }

    //validasi voucher quantity
    Map dataSales = {
      "customerID": widget.user!.userId,
      "inputDate": DateTime.now().toString(),
      // total point voucher
      "totalTransaction": widget.user!.totalPoint,
      "CreatedBy": widget.user!.userName,
    };
    String bodySales = json.encode(dataSales);
    Uri urlSales = Uri.parse(Constants.apiLoyalty + "/loyalty/sale");
    var responseSales = await http.post(
      urlSales,
      body: bodySales,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
        'Access-Control-Allow-Headers':
            'Origin, X-Requested-With, Content-Type, Accept',
        'Access-Control-Allow-Credentials': 'true'
      },
    );
    if (responseSales.statusCode == 200) {
      var data = jsonDecode(responseSales.body);
      if (data["entity"] != null) {
        var salesID = data["entity"]["salesID"];

        Map dataRedeemVoucher = {
          "salesId": salesID,
          "voucherTypeID": voucher.voucherTypeID,
          "customerID": widget.user!.userId,
          "redeemDate": DateTime.now().toString(),
          "CreatedBy": widget.user!.userName,
        };
        String bodyRedeemVoucher = json.encode(dataRedeemVoucher);
        Uri urlRedeemVoucher =
            Uri.parse(Constants.apiGateway + "/loyalty/redeemVoucher");
        var responseRedeemVoucher = await http.post(
          urlRedeemVoucher,
          body: bodyRedeemVoucher,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods':
                'POST, GET, OPTIONS, PUT, DELETE, HEAD',
            'Access-Control-Allow-Headers':
                'Origin, X-Requested-With, Content-Type, Accept',
            'Access-Control-Allow-Credentials': 'true'
          },
        );
        if (responseRedeemVoucher.statusCode == 200) {
          print(responseRedeemVoucher.statusCode);
        }
      }
    } else {
      print(responseSales.statusCode);
    }
  }
}
