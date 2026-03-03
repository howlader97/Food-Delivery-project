import 'package:flutter/material.dart';

class CustomLocationRow extends StatelessWidget {
  final String? selectedLocation;
  final List<String>? locations;
  final ValueChanged<String?>? onLocationChanged;
  final VoidCallback? onNotificationTap;
  final IconData? iconData;

  const CustomLocationRow({
    super.key,
    this.selectedLocation,
    this.locations,
    this.onLocationChanged,
    this.onNotificationTap,
    this.iconData,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData ?? Icons.location_on,
          color: Colors.black,
        ),
        const SizedBox(width: 5),
        if (locations != null && locations!.isNotEmpty)
          DropdownButton<String>(
            value: selectedLocation ?? locations!.first,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            onChanged: onLocationChanged,
            items: locations!
                .map((loc) => DropdownMenuItem(
              value: loc,
              child: Text(loc),
            ))
                .toList(),
          )
        else
          const Text(
            "No Location",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        const Spacer(),
        if (onNotificationTap != null)
          IconButton(
            onPressed: onNotificationTap,
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),

      ],
    );
  }
}
