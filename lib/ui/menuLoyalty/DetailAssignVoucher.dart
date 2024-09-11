import 'package:emembers/constants.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/ui/ticket/ticketing_widget.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/models/viewVoucherHeader.dart';

class DetailAssignVoucher extends StatelessWidget {
  final viewVoucherHeaderData voucher;
  final User user;
  final ProjectList clubData;

  const DetailAssignVoucher({
    Key? key,
    required this.voucher,
    required this.user,
    required this.clubData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Voucher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/bgkartu.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher.voucherTypeName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Telah di redeem',
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            SizedBox(height: 8),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 231, 230, 230)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Biaya Klaim',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Gratis',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Text(
                      'Stok: ${voucher.voucherQuantity}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            ExpansionTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/mark.png',
                    width: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Cara Penggunaan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Cara Menggunakan Voucher:\n'
                    'Tukar ${voucher.requiredPoint} emembers Poin untuk mendapatkan 1 voucher tiket.'
                    '• Anda dapat menggunakan voucher pada saat transaksi pembayaran\n'
                    '• Periode Program sampai 30 Juni 2024\n',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5);
                      }
                      return null; // Use the component's default.
                    },
                  ),
                ),
                child: const Text('Gunakan Voucher'),
                onPressed: () {
                  Navigator.pop(context, voucher);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => CheckoutRoute()),
                  //   );

                  String imgUrls = Constants.apiImage +
                      "/Project/" +
                      clubData.imageUrl +
                      "?v=" +
                      DateTime.now().toString();

                  Navigator.push(
                      context,
                      ProductListRoute(
                        project: clubData,
                        user: user,
                        img: imgUrls,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
