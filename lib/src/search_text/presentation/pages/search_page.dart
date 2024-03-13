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
  String data = "How can I help you today?";
  int type = 1;
  bool isTextImage = false;
  String? question;
  String name = "";
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jerrito Gemini AI"),
        centerTitle: true,
      ),
      bottomSheet: Form(
        key: form,
        child: FormField<String>(
          onSaved: (value) {
            value=controller.text ;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
          builder: (field) => bottomSheetTextfield(
            //validator: ,
            errorText: field.errorText,
            onChanged: (value) {
              field.didChange(value);

              // data = value!;
            },
            controller: controller,
            context: context,
            onPressed: () {
              if (form.currentState?.validate() == true) {
                switch (type) {
                  case 1:
                    Map<String, dynamic> params = {
                      "text": controller.text,
                    };
                    searchBloc.add(
                      SearchTextEvent(
                        params: params,
                      ),
                    );
                    break;

                  case 2:
                    Map<String, dynamic> paramsChat = {
                      "chats": controller.text,
                    };
                    searchBloc.add(ChatEvent(params: paramsChat));
                    break;

                  case 3:
                    Map<String, dynamic> paramsWithImage = {
                      "text": controller.text,
                      "images": all
                    };
                    searchBloc.add(
                      SearchTextAndImageEvent(
                        params: paramsWithImage,
                      ),
                    );
                    break;
                  case 4:
                    Map<String, dynamic> paramsWithImage = {
                      "text": controller.text,
                      "images": all
                    };
                    searchBloc.add(
                      GenerateContentEvent(params: paramsWithImage),
                    );
                    break;
                  default:
                    Map<String, dynamic> params = {
                      "text": controller.text,
                    };
                    searchBloc.add(
                      SearchTextEvent(
                        params: params,
                      ),
                    );
                }
              }
            },

            onTap: () {
              // final gemini = Gemini.instance;

              // gemini.streamGenerateContent('Write a story on Gaza').listen((value) {
              //   print(value.output);
              // }).onError((e) {
              //   // print('streamGenerateContent exception', error: e);
              // });

              searchBloc2.add(AddMultipleImageEvent(noParams: NoParams()));
            },
            isTextAndImage: isTextImage,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes().width(context, 0.04),
            vertical: Sizes().height(context, 0.02)),
        child: BlocListener(
            bloc: searchBloc2,
            listener: (context, state) async {
              if (state is AddMultipleImageLoaded) {
                all.clear();
                data = "";
                question = "";
                // for (int i = 0; i < state.data.length; i++) {
                //   all.add(state.data[i]);
                // }

                final dataGet = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return SearchimageTextfield(
                    all: state.data,
                    textData: controller.text,
                  );
                }));

                controller.text = dataGet["text"];
                for (int i = 0; i < state.data.length; i++) {
                  all.add(state.data[i]);
                }
                form.currentState?.save();
                if (form.currentState?.validate() == true) {
                  print(dataGet);
                  searchBloc.add(
                    SearchTextAndImageEvent(
                      params: dataGet,
                    ),
                  );
                }
              }
              if (state is AddMultipleImageLoading) {
                //all.clear();
              }
              if (state is AddMultipleImageError) {
                if (!context.mounted) return;
                showErrorSnackbar(context, state.errorMessage);
                print("error ${state.errorMessage}");
              }
            },
            child: BlocConsumer(
                bloc: searchBloc,
                listener: (context, state) {
                  if (state is ChatLoaded ||
                      state is SearchTextLoaded ||
                      state is GenerateContentLoaded ||
                      state is SearchTextAndImageLoaded) {
                    question = controller.text;
                    controller.text = "";
                    all.clear();
                    form.currentState?.validate();
                  }
                  if (state is SearchTextAndImageLoaded) {
                    // controller.text=;
                  }

                  if (state is GenerateContentError) {
                    if (!context.mounted) return;
                    showErrorSnackbar(context, state.errorMessage);

                    controller.text = "";
                    question = controller.text;
                  }
                  if (state is SearchTextAndImageError) {
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

                  if (state is ChatLoaded) {
                    final data = state.data.content.parts.last.text;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(question ?? ""),
                          Space().height(context, 0.02),
                          Text(data),
                        ],
                      ),
                    );
                  }

                  if (state is GenerateContentLoaded) {
                    // StreamController s = StreamController();

                    final data = state.data.first.toString();

                    //  print(state.data.toString());
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
                        ],
                      ),
                    );
                  }
                  if (state is SearchTextAndImageLoaded) {
                    final data = state.data.content.parts.last.text;

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(question ?? ""),
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
                        ],
                      ),
                    );
                  }
                  if (state is SearchTextLoaded) {
                    final data = state.data.content.parts[0].text;
                    // final dataDeduct = data.length;
                    //print(dataDeduct);
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(question ?? ""),
                          Space().height(context, 0.02),
                          Text(data.toString()),
                        ],
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Center(child: Text(data))],
                  );
                })),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Space().height(context, 0.05),
            SearchTypeWidget(
              onPressed: () {
                type = 1;
                isTextImage = false;
                Navigator.pop(context);
                setState(() {});
              },
              label: "Text",
            ),
            SearchTypeWidget(
              onPressed: () {
                type = 3;
                isTextImage = true;
                Navigator.pop(context);
                setState(() {});
              },
              label: "Text with image",
            ),
            SearchTypeWidget(
              onPressed: () {
                type = 4;
                isTextImage = true;
                Navigator.pop(context);
                setState(() {});
              },
              label: "Generate content",
            ),
            SearchTypeWidget(
              onPressed: () {
                type = 2;
                isTextImage = false;
                Navigator.pop(context);
                setState(() {});
              },
              label: "Chat",
            ),
          ],
        ),
      ),
    );
  }
}
