import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  TextEditingController make = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController yearOfManufacture = TextEditingController();
  TextEditingController registrationNumber = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController plan = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController availability = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController maxDuration = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController terms = TextEditingController();

  List<Media> media = [];
  final mediaPicker = ImagePicker();

  chooseImages() async {
    final List<XFile> images = await mediaPicker.pickMultiImage();
    if (images.isNotEmpty) {
      media.addAll(images.map((image) => Media(mediaURL: image.path)).toList());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: make,
                decoration: const InputDecoration(hintText: 'make'),
              ),
              TextField(
                controller: model,
                decoration: const InputDecoration(hintText: 'model'),
              ),
              TextField(
                controller: capacity,
                decoration: const InputDecoration(hintText: 'capacity'),
              ),
              TextField(
                controller: yearOfManufacture,
                decoration:
                    const InputDecoration(hintText: 'yearOfManufacture'),
              ),
              TextField(
                controller: registrationNumber,
                decoration:
                    const InputDecoration(hintText: 'registrationNumber'),
              ),
              TextField(
                controller: condition,
                decoration: const InputDecoration(hintText: 'condition'),
              ),
              TextField(
                controller: rate,
                decoration: const InputDecoration(hintText: 'rate'),
              ),
              TextField(
                controller: plan,
                decoration: const InputDecoration(hintText: 'plan'),
              ),
              TextField(
                controller: type,
                decoration: const InputDecoration(hintText: 'type'),
              ),
              TextField(
                controller: availability,
                decoration: const InputDecoration(hintText: 'availability'),
              ),
              TextField(
                controller: location,
                decoration: const InputDecoration(hintText: 'location'),
              ),
              TextField(
                controller: maxDuration,
                decoration: const InputDecoration(hintText: 'maxDuration'),
              ),
              TextField(
                controller: description,
                decoration: const InputDecoration(hintText: 'description'),
              ),
              TextField(
                controller: terms,
                decoration: const InputDecoration(hintText: 'terms'),
              ),
              buildGenericButtonWidget(
                buttonName: 'Select Images',
                onPressed: chooseImages,
              ),
              ...media
                  .map((media) => Image.file(
                        File(media.mediaURL),
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              buildGenericButtonWidget(
                buttonName: 'Add Car',
                onPressed: () async {
                  // Car carDetails = Car(
                  //     owner: global.userDetails!.id,
                  //     make: 'Mercedes Benz',
                  //     model: 'Cruze',
                  //     capacity: 5,
                  //     yearOfManufacture: '2055',
                  //     registrationNumber: 'AW 3345-99',
                  //     condition: 'Excellent',
                  //     rate: 15,
                  //     plan: '/day',
                  //     type: 'Bus',
                  //     availability: true,
                  //     location: 'Kumasi',
                  //     maxDuration: 25,
                  //     description: 'Desc',
                  //     terms: 'terms',
                  //     media: media);
                  // // Car carDetails = Car(
                  // //     owner: global.userDetails!.id,
                  // //     make: make.text,
                  // //     model: model.text,
                  // //     capacity: int.parse(capacity.text),
                  // //     yearOfManufacture: yearOfManufacture.text,
                  // //     registrationNumber: registrationNumber.text,
                  // //     condition: condition.text,
                  // //     rate: int.parse(rate.text),
                  // //     plan: plan.text,
                  // //     type: type.text,
                  // //     availability: bool.parse(availability.text),
                  // //     location: location.text,
                  // //     maxDuration: int.parse(maxDuration.text),
                  // //     description: description.text,
                  // //     terms: terms.text,
                  // //     media: media);

                  // await RentWheelsCarMethods()
                  //     .addNewCar(carDetails: carDetails);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
