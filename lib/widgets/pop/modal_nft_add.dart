import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../import.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModalSheetNFTAdd({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController priceController,
  required TextEditingController descController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.8)),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Center(child: Image.asset('assets/images/tire.png')),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text('Create NFT', style: seventeenStyle),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => context.read<NftBloc>().add(ChooseNFTEvent()),
                    child: Container(
                      height: 320,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: DottedBorder(
                        dashPattern: const [10, 6],
                        color: Colors.white.withOpacity(0.15),
                        strokeWidth: 1,
                        child: BlocBuilder<NftBloc, NftState>(
                          buildWhen: (previous, current) =>
                              previous.image != current.image,
                          builder: (context, state) {
                            return state.image != null
                                ? Image.file(File(state.image!.path))
                                : Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/photo.png',
                                              color: primary),
                                          const SizedBox(width: 10),
                                          const Text(
                                            'Add photo',
                                            style: seventeenStyle,
                                          ),
                                        ]),
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  VTextField(
                    autofocus: true,
                    controller: nameController,
                    hint: 'Name',
                  ),
                  const SizedBox(height: 10),
                  VTextField(
                    autofocus: true,
                    controller: priceController,
                    hint: '\$10000.00',
                  ),
                  const SizedBox(height: 10),
                  VTextField(
                    autofocus: true,
                    controller: descController,
                    maxLines: 10,
                    hight: 300,
                    hint: 'Description',
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<NftBloc, NftState>(
                    buildWhen: (previous, current) =>
                        previous.image != current.image,
                    builder: (context, state) {
                      return CalcButton(
                        function: () {
                          if (nameController.text.isEmpty ||
                              priceController.text.isEmpty ||
                              state.image == null ||
                              descController.text.isEmpty) {
                            return;
                          }
                          final price =
                              double.tryParse(priceController.text) ?? 0;
                          final nft = NFTModel(
                            myId: DateTime.now().microsecond,
                            name: nameController.text,
                            desc: descController.text,
                            isFavorite: false,
                            price: price,
                          );
                          context.read<NftBloc>().add(SaveNFTEvent(model: nft));
                          nameController.clear();
                          priceController.clear();
                          descController.clear();
                          MyNavigatorManager.instance.simulatorPop();
                        },
                        text: 'Create',
                        color: Colors.white,
                        gradic: gradientButton,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
