import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class AddCarMock extends StatefulWidget {
  const AddCarMock({super.key});

  @override
  State<AddCarMock> createState() => _AddCarMockState();
}

class _AddCarMockState extends State<AddCarMock> {
  TextEditingController rate = TextEditingController();
  TextEditingController plan = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController make = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController terms = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController maxDuration = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController availability = TextEditingController();
  TextEditingController yearOfManufacture = TextEditingController();
  TextEditingController registrationNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Add car'),
          const Text('STEP 1 OF 4'),
          buildGenericTextfield(
            hint: 'Car Make',
            controller: make,
            onChanged: (value) {},
          ),
          buildGenericTextfield(
            hint: 'Car Model',
            controller: model,
            onChanged: (value) {},
          ),
          buildGenericTextfield(
            hint: 'Year of Manufacture',
            controller: yearOfManufacture,
            onChanged: (value) {},
          ),
          buildGenericTextfield(
            hint: 'Car Registration Number',
            controller: registrationNumber,
            onChanged: (value) {},
          ),
          buildGenericTextfield(
            hint: 'Car Color',
            controller: color,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
