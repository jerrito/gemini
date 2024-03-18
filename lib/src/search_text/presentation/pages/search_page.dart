import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/widgets/spacing/whitspacing.dart';
import 'package:gemini/core/widgets/usecase/usecase.dart';
import 'package:gemini/core/widgets/widgets/bottom_sheet.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/src/search_text/presentation/bloc/search_bloc.dart';
import 'package:gemini/src/search_text/presentation/widgets/search_image_type.dart';
import 'package:gemini/src/search_text/presentation/widgets/search_type.dart';
import 'package:gemini/src/search_text/presentation/widgets/show_error.dart';

class SearchTextPage extends StatefulWidget {
  const SearchTextPage({super.key});
  @override
  State<SearchTextPage> createState() => _SearchTextPage();
}

class _SearchTextPage extends State<SearchTextPage> {
  final searchBloc = sl<SearchBloc>();
  final searchBloc2 = sl<SearchBloc>();
  final form = GlobalKey<FormState>();
  final searchBloc3 = sl<SearchBloc>();
  List<Uint8List> all = [];
  List<String> imageExtensions = [];
  List<num> imageLength = [];

  List<String> snapInfo = [];
  String info = "How can I help you today?";
  int type = 1;
  bool isTextImage = false;
  String? question;
  String name = "";
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jerrito Gemini AI"),
        centerTitle: true,
      ),
      bottomSheet: Form(
        key: form,
        child: bottomSheetTextfield(
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return "Field is required";
            }
            if (isTextImage) {
              if (all.isEmpty) {
                return "image is required";
              }
            }
            return null;
          },
          // errorText: FormFieldValidator.toString(),
          onChanged: (value) {
            //  field.didChange(value);

            // data = value!;
          },
          controller: controller,
          context: context,
          onPressed: () {
            if (form.currentState?.validate() == true &&
                controller.text.isNotEmpty) {
              Map<String, dynamic> params = {
                "text": controller.text,
              };
              Map<String, dynamic> paramsWithImage = {
                "text": controller.text,
                "images": all
              };
              switch (type) {
                case 4:
                  searchBloc.add(
                    SearchTextEvent(
                      params: params,
                    ),
                  );
                  break;

                case 2:
                  searchBloc.add(
                    ChatEvent(
                      params: params,
                    ),
                  );
                  break;

                case 3:
                  searchBloc.add(
                    SearchTextAndImageEvent(
                      params: paramsWithImage,
                    ),
                  );
                  break;
                case 1:
                  searchBloc.add(
                    GenerateStreamEvent(
                      params: params,
                    ),
                  );
                  break;
                case 5:
                  searchBloc.add(
                    GenerateContentEvent(
                      params: params,
                    ),
                  );
                default:
                  searchBloc.add(
                    GenerateStreamEvent(
                      params: params,
                    ),
                  );
                  break;
              }
            }
          },

          onTap: () {
            searchBloc2.add(AddMultipleImageEvent(
              noParams: NoParams(),
            ));
          },
          isTextAndImage: isTextImage,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().width(
            context,
            0.02,
          ),
          vertical: Sizes().height(
            context,
            0.02,
          ),
        ),
        child: BlocListener(
            bloc: searchBloc2,
            listener: (context, state) async {
              if (state is AddMultipleImageLoaded) {
                all.clear();
                imageExtensions.clear();
                imageLength.clear();
                //  info = "";
                question = "";

                for (int i = 0; i < state.data.length; i++) {
                  all.addAll(state.data.keys.elementAt(i));
                  imageExtensions.addAll(state.data.values.elementAt(i));
                }
                // imageLength=all.length;

                final dataGet = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SearchimageTextfield(
                      all: all,
                      textData: controller.text,
                    );
                  }),
                );

                controller.text = dataGet["text"];

                if (form.currentState?.validate() == true) {
                  searchBloc.add(
                    SearchTextAndImageEvent(
                      params: {
                        "text": controller.text,
                        "ext": imageExtensions[0],
                        "image": all[0],
                        // "images": imageLength,
                      },
                    ),
                  );
                }
              }
              if (state is AddMultipleImageLoading) {
                //all.clear();
              }
            },
            child: BlocConsumer(
                bloc: searchBloc,
                listener: (context, state) async {
                  if (state is SearchTextLoaded) {
                    all.clear();
                    question = controller.text;
                    controller.text = "";
                    final newId = await searchBloc.readData();
                    final data = state.data.content.parts[0].text;
                    final params = {
                      "textId":  newId!.isNotEmpty ? newId.last.textId+1 : 0 + 1,
                      "textTopic": question,
                      "textData": data,
                    };
                    searchBloc.addData(params);
                  }
                  // form.currentState?.validate();

                  if (state is ChatLoaded) {
                    all.clear();
                    question = controller.text;
                    controller.text = "";
                    final newId = await searchBloc.readData();
                    final data = state.data.content.parts[0].text;
                    final params = {
                      "textId":  newId!.isNotEmpty ? newId.last.textId +1 : 0 + 1,
                      "textTopic": question,
                      "textData": data,
                    };
                    searchBloc.addData(params);
                  }

                  if (state is GenerateStreamStop) {
                    all.clear();
                    question = controller.text;
                    controller.text = "";
                    String? aa;

                    final newId = await searchBloc.readData();
                    //for (int a = 0; a < snapInfo.length; a++) {
                      aa = snapInfo[0];
                   // }
                    print(aa);
                    print(snapInfo);
                    final params = {
                      "textId": newId!.isNotEmpty ? newId.last.textId+1 : 0 + 1,
                      "textTopic": question,
                      "textData": aa,
                    };
                    searchBloc.addData(params);
                  }

                  if (state is SearchTextAndImageLoaded) {
                    question = controller.text;
                    controller.text = "";
                    final newId = await searchBloc.readData();
                    final data = state.data.content.parts[0].text;
                    final params = {
                      "textId":  newId!.isNotEmpty ? newId.last.textId+1 : 0 + 1,
                      "textTopic": question,
                      "textData": data,
                      "imageData": all[0],
                    };
                    searchBloc.addData(params);
                  }

                  if (state is GenerateContentError) {
                    if (!context.mounted) return;
                    showErrorSnackbar(context, state.errorMessage);

                    controller.text = "";
                    question = controller.text;
                  }
                  if (state is SearchTextAndImageError) {
                    if (!context.mounted) return;
                    showErrorSnackbar(context, state.errorMessage);
                    controller.text = "";
                    question = controller.text;
                  }
                  if (state is SearchTextError) {
                    if (!context.mounted) return;
                    showErrorSnackbar(context, state.errorMessage);
                  }

                  if (state is ChatError) {
                    if (!context.mounted) return;
                    showErrorSnackbar(context, state.errorMessage);
                    controller.text = "";
                    question = controller.text;
                  }
                },
                builder: (context, state) {
                  if (state is SearchTextAndImageLoading ||
                      state is SearchTextLoading ||
                      state is ChatLoading ||
                      state is GenerateContentLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GenerateStream) {
                    final params = {"text": controller.text};

                    return StreamBuilder(
                        stream: searchBloc.generateStream(params),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            snapInfo.clear();
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            searchBloc.add(GenerateStreamStopEvent());
                          }
                          if (snapshot.hasError) {
                            final data = snapshot.error;
                            controller.text = "";
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(question ?? ""),
                                  Space().height(context, 0.02),
                                  Text(data.toString()),
                                  Space().height(context, 0.03),
                                ],
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            final data = snapshot.data?.text ??
                                snapshot
                                    .data?.promptFeedback?.blockReasonMessage;
                            snapInfo.add(data!);
                            return Column(
                              children: [
                                Text(question ?? ""),
                                Flexible(
                                  child: ListView.builder(
                                    itemCount: snapInfo.length,
                                    itemBuilder: (context, index) {
                                      final dataFromSnap = snapInfo[index];
                                      return Text(dataFromSnap);
                                    },
                                  ),
                                ),
                                Space().height(context, 0.1),
                              ],
                            );
                          }
                          return const SizedBox();
                        });
                  }
                  if (state is GenerateStreamStop) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(question ?? ""),
                            IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () async {
                                  searchBloc.copyText({"text": snapInfo[0]});
                                })
                          ],
                        ),
                        Flexible(
                          child: ListView.builder(
                            itemCount: snapInfo.length,
                            itemBuilder: (context, index) {
                              final dataFromSnap = snapInfo[index];
                              return Text(dataFromSnap);
                            },
                          ),
                        ),
                        Space().height(context, 0.1),
                      ],
                    );
                  }
                  if (state is ChatLoaded) {
                    final data = state.data.content.parts.last.text;

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(question ?? ""),
                              IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () async {
                                    searchBloc.copyText({"text": data});
                                  })
                            ],
                          ),
                          Space().height(context, 0.02),
                          Text(data),
                          Space().height(context, 0.1),
                        ],
                      ),
                    );
                  }

                  if (state is GenerateContentLoaded) {
                    // StreamController s = StreamController();

                    final data = state.data.toString();

                    // }) as StreamSubscription<dynamic>;

                    // data.listen((event) {
                    //     print(event.toString());
                    //   });
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(question ?? ""),
                          // Image.asset(
                          //   all[0].
                          // ),
                          Space().height(context, 0.02),
                          Text(data),
                          Space().height(context, 0.1),
                        ],
                      ),
                    );
                  }
                  if (state is SearchTextAndImageLoaded) {
                    final data = state.data;

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(question ?? ""),
                              IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () async {
                                    searchBloc.copyText({"text": data});
                                  })
                            ],
                          ),
                          if (all.isNotEmpty)
                            Column(
                                children: List.generate(all.length, (index) {
                              return Image.memory(all[index]);
                            })),
                          // Image.asset(
                          //   all[0].
                          // ),
                          Space().height(context, 0.02),
                          Text(data.toString()),
                          Space().height(context, 0.1),
                        ],
                      ),
                    );
                  }
                  if (state is SearchTextLoaded) {
                    final data = state.data.content.parts[0].text;
                    final params = {
                      "text": data,
                    };
                    // final dataDeduct = data.length;
                    //print(dataDeduct);
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(question ?? ""),
                              IconButton(
                                  icon: Icon(Icons.copy),
                                  onPressed: () async {
                                    searchBloc.copyText(params);
                                  })
                            ],
                          ),
                          Space().height(context, 0.02),
                          Text(
                            data.toString(),
                          ),
                          Space().height(context, 0.1),
                        ],
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Center(child: Text(info))],
                  );
                })),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Space().height(context, 0.15),
            SearchTypeWidget(
              color: type == 1 ? Colors.lightBlueAccent : Colors.black,
              icon: Icons.stream,
              onPressed: () {
                type = 1;
                isTextImage = false;
                Navigator.pop(context);
                setState(() {});
              },
              label: "Stream content",
            ),
            SearchTypeWidget(
              color: type == 3 ? Colors.lightBlueAccent : Colors.black,
              icon: Icons.image_search,
              onPressed: () {
                type = 3;
                isTextImage = true;
                Navigator.pop(context);
                setState(() {});
              },
              label: "Search text with image",
            ),

            SearchTypeWidget(
              color: type == 2 ? Colors.lightBlueAccent : Colors.black,
              icon: Icons.chat,
              onPressed: () async {
                type = 2;
                isTextImage = false;
                Navigator.pop(context);
                setState(() {});
                await searchBloc
                    .readData()
                    .then((value) => print(value?[0].textData));
              },
              label: "Chat with bot",
            ),
            SearchTypeWidget(
              color: type == 4 ? Colors.lightBlueAccent : Colors.black,
              icon: Icons.text_format,
              onPressed: () {
                type = 4;
                isTextImage = false;
                Navigator.pop(context);
                setState(() {});
              },
              label: "Await content",
            ),
            // SearchTypeWidget(
            //   onPressed: () {
            //     type = 5;
            //     isTextImage = false;
            //     Navigator.pop(context);
            //     setState(() {});
            //   },
            //   label: "Generate content bloc",
            //),
          ],
        ),
      ),
    );
  }
}
