import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

class ChipsOptions extends StatefulWidget {
  ChipsOptions(
      {required this.defaultPadding,
      required this.values,
      required this.onTap,
      required this.defaultSelected,
      this.margin = const EdgeInsets.symmetric(vertical: 10)});
  final EdgeInsetsGeometry defaultPadding;
  final EdgeInsetsGeometry margin;
  final List<String>? values;
  final Function(String) onTap;
  final int defaultSelected;

  @override
  _ChipsOptionsState createState() => _ChipsOptionsState();
}

class _ChipsOptionsState extends State<ChipsOptions> {
  String _chossen = '';

  void _seletedData(String val) {
    setState(() => _chossen = val);
    widget.onTap(val);
  }

  @override
  void didChangeDependencies() {
    if (widget.defaultSelected != null) {
      _chossen = widget.values![widget.defaultSelected];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.defaultPadding,
      // decoration: BoxDecoration(boxShadow: basicShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 8,
            spacing: 10.0,
            children: widget.values!
                .map((e) => e == _chossen
                    ? Chip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text(e,
                            style: Theme.of(context)
                                .accentTextTheme
                                .bodyText1!
                                .merge(TextStyle(fontWeight: FontWeight.w600))),
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    : GestureDetector(
                        onTap:
                            widget.onTap == null ? null : () => _seletedData(e),
                        child: Chip(
                            backgroundColor: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text(
                              e,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ))))
                .toList(),
          ),
        ],
      ),
    );
  }
}
