
import 'package:emembers/data/models/customer_point.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/services/customer_point_service.dart';
import 'package:emembers/services/loyalty_service.dart';
import 'package:emembers/ui/menuLoyalty/loyalty_page.dart';
import 'package:emembers/ui/ticket/ticketing_widget.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/models/tenants.dart';
import 'package:emembers/data/models/viewVoucherHeader.dart';
import 'package:emembers/data/models/voucherType.dart';
import 'package:emembers/data/models/redeemVoucher.dart';
import 'package:emembers/constants.dart';

class LoyaltyController extends State<LoyaltyPage> {
  static late LoyaltyController instance;
  late LoyaltyPage view;

  // PROPERTY
  late int activeMenuIndex = 0;
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

  @override
  void initState() {
    fetchCustomerPoint(widget.user!);
    fetchTenantsVoucher();
    fetchListVoucher();
    fetchReedemVoucher();
    activeMenuIndex = widget.initialMenuIndex;
    setActiveMenu(activeMenuIndex);
    userPoints = userPoints;

    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  void setActiveMenu(int menuIndex) {
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
        // fetchHistoryVouchers();
      }

      // fetchCustomerPoint();
    });
  }

  void fetchHistoryVouchers() {
    setState(() {
      historyVouchers = [];
    });
  }

  Future fetchCustomerPoint(User user) async {
    var result = await CustomerPointService().fetchCustomerPoint(user);
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
    tenantData = await LoyaltyService().fetchTenantsData(widget.project!);

    voucherData = await LoyaltyService().fetchVoucherData(
      widget.project!,
      tenantData,
    );

    setState(() {});
  }

  Future<void> fetchListVoucher() async {
    var tenants = await LoyaltyService().fetchTenantsData(widget.project!);
    var modelVoucherType = await LoyaltyService()
        .fetchListVoucher(tenants[0].tenantId, widget.project!);
    if (modelVoucherType.length > 0) {
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
    modelsRedeemVoucher = await LoyaltyService().getRedeemVoucher(
      widget.user!
    );

    if(modelsRedeemVoucher.length > 0){
      dataListRedeemVoucher = [];
        for (int x = 0; x < modelsRedeemVoucher.length; x++) {
          for (int y = 0; y < voucherList.length; y++) {
            if (modelsRedeemVoucher[x]
                .voucherTypeID
                .contains(voucherList[y].voucherTypeID)) {
              assignedVouchers.add(modelsRedeemVoucher[x]);
            }
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
    setState(() {});
  }

  Future<bool> submitRedeemVoucher(viewVoucherHeaderData voucher) async {
    return await LoyaltyService().setRedeemVoucher(widget.user!, voucher);
  }

  Future<bool> updateVoucherQuantity(viewVoucherHeaderData voucher) async {
    return await LoyaltyService().updateVoucherQuantity(
      widget.user!,
      voucher,
      tenantData[0].tenantId,
      widget.project!,
    );
  }

  void showRedeemDialog(BuildContext context, viewVoucherHeaderData voucher) {
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
                  await fetchCustomerPoint(widget.user!);
                }

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

  void showAssignDialog(BuildContext context, viewVoucherHeaderData voucher) {
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
}
