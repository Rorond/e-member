import 'package:emembers/core.dart';

class PointPage extends StatefulWidget {
  final User? user;
  final ProjectList? project;

  const PointPage({
    Key? key,
    this.user,
    this.project,
  }) : super(key: key);

  @override
  State<PointPage> createState() => PointController();

  Widget build(context, PointController controller) {
    controller.view = this;
    return Column(
      children: [
        Container(
          child: Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Text("Redeem Point", style: AppTittle1),
          ),
        ),
        if (controller.voucherData.isNotEmpty &&
            controller.voucherData.length > 0)
          Column(
            children: controller.voucherData.map((voucher) {
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
                              controller.showRedeemDialog(context, voucher);
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
}
