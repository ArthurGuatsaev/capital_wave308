import 'package:flutter_bloc/flutter_bloc.dart';

import '../../import.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  void initState() {
    context.read<NftBloc>().add(GetSaveNFTEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      buildWhen: (previous, current) => previous.nft != current.nft,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              GestureDetector(
                onTap: () => showModalSheetNFTFavorite(context: context),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'assets/images/star_fill.png',
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Text(
                        'Collection',
                        style: thirtyFourStyte,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 10),
                    ),
                    SliverToBoxAdapter(
                      child: Builder(
                        builder: (context) {
                          if (state.nft.isEmpty) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: SizedBox(
                                height: 300,
                                child: Center(
                                  child: SizedBox(
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            'assets/images/nft_empty.png'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('Empty',
                                                  style: twentyTwoStyle),
                                              Expanded(
                                                child: Text(
                                                  "You don't have established NFT yet",
                                                  style: fifteenStyle,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Row(
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: bgColor),
                                height: 76,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Added',
                                      style: fifteenStyle,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${state.nft.length}',
                                      style: fifteenStyle,
                                    )
                                  ],
                                ),
                              )),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: bgColor),
                                height: 76,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sum NFT',
                                      style: fifteenStyle,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${state.summNFT}',
                                      style: fifteenStyle,
                                    )
                                  ],
                                ),
                              )),
                            ],
                          );
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),
                    SliverGrid.builder(
                        itemCount: state.nft.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 173 / 280,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return NFTItem(
                            nft: state.nft[index],
                          );
                        })
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: primary),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            showModalSheetNFTAdd(
                                context: context,
                                descController: TextEditingController(),
                                priceController: TextEditingController(),
                                nameController: TextEditingController());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/plus.png'),
                              const SizedBox(width: 8),
                              const Text(
                                'Add Text',
                                style: seventeenStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
