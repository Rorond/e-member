import 'package:emembers/core.dart';

class PointController extends State<PointPage> {
  static late PointController instance;
  late PointPage view;
  final LoyaltyController loyaltyController = LoyaltyController();

// PROPERTY
  List<tenantListData> tenantData = [];
  List<viewVoucherHeaderData> voucherData = [];
  List<voucherTypeListData> voucherList = [];
  List<viewVoucherHeaderData> assignedVouchers = [];
  bool isLoading = true;
  var modelsRedeemVoucher;
  int userPoints = 0;

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  @override
  void initState() {
    fetchTenantsVoucher();
    fetchListVoucher();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  Future<bool> setRedeemVoucher(viewVoucherHeaderData voucher) async {
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

  Future<bool> updateCustomerPoint(CustomerPoint customerPoint) async {
    return CustomerPointService().updateCustomerPoint(
      widget.user!,
      customerPoint,
    );
  }

  void showRedeemDialog(BuildContext context, viewVoucherHeaderData voucher) {
    if (int.parse(widget.user!.totalPoint) < voucher.requiredPoint) {
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
                bool result = await setRedeemVoucher(voucher);
                if (result) {
                  CustomerPoint customerPoint = CustomerPoint();
                  customerPoint.pointMethod = "Minus";
                  customerPoint.customerId = widget.user!.userId;
                  customerPoint.customerTotalPoint = voucher.requiredPoint;

                  await updateCustomerPoint(customerPoint);
                  // await updateVoucherQuantity(voucher);
                  await fetchTenantsVoucher();
                  await fetchListVoucher();
                  await loyaltyController.fetchCustomerPoint(widget.user!);
                }

                Navigator.of(context).pop();
                setState(() {
                  // userPoints -= voucher.requiredPoint;
                  // voucher.voucherQuantity--;
                  // if (voucher.voucherQuantity == 0) {
                  //   voucherData.remove(voucher);
                  // }
                  // assignedVouchers.add(voucher);
                });

                // SIMPAN SEMENTARA VOUCHER YANG DI REDEEM
                // JANGAN LUPA NANTIK DI UBAH KE DATABASE
              },
            ),
          ],
        );
      },
    );
  }
}
