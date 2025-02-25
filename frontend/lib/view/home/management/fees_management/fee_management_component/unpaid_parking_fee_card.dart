import 'package:flutter/material.dart';
import '../../../../../models/unpaid_parking_fee_info.dart';
import 'edit_payment_date.dart';

class UnpaidParkingFeeCard extends StatefulWidget {
  final UnpaidParkingFeeInfo item;

  const UnpaidParkingFeeCard({super.key, required this.item});

  @override
  State<UnpaidParkingFeeCard> createState() => _UnpaidParkingFeeCardState();
}

class _UnpaidParkingFeeCardState extends State<UnpaidParkingFeeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Center(
                  child: Text(
                    'Thông tin',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Phòng:', widget.item.room ?? 'Không xác định'),
                      _buildInfoRow('ID phí:', widget.item.fee_id?.toString() ?? '0'),
                      _buildInfoRow('Số tiền:', widget.item.amount?.toString() ?? '0'),
                      _buildInfoRow('Loại phí:', widget.item.fee_type ?? 'Không xác định'),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Center(
                      child: Text("OK", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.home_outlined, color: Colors.blue[500]!, size: 45),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.item.room ?? 'Không xác định',
                      style: const TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return EditPaymentDate(
                                  it: widget.item,
                                  typeFee: 'park',
                                );
                              }
                          );
                        },
                        child: const Icon(
                          Icons.edit_calendar,
                          size: 30,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Icon(Icons.monetization_on_outlined, color: Colors.grey[600]!, size: 25),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.item.amount.toString(),
                              style: const TextStyle(fontSize: 17, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Row(
                        children: [
                          Icon(Icons.date_range_outlined, color: Colors.grey[600]!, size: 25),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.item.fee_type ?? 'không có loại phí',
                              style: const TextStyle(fontSize: 17, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Tăng khoảng cách giữa các hàng
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2, // Tăng kích thước cho nhãn
            child: Text(
              label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 3, // Tăng kích thước cho giá trị
            child: Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
