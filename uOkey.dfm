object FormOkey: TFormOkey
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FormOkey'
  ClientHeight = 514
  ClientWidth = 508
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Source Code Pro'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    508
    514)
  TextHeight = 15
  object LabelSecretKey: TLabel
    Left = 24
    Top = 19
    Width = 133
    Height = 15
    Caption = #1057#1074#1086#1081' '#1089#1077#1082#1088#1077#1090#1085#1099#1081' '#1082#1083#1102#1095
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = []
    ParentFont = False
  end
  object LabelOutsidePublicKey: TLabel
    Left = 24
    Top = 238
    Width = 182
    Height = 15
    Caption = #1055#1091#1073#1083#1080#1095#1085#1099#1081' '#1082#1083#1102#1095' '#1089#1086#1073#1077#1089#1077#1076#1085#1080#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = []
    ParentFont = False
  end
  object LabelPublicKey: TLabel
    Left = 24
    Top = 84
    Width = 133
    Height = 15
    Caption = #1057#1074#1086#1081' '#1087#1091#1073#1083#1080#1095#1085#1099#1081' '#1082#1083#1102#1095
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = []
    ParentFont = False
  end
  object LabelNewSecretKey: TLabel
    Left = 351
    Top = 19
    Width = 133
    Height = 15
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    Caption = #1057#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1099#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = []
    ParentFont = False
    OnClick = LabelNewSecretKeyClick
  end
  object LabelCommonSecretKey: TLabel
    Left = 24
    Top = 392
    Width = 427
    Height = 30
    Caption = 
      #1042#1072#1096' '#1086#1073#1097#1080#1081' '#1089' '#1089#1086#1073#1077#1089#1077#1076#1085#1080#1082#1086#1084' '#1089#1077#1082#1088#1077#1090#1085#1099#1081' '#1082#1083#1102#1095'. '#1044#1077#1088#1078#1080#1090#1077' '#1101#1090#1086#1090' '#1082#1083#1102#1095' '#1074' '#1090#1072#1081 +
      #1085#1077'! '#1048#1089#1087#1086#1083#1100#1079#1091#1081#1090#1077' '#1077#1075#1086' '#1076#1083#1103' '#1096#1080#1092#1088#1086#1074#1072#1085#1080#1103' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '#1084#1077#1078#1076#1091' '#1074#1072#1084#1080'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object LabelHelp: TLabel
    Left = 407
    Top = 475
    Width = 77
    Height = 15
    Cursor = crHandPoint
    Anchors = [akRight, akBottom]
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = []
    ParentFont = False
    OnClick = LabelHelpClick
  end
  object MemoSecretKey: TMemo
    Left = 24
    Top = 39
    Width = 460
    Height = 39
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = MemoSecretKeyChange
    OnDblClick = MemoSecretKeyDblClick
    OnExit = MemoSecretKeyExit
  end
  object MemoOutsidePublicKey: TMemo
    Left = 24
    Top = 255
    Width = 460
    Height = 128
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = MemoOutsidePublicKeyChange
    OnDblClick = MemoOutsidePublicKeyDblClick
    OnExit = MemoOutsidePublicKeyExit
  end
  object MemoCommonSecretKey: TMemo
    Left = 24
    Top = 425
    Width = 460
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object MemoPublicKey: TMemo
    Left = 24
    Top = 101
    Width = 460
    Height = 128
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Source Code Pro'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    OnChange = MemoPublicKeyChange
    OnDblClick = MemoPublicKeyDblClick
  end
end
