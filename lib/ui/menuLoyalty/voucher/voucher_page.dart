import 'package:emembers/core.dart';

class VoucherPage extends StatefulWidget {
  final User? user;
  final ProjectList? project;

  const VoucherPage({
    Key? key,
    this.user,
    this.project,
  }) : super(key: key);

  @override
  State<VoucherPage> createState() => VoucherController();

  Widget build(context, VoucherController controller) {
    controller.view = this;
    return Column(
      children: [
        if (controller.assignedVouchers.isNotEmpty)
          Column(
            children: controller.assignedVouchers.map((voucher) {
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
                          user: user!,
                          clubData: project!,
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
                                controller.showAssignDialog(context, voucher);
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
}
