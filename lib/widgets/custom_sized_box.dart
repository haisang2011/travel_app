import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

enum SizedBoxEnum {
  h1,
  h2,
  h3,
  h4,
  h5,
}

class _CustomSizedBox extends StatelessWidget {
  final SizedBoxEnum type;
  
  const _CustomSizedBox({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SizedBoxEnum.h1:
        return SizedBox(height: 1.h,);
      case SizedBoxEnum.h2:
        return SizedBox(height: 2.h,);
      case SizedBoxEnum.h3:
        return SizedBox(height: 3.h,);
      case SizedBoxEnum.h4:
        return SizedBox(height: 4.h,);
      case SizedBoxEnum.h5:
        return SizedBox(height: 5.h,);
      default:
        return const SizedBox();
    }
  }
}

class SizedBoxH1 extends _CustomSizedBox {
  const SizedBoxH1(): super(type: SizedBoxEnum.h1);
}

class SizedBoxH2 extends _CustomSizedBox {
  const SizedBoxH2(): super(type: SizedBoxEnum.h2);
}

class SizedBoxH3 extends _CustomSizedBox {
  const SizedBoxH3(): super(type: SizedBoxEnum.h3);
}

class SizedBoxH4 extends _CustomSizedBox {
  const SizedBoxH4(): super(type: SizedBoxEnum.h4);
}

class SizedBoxH5 extends _CustomSizedBox {
  const SizedBoxH5(): super(type: SizedBoxEnum.h5);
}