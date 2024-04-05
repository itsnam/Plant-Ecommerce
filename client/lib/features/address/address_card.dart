import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/address/address.dart';
import 'package:plantial/features/address/address_update_page.dart';
import 'package:plantial/features/styles/styles.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plantial/features/Url/url.dart';

class AddressCard extends StatefulWidget {
  final Address address;
  final Address? selectedAddress;
  final Function onChanged;
  final Function onDelete;

  const AddressCard({
    Key? key,
    required this.address,
    required this.onChanged,
    required this.selectedAddress,
    required this.onDelete
  }) : super(key: key);

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {

  void deleteAddress(String addressId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');
      var response = await delete(Uri.parse('$apiAddress/$email/$addressId'));

      if (!context.mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã xoá địa chỉ thành công'), duration: Duration(seconds: 1),),
        );
        widget.onDelete();
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể xoá địa chỉ'), duration: Duration(seconds: 1)),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void editAddress() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    if (!context.mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressUpdate(
          appBarTitle: 'Chỉnh sửa địa chỉ',
          email: email!,
          initialAddress: widget.address,
        ),
      ),
    ).then((value) => widget.onDelete());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          border: Border.all(color: unselectedMenuItem, width: 0.75),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: RadioListTile(
                  activeColor: primary,
                  title: Text(
                    widget.address.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  value: widget.address,
                  groupValue: widget.selectedAddress,
                  onChanged: (value) => widget.onChanged(value),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.address.phone,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${widget.address.street}, ${(widget.address.ward[1]).toLowerCase()} ${widget.address.ward[0]}, ${(widget.address.district[1]).toLowerCase()} ${(widget.address.district[0])}, ${(widget.address.province[1]).toLowerCase()} ${widget.address.province[0]}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PopupMenuButton<String>(
              icon: const RotatedBox(
                quarterTurns: 1,
                child: SizedBox(
                  height: 30,
                  child: Icon(
                    Iconsax.more,
                    size: 20,
                  ),
                ),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Chỉnh sửa'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Xoá'),
                    ],
                  ),
                ),
              ],
              onSelected: (String value) {
                if (value == 'edit') {
                  editAddress();
                } else if (value == 'delete') {
                  deleteAddress(widget.address.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
