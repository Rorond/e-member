import 'package:emembers/core.dart';
import 'package:emembers/ui/menuLoyalty/history/loyalty_history_page.dart';

class HistoryController extends State<LoyaltyHistoryPage> {
  static late HistoryController instance;
  late LoyaltyHistoryPage view;

  List<tenantListData> tenantData = [];
  List<viewVoucherHeaderData> voucherData = [];
  List<voucherTypeListData> voucherList = [];
  List<viewVoucherHeaderData> assignedVouchers = [];
  List<redeemVoucherData> dataListRedeemVoucher = [];
  bool isLoading = true;
  var modelsRedeemVoucher;

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  @override
  void initState() {
    fetchReedemVoucher();
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

  Future<void> fetchReedemVoucher() async {
    await fetchTenantsVoucher();
    await fetchListVoucher();

    modelsRedeemVoucher = await LoyaltyService().fetchReedemVoucher(
      widget.user!,
      voucherData,
      voucherList,
    );

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
    setState(() {});
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
                setState(() {});
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
