import 'package:flutter/material.dart';
import 'package:rx_project/core/services/route_service/app_routing.dart' show RouteService;
import 'package:rx_project/core/utils/app_extension.dart';
import 'package:rx_project/generated/s.dart';

BuildContext get ctx => RouteService.navigatorKey.currentState!.context;

double deviceHeight = MediaQuery.of(ctx).size.height;
double deviceWidth = MediaQuery.of(ctx).size.width;

S? get L => ctx.L;
