unit uOkey;

interface

uses
  uHelp,
  FGInt,
  DH,
  Vcl.Graphics,
  Vcl.Forms,
  Vcl.Controls,
  System.Classes,
  System.SysUtils,
  Vcl.StdCtrls,
  Windows;

type
  TFormOkey = class(TForm)
    LabelSecretKey: TLabel;
    LabelNewSecretKey: TLabel;
    LabelPublicKey: TLabel;
    LabelOutsidePublicKey: TLabel;
    LabelCommonSecretKey: TLabel;
    LabelHelp: TLabel;
    MemoSecretKey: TMemo;
    MemoPublicKey: TMemo;
    MemoOutsidePublicKey: TMemo;
    MemoCommonSecretKey: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LabelNewSecretKeyClick(Sender: TObject);
    procedure MemoOutsidePublicKeyChange(Sender: TObject);
    procedure MemoSecretKeyChange(Sender: TObject);
    procedure LabelHelpClick(Sender: TObject);
    procedure MemoPublicKeyChange(Sender: TObject);
    procedure MemoSecretKeyDblClick(Sender: TObject);
    procedure MemoOutsidePublicKeyDblClick(Sender: TObject);
    procedure MemoPublicKeyDblClick(Sender: TObject);
    procedure MemoSecretKeyExit(Sender: TObject);
    procedure MemoOutsidePublicKeyExit(Sender: TObject);
  private
    DiffieHellman: TDiffieHellman;
    function FGIntRandom(BitSize: Word): TFGInt;
  public
    function GetVersionStr(s: string): string;
  end;

var
  FormOkey: TFormOkey;
  OkeyVersion: Double;
  OkeyLastVersion: Double;
  OkeyLastVersionStr: string;
  OkeyReadMe: TStringList;

const
  sName = 'Okey';
  sVersion = 'Версия';
  sSlogan = 'Так надёжнее';
  sReadMeURL
    : string = 'https://raw.githubusercontent.com/kobprog/Okey/main/README.md';
  sExeURL: string =
    'https://raw.githubusercontent.com/kobprog/Okey/main/Okey.exe';
  sCheckUpdate: string = 'Проверить обновление';
  sLastVersion: string = 'Это крайняя версия';
  sError: string = 'Ошибка! Повторить';
  sDownload: string = 'Скачать версию';
  sMemoSecretKeyText =
    'Вставьте сюда ваш секретный ключ или сгенерируйте новый.' + #13#10 +
    'Никому не сообщайте этот ключ!';
  sMemoPublicKeyText =
    'Этот ключ будет рассчитан автоматически при установке секретного ключа. Отправьте этот ключ собеседнику.';
  sMemoOutsidePublicKeyText =
    'Запросите у собеседника его публичный ключ, скопируйте и вставьте сюда.';

implementation

{$R *.dfm}

function TFormOkey.GetVersionStr(s: string): string;
var
  k: Integer;
  i: Integer;
begin
  Result := '';
  k := Pos(sVersion, s, 1) + 7;
  if k > 7 then
    for i := k to Length(s) do
      if s[i] in ['0' .. '9', '.'] then
        Result := Result + s[i]
      else
        Break;
end;

function TFormOkey.FGIntRandom(BitSize: Word): TFGInt;
var
  PRNG: TPRNGenerator;
  W: LongWord;
  s: string;
  i: Integer;
begin
  PRNG := TPRNGenerator.Create;
  s := '';
  for i := 0 to BitSize div 32 - 1 do
  begin
    W := PRNG.NextLongWord;
    s := s + DataToBitStr(@W, 32);
  end;
  if BitSize mod 32 > 0 then
  begin
    W := PRNG.NextLongWord;
    s := s + DataToBitStr(@W, BitSize mod 32);
  end;
  Base2stringToFGInt(s, Result);
  FreeAndNil(PRNG);
end;

procedure TFormOkey.FormCreate(Sender: TObject);
var
  Rs: TResourceStream;
  s: string;
begin
  OkeyReadMe := TStringList.Create;
  Rs := TResourceStream.Create(HInstance, 'README', RT_RCDATA);
  OkeyReadMe.LoadFromStream(Rs);
  OkeyReadMe.Text := UTF8Decode(OkeyReadMe.Text);
  Rs.Destroy;
  s := GetVersionStr(OkeyReadMe.Strings[0]);
  OkeyVersion := 0;
  OkeyLastVersion := 0;
  if s <> '' then
  begin
    OkeyVersion := StrToFloat(s.Replace('.', ','));
    s := s + ' ';
  end;
  Caption := sName + ' ' + s + '- ' + sSlogan;
  DiffieHellman := TDiffieHellman.Create;
  DiffieHellman.SetParamsRFC7919;
  MemoSecretKey.Text := sMemoSecretKeyText;
  MemoPublicKey.Text := sMemoPublicKeyText;
  MemoOutsidePublicKey.Text := sMemoOutsidePublicKeyText;
  MemoCommonSecretKey.Text := '...';
end;

procedure TFormOkey.FormDestroy(Sender: TObject);
begin
  DiffieHellman.Destroy;
  OkeyReadMe.Destroy;
end;

procedure TFormOkey.LabelNewSecretKeyClick(Sender: TObject);
var
  s: string;
begin
  FGIntToBase2string(FGIntRandom(512), s);
  DiffieHellman.SetSecret(BitStrToHex(s));
  MemoSecretKey.Text := DiffieHellman.SecretKey;
  MemoPublicKey.Text := DiffieHellman.PublicKey;
end;

procedure TFormOkey.LabelHelpClick(Sender: TObject);
begin
  FormHelp.Caption := 'О программе';
  FormHelp.ShowModal;
end;

procedure TFormOkey.MemoOutsidePublicKeyChange(Sender: TObject);
var
  Correct: Boolean;
  s: string;
  i: Integer;
begin
  if (Length(MemoSecretKey.Text) = 128) and
    (Length(MemoOutsidePublicKey.Text) = 512) then
  begin
    Correct := True;
    s := MemoOutsidePublicKey.Text;
    for i := 1 to Length(s) do
      if not(s[i] in ['0' .. '9', 'A' .. 'F']) then
        Correct := False;
    if Correct then
    begin
      DiffieHellman.CalcCommonSecretKey(MemoOutsidePublicKey.Text);
      MemoCommonSecretKey.Text := DiffieHellman.CommonSecretKey;
    end;
  end
  else
    MemoCommonSecretKey.Text := '...';
end;

procedure TFormOkey.MemoOutsidePublicKeyDblClick(Sender: TObject);
begin
  MemoOutsidePublicKey.SelectAll;
end;

procedure TFormOkey.MemoOutsidePublicKeyExit(Sender: TObject);
begin
  if MemoOutsidePublicKey.Text = '' then
    MemoOutsidePublicKey.Text := sMemoOutsidePublicKeyText;
end;

procedure TFormOkey.MemoPublicKeyChange(Sender: TObject);
begin
  MemoOutsidePublicKeyChange(Self);
end;

procedure TFormOkey.MemoPublicKeyDblClick(Sender: TObject);
begin
  MemoPublicKey.SelectAll;
end;

procedure TFormOkey.MemoSecretKeyChange(Sender: TObject);
var
  s: string;
  i: Integer;
  Correct: Boolean;
begin
  if (Length(MemoSecretKey.Text) = 128) then
  begin
    Correct := True;
    s := MemoSecretKey.Text;
    for i := 1 to Length(s) do
      if not(s[i] in ['0' .. '9', 'A' .. 'F']) then
        Correct := False;
    if Correct then
    begin
      DiffieHellman.SetSecret(MemoSecretKey.Text);
      MemoPublicKey.Text := DiffieHellman.PublicKey;
    end;
  end
  else
    MemoPublicKey.Text := sMemoPublicKeyText;
end;

procedure TFormOkey.MemoSecretKeyDblClick(Sender: TObject);
begin
  MemoSecretKey.SelectAll;
end;

procedure TFormOkey.MemoSecretKeyExit(Sender: TObject);
begin
  if MemoSecretKey.Text = '' then
    MemoSecretKey.Text := sMemoSecretKeyText;
end;

end.
