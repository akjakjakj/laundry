import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/utils/font_palette.dart';

class CustomTextField extends StatefulWidget {
  final double? height;
  final Widget? prefix;
  final String? labelText;
  final String? hintText;
  final TextStyle? hintStyle;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? textInputFormatter;
  final bool enableObscure;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool? isEditable;
  final bool? enabled;
  final Widget? suffix;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final Color? borderColor;

  const CustomTextField(
      {super.key,
      this.height,
      this.prefix,
      this.labelText,
      this.hintText,
      this.hintStyle,
      this.maxLength,
      this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.textInputFormatter,
      this.enableObscure = false,
      this.controller,
      this.textInputType,
      this.textInputAction,
      this.isEditable,
      this.enabled,
      this.focusNode,
      this.suffix,
      this.textCapitalization,
      this.autofocus,
      this.borderColor});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode focusNode;
  bool obscureStat = false;

  UnderlineInputBorder borderColor(Color color) => UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      );

  Widget _obscureBtn() {
    return IconButton(
      icon: obscureStat
          ? const Icon(CupertinoIcons.eye_fill)
          : const Icon(CupertinoIcons.eye_slash_fill),
      splashColor: Colors.transparent,
      onPressed: () {
        setState(() {
          obscureStat = !obscureStat;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      controller: widget.controller,
      focusNode: focusNode,
      style: FontPalette.poppinsRegular.copyWith(color: ColorPalette.hintColor),
      height: widget.height ?? 50.h,
      focusedBorder: borderColor(ColorPalette.greenColor),
      enabledBorder: borderColor(ColorPalette.greenColor),
      contentPadding: EdgeInsets.only(bottom: 12.h),
      validator: widget.validator,
      hintText: widget.hintText,
      hintStyle: widget.hintStyle,
      labelStyle: FontPalette.poppinsBold
          .copyWith(color: ColorPalette.secondaryColor, fontSize: 15.sp),
      expandedLabelStyle:
          FontPalette.poppinsBold.copyWith(color: ColorPalette.secondaryColor),
      labelText: widget.labelText,
      onChanged:
          widget.onChanged != null ? (val) => widget.onChanged!(val) : null,
      onFieldSubmitted: widget.onFieldSubmitted,
      prefix: widget.prefix,
      maxLength: widget.maxLength,
      suffixIcon:
          widget.suffix ?? (widget.enableObscure ? _obscureBtn() : null),
      inputFormatters: widget.textInputFormatter,
      obscureStat: obscureStat,
      textInputType: widget.textInputType,
      textInputAction: widget.textInputAction,
      hasFocus: focusNode.hasFocus,
      isEditable: widget.isEditable ?? true,
      isEnabled: widget.enabled ?? true,
      textCaps: widget.textCapitalization,
      autofocus: widget.autofocus,
    );
  }

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    obscureStat = widget.enableObscure;
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }
}

class CustomForm extends FormField<String> {
  final double? height;
  final TextEditingController? controller;
  final UnderlineInputBorder? focusedBorder;
  final UnderlineInputBorder? enabledBorder;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final int? maxLength;
  final Widget? prefix;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? expandedLabelStyle;
  final TextStyle? hintStyle;
  final String? labelText;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final EdgeInsets? contentPadding;
  final Function(String)? onFieldSubmitted;
  final String initValue;
  final bool obscureStat;
  final bool hasFocus;
  final bool isEditable;
  final bool isEnabled;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCaps;
  final bool? autofocus;

  CustomForm({
    super.key,
    super.onSaved,
    super.validator,
    this.height,
    this.controller,
    this.focusedBorder,
    this.enabledBorder,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.prefix,
    this.suffixIcon,
    this.style,
    this.labelStyle,
    this.expandedLabelStyle,
    this.hintStyle,
    this.labelText,
    this.hintText,
    this.inputFormatters,
    this.textInputType,
    this.contentPadding,
    this.onFieldSubmitted,
    this.initValue = '',
    this.obscureStat = false,
    this.hasFocus = false,
    this.isEditable = true,
    this.isEnabled = true,
    this.textInputAction,
    this.textCaps,
    this.autofocus,
  }) : super(
            initialValue: initValue,
            autovalidateMode: AutovalidateMode.disabled,
            builder: (FormFieldState<String> state) {
              UnderlineInputBorder border = UnderlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                      color: state.hasError
                          ? HexColor("E50019")
                          : HexColor('#DBDBDB'),
                      width: 1.r));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height ?? 45.h,
                    child: TextFormField(
                      focusNode: focusNode,
                      controller: controller,
                      autofocus: autofocus ?? false,
                      textCapitalization: textCaps ?? TextCapitalization.none,
                      style: style,
                      onTap: onTap,
                      obscureText: obscureStat,
                      inputFormatters: inputFormatters,
                      keyboardType: textInputType,
                      textInputAction: textInputAction,
                      maxLength: maxLength,
                      readOnly: !isEditable,
                      enabled: isEnabled,
                      onChanged: (val) {
                        state.reset();
                        state.didChange(val);
                        if (onChanged != null) onChanged(val);
                      },
                      onFieldSubmitted: onFieldSubmitted,
                      decoration: InputDecoration(
                          border: state.hasError ? border : enabledBorder,
                          prefix: prefix,
                          suffixIcon: suffixIcon,
                          prefixIconConstraints: const BoxConstraints(
                              minHeight: 20, minWidth: 40, maxHeight: 20),
                          counterText: '',
                          focusedBorder:
                              state.hasError ? border : focusedBorder,
                          enabledBorder: state.hasError
                              ? border
                              : hasFocus
                                  ? focusedBorder
                                  : enabledBorder,
                          contentPadding: contentPadding,
                          errorBorder: border,
                          labelText: labelText,
                          hintText: hintText,
                          labelStyle: (focusNode?.hasFocus ?? false) ||
                                  (state.value ?? '').isNotEmpty
                              ? state.hasError
                                  ? expandedLabelStyle?.copyWith(
                                      color: HexColor("E50019"))
                                  : expandedLabelStyle
                              : state.hasError
                                  ? labelStyle?.copyWith(
                                      color: HexColor("E50019"))
                                  : labelStyle,
                          hintStyle: hintStyle ??
                              FontPalette.poppinsRegular
                                  .copyWith(color: ColorPalette.hintColor),
                          floatingLabelBehavior: state.hasError
                              ? FloatingLabelBehavior.always
                              : hasFocus
                                  ? FloatingLabelBehavior.always
                                  : FloatingLabelBehavior.always),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state.hasError
                        ? Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              state.errorText ?? '',
                              style: FontPalette.poppinsRegular
                                  .copyWith(color: HexColor("E50019")),
                            ),
                          )
                        : const SizedBox.shrink(),
                  )
                ],
              );
            });
}
