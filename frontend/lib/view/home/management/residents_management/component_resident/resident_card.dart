import 'package:flutter/material.dart';
import '../../../../../models/resident_info.dart';
import 'edit_footer.dart';
class ResidentCard extends StatefulWidget {
  final ResidentInfo item;
  final Function(String) onDelete; // Thêm tham số callback

  const ResidentCard({super.key, required this.item, required this.onDelete});

  @override
  State<ResidentCard> createState() => _ResidentCardState();
}

class _ResidentCardState extends State<ResidentCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: const Center(
                  child: Text(
                    'Information',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.blue),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Name:', widget.item.full_name ?? 'No name provided'),
                      _buildInfoRow('Date of Birth:', widget.item.date_of_birth ?? 'No date provided'),
                      _buildInfoRow('ID Number:', widget.item.id_number ?? 'No ID provided'),
                      _buildInfoRow('Age:', widget.item.age != null ? widget.item.age.toString() : 'No age provided'),
                      _buildInfoRow('Status:', widget.item.status ?? 'No status provided'),
                      _buildInfoRow('Room:', widget.item.room != null ? widget.item.room.toString() : 'No room provided'),
                      _buildInfoRow('Phone:', widget.item.phone_number ?? 'No phone number provided'),
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
            }
        );
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_pin_outlined, color: Colors.blue[500]!, size: 45,),
                      const SizedBox(width: 8),
                      Text(
                        widget.item.full_name!,
                        style: const TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Icon Edit pressed");
                          // Thêm hành động cho biểu tượng chỉnh sửa ở đây
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return EditFooter();
                              }
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 30,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          print("Icon Delete pressed");
                          widget.onDelete(widget.item.id_number!);
                        },
                        child: const Icon (
                          Icons.delete,
                          size: 30,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.home_outlined, color: Colors.grey[600]!, size: 25,), // Biểu tượng 2
                          const SizedBox(width: 10),
                          Text(
                            widget.item.room.toString(),
                            style: const TextStyle(fontSize: 17, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.call_outlined, color: Colors.grey[600]!, size: 25,), // Biểu tượng 3
                          const SizedBox(width: 10),
                          Text(
                            widget.item.phone_number??'No phone number',
                            style: const TextStyle(fontSize: 17, color: Colors.black87),
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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black54),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
