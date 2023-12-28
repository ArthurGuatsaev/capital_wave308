import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../import.dart';

Future showModalSheetNFTOpen({
  required BuildContext context,
  required TextEditingController textController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.8)),
      child: Material(
        color: Colors.transparent,
        child: BlocBuilder<NftBloc, NftState>(
          buildWhen: (previous, current) => previous.nft != current.nft,
          builder: (context, state) {
            if (state.current >= state.nft.length) {
              return const SizedBox();
            }
            final ntf = state.nft[state.current];
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, bottom: 40),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<FileImage?>(
                              future: ntf.productImage,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return const SizedBox.shrink();
                                }
                                return Container(
                                    height: 320,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Stack(
                                      children: [
                                        Image(
                                          image: snapshot.data!,
                                          height: 320,
                                          fit: BoxFit.fill,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 12, right: 12),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () =>
                                                      showMyIosDeleteDataPop(
                                                          context, () {
                                                    context.read<NftBloc>().add(
                                                          RemoveNFTEvent(
                                                            model: ntf,
                                                          ),
                                                        );
                                                    MyNavigatorManager.instance
                                                        .untilPop();
                                                  }, 'Delete NFT',
                                                          "Your NFT will be permanently deleted"),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12),
                                                    height: 48,
                                                    width: 48,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Colors.black
                                                            .withOpacity(0.13)),
                                                    child: Center(
                                                      child: Image.asset(
                                                          'assets/images/trash.png'),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () => showModalSheetNFTEdit(
                                                      context: context,
                                                      descController:
                                                          TextEditingController(),
                                                      nameController:
                                                          TextEditingController(),
                                                      ntf: ntf,
                                                      priceController:
                                                          TextEditingController()),
                                                  child: Container(
                                                    height: 48,
                                                    width: 48,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Colors.black
                                                            .withOpacity(0.13)),
                                                    child: Center(
                                                      child: Image.asset(
                                                          'assets/images/pencil.png'),
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                GestureDetector(
                                                  onTap: () => context
                                                      .read<NftBloc>()
                                                      .add(
                                                        SaveNFTEvent(
                                                          model: ntf.copyWith(
                                                            isFavorite: !ntf
                                                                .isFavorite!,
                                                          ),
                                                        ),
                                                      ),
                                                  child: Container(
                                                    height: 48,
                                                    width: 48,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: !ntf.isFavorite!
                                                            ? Colors.black
                                                                .withOpacity(
                                                                    0.13)
                                                            : primary),
                                                    child: Center(
                                                      child: Image.asset(
                                                          'assets/images/star.png'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ));
                              }),
                          const SizedBox(height: 10),
                          Text(
                            ntf.name!,
                            style: twentyEightStyle,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$${ntf.price!}',
                            style: twentyStyle,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            ntf.desc!,
                            style: fifteenStyle,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    NoteTitle(
                      id: ntf.id!,
                      textController: textController,
                    ),
                    const NoteList(),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 300),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
