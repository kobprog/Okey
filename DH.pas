{
  Модуль реализует генератор псевдослучайных чисел на основе MRG32k3a (L’Ecuyer)
  и протокол Диффи-Хеллмана-Меркла - криптографический протокол,
  позволяющий двум и более сторонам получить общий секретный ключ, используя
  незащищенный от прослушивания канал связи. Полученный ключ используется для
  шифрования дальнейшего обмена с помощью алгоритмов симметричного шифрования.

  Не пересылайте пароли в SMS! Так надёжнее.
}

unit DH;

interface

uses
  FGInt,
  System.DateUtils,
  System.SysUtils,
  System.Hash;

type

{$POINTERMATH ON}
  TByteBuffer = ^Byte;
  TWordBuffer = ^Word;
  TLongWordBuffer = ^LongWord;
{$POINTERMATH OFF}

type

  { Генератор псевдослучайных чисел на основе MRG32k3a (L’Ecuyer) }

  TPRNGenerator = class(TObject)
  private const
    a1: array [0 .. 2] of Integer = (0, 1403580, - 810728);
    a2: array [0 .. 2] of Integer = (527612, 0, - 1370589);
    m1: LongWord = 4294967087;
    m2: LongWord = 4294944443;
  private
    x1, x2: array [0 .. 2] of Int64;
    function Modulo(x: Int64; Y: LongWord): LongWord;
    function Next: LongWord; overload;
  public
    constructor Create;
    procedure Init(Seed: Int64);
    // Генерация целого в диапазоне [0, Range)
    function Next(Range: Int64): Int64; overload;
    // Генерация Float в диапазоне (0, 1)
    function NextFloat: Extended;
    // Генерация Byte
    function NextByte: Byte;
    // Генерация Word
    function NextWord: Word;
    // Генерация LongWord
    function NextLongWord: LongWord;
    // Заполнение буфера
    procedure Fill(Buffer: Pointer; Count: Integer);
  end;

  { Реализация протокола Диффи-Хеллмана-Меркла }

  TDiffieHellman = class(TObject)
  private
    FPrime: TFGInt; // Большое простое число p
    // (p-1)/2 также должно быть простым числом
    FGenerator: TFGInt; // Первообразный корень g по модулю p
    FSecretKey: TFGInt; // Cлучайное натуральное число 1 < a < p
    FPublicKey: TFGInt; // A = g^a mod p
    FOutsidePublicKey: TFGInt; // B
    FCommonSecretKey: TFGInt; // S = B^a mod p
    FHexGenerator: string;
    FHexCommonSecretKey: string;
    FHexPublicKey: string;
    FHexPrime: string;
    FHexSecretKey: string;
  public
    constructor Create;
    // Установка произвольных параметров
    procedure SetParams(HexPrime, HexGenerator: string);
    // Установка параметров по RFC-3526
    procedure SetParamsRFC3526(pLen: Word = 2048);
    // Установка параметров по RFC-7919
    procedure SetParamsRFC7919(pLen: Word = 2048);
    // Установка своего секретного ключа и вычисление своего публичного ключа
    procedure SetSecret(HexSecret: string);
    // Вычисление общего секретного ключа
    procedure CalcCommonSecretKey(HexOutsidePublic: string);
    //
    property PublicKey: string read FHexPublicKey;
    property SecretKey: string read FHexSecretKey;
    property CommonSecretKey: string read FHexCommonSecretKey;
  end;

function HexToBitStr(Hex: string): string;
function BitStrToHex(BitStr: string): string;
procedure DataToBoolArray(Data, BoolArray: Pointer; BitCount: LongWord);
function DataToBitStr(Data: Pointer; BitCount: Word): string;

var
  m, one: TFGInt;
  ByteToInt64: array [0 .. 255] of Int64;

implementation

function HexToBitStr(Hex: string): string;
const
  HexArr: array [0 .. 15] of string = ('0000', '0001', '0010', '0011', '0100',
    '0101', '0110', '0111', '1000', '1001', '1010', '1011', '1100', '1101',
    '1110', '1111');
var
  i: Integer;
begin
  Result := '';
  for i := Length(Hex) downto 1 do
    Result := HexArr[StrToInt('$' + Hex[i])] + Result;
end;

function BitStrToHex(BitStr: string): string;
var
  Len: Integer;
  s, h: string;
  i: Integer;
begin
  Result := '';
  s := BitStr;
  while Length(s) mod 8 > 0 do
    s := '0' + s;
  Len := Length(s) div 4;
  for i := 0 to Len - 1 do
  begin
    h := Copy(s, i * 4 + 1, 4);
    if h = '0000' then
      h := '0'
    else if h = '0001' then
      h := '1'
    else if h = '0010' then
      h := '2'
    else if h = '0011' then
      h := '3'
    else if h = '0100' then
      h := '4'
    else if h = '0101' then
      h := '5'
    else if h = '0110' then
      h := '6'
    else if h = '0111' then
      h := '7'
    else if h = '1000' then
      h := '8'
    else if h = '1001' then
      h := '9'
    else if h = '1010' then
      h := 'A'
    else if h = '1011' then
      h := 'B'
    else if h = '1100' then
      h := 'C'
    else if h = '1101' then
      h := 'D'
    else if h = '1110' then
      h := 'E'
    else if h = '1111' then
      h := 'F';
    Result := Result + h;
  end;
end;

procedure DataToBoolArray(Data, BoolArray: Pointer; BitCount: LongWord);
var
  i, j: Integer;
  Int64Arr: TByteBuffer;
begin
  GetMem(Int64Arr, 8);
  if BitCount div 8 > 0 then
    for i := 0 to (BitCount div 8) - 1 do
    begin
      PInt64(Int64Arr)^ := ByteToInt64[TByteBuffer(Data)[i]];
      for j := 0 to 7 do
        TByteBuffer(BoolArray)[i * 8 + j] := Int64Arr[j];
    end;
  if BitCount mod 8 > 0 then
  begin
    PInt64(Int64Arr)^ := ByteToInt64[TByteBuffer(Data)[BitCount div 8]];
    for j := 0 to BitCount mod 8 - 1 do
      TByteBuffer(BoolArray)[(BitCount div 8) * 8 + j] := Int64Arr[j];
  end;
  FreeMem(Int64Arr);
end;

function DataToBitStr(Data: Pointer; BitCount: Word): string;
var
  i: Integer;
  sBit: string;
  BoolBuffer: TByteBuffer;
begin
  sBit := '';
  GetMem(BoolBuffer, BitCount);
  DataToBoolArray(Data, BoolBuffer, BitCount);
  for i := 0 to BitCount - 1 do
    sBit := sBit + BoolBuffer[i].ToString;
  FreeMem(BoolBuffer);
  Result := sBit;
end;

{ TDiffieHellman }

procedure TDiffieHellman.CalcCommonSecretKey(HexOutsidePublic: string);
var
  s: string;
  Hash512: THashSHA2;
begin
  Base2stringToFGInt(HexToBitStr(HexOutsidePublic), FOutsidePublicKey);
  FGIntModExp(FOutsidePublicKey, FSecretKey, FPrime, FCommonSecretKey);
  FGIntToBase2string(FCommonSecretKey, s);
  FGIntToBase2string(FCommonSecretKey, s);
  Hash512 := THashSHA2.Create(SHA256);
  Hash512.Reset;
  Hash512.Update(s);
  FHexCommonSecretKey := UpperCase(Hash512.HashAsString);
end;

constructor TDiffieHellman.Create;
begin
  FPrime.Number := nil;
  FGenerator.Number := nil;
  FSecretKey.Number := nil;
  FPublicKey.Number := nil;
  FOutsidePublicKey.Number := nil;
  FCommonSecretKey.Number := nil;
end;

procedure TDiffieHellman.SetParams(HexPrime, HexGenerator: string);
begin
  Base2stringToFGInt(HexToBitStr(HexPrime), FPrime);
  Base2stringToFGInt(HexToBitStr(HexGenerator), FGenerator);
  FHexPrime := HexPrime;
  FHexGenerator := HexGenerator;
end;

procedure TDiffieHellman.SetParamsRFC3526(pLen: Word = 2048);
var
  s: string;
begin
  s := '';
  case pLen of
    2048: // 2048 bit
      s := 'FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC7402'
        + '0BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE13'
        + '56D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB'
        + '5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C5'
        + '5D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED52907709696'
        + '6D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039'
        + 'B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2'
        + '261898FA051015728E5A8AACAA68FFFFFFFFFFFFFFFF';
    3072: // 3072 bit
      s := 'FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC7402'
        + '0BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE13'
        + '56D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB'
        + '5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C5'
        + '5D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED52907709696'
        + '6D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039'
        + 'B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2'
        + '261898FA051015728E5A8AAAC42DAD33170D04507A33A85521ABDF1CBA64ECFB850'
        + '458DBEF0A8AEA71575D060C7DB3970F85A6E1E4C7ABF5AE8CDB0933D71E8C94E04A'
        + '25619DCEE3D2261AD2EE6BF12FFA06D98A0864D87602733EC86A64521F2B18177B2'
        + '00CBBE117577A615D6C770988C0BAD946E208E24FA074E5AB3143DB5BFCE0FD108E'
        + '4B82D120A93AD2CAFFFFFFFFFFFFFFFF';
    4096: // 4096 bit
      s := 'FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC7402'
        + '0BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE13'
        + '56D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB'
        + '5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C5'
        + '5D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED52907709696'
        + '6D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039'
        + 'B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2'
        + '261898FA051015728E5A8AAAC42DAD33170D04507A33A85521ABDF1CBA64ECFB850'
        + '458DBEF0A8AEA71575D060C7DB3970F85A6E1E4C7ABF5AE8CDB0933D71E8C94E04A'
        + '25619DCEE3D2261AD2EE6BF12FFA06D98A0864D87602733EC86A64521F2B18177B2'
        + '00CBBE117577A615D6C770988C0BAD946E208E24FA074E5AB3143DB5BFCE0FD108E'
        + '4B82D120A92108011A723C12A787E6D788719A10BDBA5B2699C327186AF4E23C1A9'
        + '46834B6150BDA2583E9CA2AD44CE8DBBBC2DB04DE8EF92E8EFC141FBECAA6287C59'
        + '474E6BC05D99B2964FA090C3A2233BA186515BE7ED1F612970CEE2D7AFB81BDD762'
        + '170481CD0069127D5B05AA993B4EA988D8FDDC186FFB7DC90A6C08F4DF435C93406'
        + '3199FFFFFFFFFFFFFFFF';
    6144: // 6144 bit
      s := 'FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC7402'
        + '0BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE13'
        + '56D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB'
        + '5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C5'
        + '5D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED52907709696'
        + '6D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039'
        + 'B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2'
        + '261898FA051015728E5A8AAAC42DAD33170D04507A33A85521ABDF1CBA64ECFB850'
        + '458DBEF0A8AEA71575D060C7DB3970F85A6E1E4C7ABF5AE8CDB0933D71E8C94E04A'
        + '25619DCEE3D2261AD2EE6BF12FFA06D98A0864D87602733EC86A64521F2B18177B2'
        + '00CBBE117577A615D6C770988C0BAD946E208E24FA074E5AB3143DB5BFCE0FD108E'
        + '4B82D120A92108011A723C12A787E6D788719A10BDBA5B2699C327186AF4E23C1A9'
        + '46834B6150BDA2583E9CA2AD44CE8DBBBC2DB04DE8EF92E8EFC141FBECAA6287C59'
        + '474E6BC05D99B2964FA090C3A2233BA186515BE7ED1F612970CEE2D7AFB81BDD762'
        + '170481CD0069127D5B05AA993B4EA988D8FDDC186FFB7DC90A6C08F4DF435C93402'
        + '849236C3FAB4D27C7026C1D4DCB2602646DEC9751E763DBA37BDF8FF9406AD9E530'
        + 'EE5DB382F413001AEB06A53ED9027D831179727B0865A8918DA3EDBEBCF9B14ED44'
        + 'CE6CBACED4BB1BDB7F1447E6CC254B332051512BD7AF426FB8F401378CD2BF5983C'
        + 'A01C64B92ECF032EA15D1721D03F482D7CE6E74FEF6D55E702F46980C82B5A84031'
        + '900B1C9E59E7C97FBEC7E8F323A97A7E36CC88BE0F1D45B7FF585AC54BD407B22B4'
        + '154AACC8F6D7EBF48E1D814CC5ED20F8037E0A79715EEF29BE32806A1D58BB7C5DA'
        + '76F550AA3D8A1FBFF0EB19CCB1A313D55CDA56C9EC2EF29632387FE8D76E3C04680'
        + '43E8F663F4860EE12BF2D5B0B7474D6E694F91E6DCC4024FFFFFFFFFFFFFFFF';
    8192: // 8192 bit
      s := 'FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC7402'
        + '0BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE13'
        + '56D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB'
        + '5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C5'
        + '5D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED52907709696'
        + '6D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039'
        + 'B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2'
        + '261898FA051015728E5A8AAAC42DAD33170D04507A33A85521ABDF1CBA64ECFB850'
        + '458DBEF0A8AEA71575D060C7DB3970F85A6E1E4C7ABF5AE8CDB0933D71E8C94E04A'
        + '25619DCEE3D2261AD2EE6BF12FFA06D98A0864D87602733EC86A64521F2B18177B2'
        + '00CBBE117577A615D6C770988C0BAD946E208E24FA074E5AB3143DB5BFCE0FD108E'
        + '4B82D120A92108011A723C12A787E6D788719A10BDBA5B2699C327186AF4E23C1A9'
        + '46834B6150BDA2583E9CA2AD44CE8DBBBC2DB04DE8EF92E8EFC141FBECAA6287C59'
        + '474E6BC05D99B2964FA090C3A2233BA186515BE7ED1F612970CEE2D7AFB81BDD762'
        + '170481CD0069127D5B05AA993B4EA988D8FDDC186FFB7DC90A6C08F4DF435C93402'
        + '849236C3FAB4D27C7026C1D4DCB2602646DEC9751E763DBA37BDF8FF9406AD9E530'
        + 'EE5DB382F413001AEB06A53ED9027D831179727B0865A8918DA3EDBEBCF9B14ED44'
        + 'CE6CBACED4BB1BDB7F1447E6CC254B332051512BD7AF426FB8F401378CD2BF5983C'
        + 'A01C64B92ECF032EA15D1721D03F482D7CE6E74FEF6D55E702F46980C82B5A84031'
        + '900B1C9E59E7C97FBEC7E8F323A97A7E36CC88BE0F1D45B7FF585AC54BD407B22B4'
        + '154AACC8F6D7EBF48E1D814CC5ED20F8037E0A79715EEF29BE32806A1D58BB7C5DA'
        + '76F550AA3D8A1FBFF0EB19CCB1A313D55CDA56C9EC2EF29632387FE8D76E3C04680'
        + '43E8F663F4860EE12BF2D5B0B7474D6E694F91E6DBE115974A3926F12FEE5E43877'
        + '7CB6A932DF8CD8BEC4D073B931BA3BC832B68D9DD300741FA7BF8AFC47ED2576F69'
        + '36BA424663AAB639C5AE4F5683423B4742BF1C978238F16CBE39D652DE3FDB8BEFC'
        + '848AD922222E04A4037C0713EB57A81A23F0C73473FC646CEA306B4BCBC8862F838'
        + '5DDFA9D4B7FA2C087E879683303ED5BDD3A062B3CF5B3A278A66D2A13F83F44F82D'
        + 'DF310EE074AB6A364597E899A0255DC164F31CC50846851DF9AB48195DED7EA1B1D'
        + '510BD7EE74D73FAF36BC31ECFA268359046F4EB879F924009438B481C6CD7889A00'
        + '2ED5EE382BC9190DA6FC026E479558E4475677E9AA9E3050E2765694DFC81F56E88'
        + '0B96E7160C980DD98EDD3DFFFFFFFFFFFFFFFFF';
  end;
  if s <> '' then
    SetParams(s, '2');
end;

procedure TDiffieHellman.SetParamsRFC7919(pLen: Word);
var
  s: string;
begin
  s := '';
  case pLen of
    2048: // 2048 bit
      s := 'FFFFFFFFFFFFFFFFADF85458A2BB4A9AAFDC5620273D3CF1D8B9C583CE2D3695A9'
        + 'E13641146433FBCC939DCE249B3EF97D2FE363630C75D8F681B202AEC4617AD3DF' +
        '1ED5D5FD65612433F51F5F066ED0856365553DED1AF3B557135E7F57C935984F0C' +
        '70E0E68B77E2A689DAF3EFE8721DF158A136ADE73530ACCA4F483A797ABC0AB182' +
        'B324FB61D108A94BB2C8E3FBB96ADAB760D7F4681D4F42A3DE394DF4AE56EDE763' +
        '72BB190B07A7C8EE0A6D709E02FCE1CDF7E2ECC03404CD28342F619172FE9CE985' +
        '83FF8E4F1232EEF28183C3FE3B1B4C6FAD733BB5FCBC2EC22005C58EF1837D1683' +
        'B2C6F34A26C1B2EFFA886B423861285C97FFFFFFFFFFFFFFFF';
    3072: // 3072 bit
      s := 'FFFFFFFFFFFFFFFFADF85458A2BB4A9AAFDC5620273D3CF1D8B9C583CE2D3695A9'
        + 'E13641146433FBCC939DCE249B3EF97D2FE363630C75D8F681B202AEC4617AD3DF' +
        '1ED5D5FD65612433F51F5F066ED0856365553DED1AF3B557135E7F57C935984F0C' +
        '70E0E68B77E2A689DAF3EFE8721DF158A136ADE73530ACCA4F483A797ABC0AB182' +
        'B324FB61D108A94BB2C8E3FBB96ADAB760D7F4681D4F42A3DE394DF4AE56EDE763' +
        '72BB190B07A7C8EE0A6D709E02FCE1CDF7E2ECC03404CD28342F619172FE9CE985' +
        '83FF8E4F1232EEF28183C3FE3B1B4C6FAD733BB5FCBC2EC22005C58EF1837D1683' +
        'B2C6F34A26C1B2EFFA886B4238611FCFDCDE355B3B6519035BBC34F4DEF99C0238' +
        '61B46FC9D6E6C9077AD91D2691F7F7EE598CB0FAC186D91CAEFE130985139270B4' +
        '130C93BC437944F4FD4452E2D74DD364F2E21E71F54BFF5CAE82AB9C9DF69EE86D' +
        '2BC522363A0DABC521979B0DEADA1DBF9A42D5C4484E0ABCD06BFA53DDEF3C1B20' +
        'EE3FD59D7C25E41D2B66C62E37FFFFFFFFFFFFFFFF';
    4096: // 4096 bit
      s := 'FFFFFFFFFFFFFFFFADF85458A2BB4A9AAFDC5620273D3CF1D8B9C583CE2D3695A9'
        + 'E13641146433FBCC939DCE249B3EF97D2FE363630C75D8F681B202AEC4617AD3DF' +
        '1ED5D5FD65612433F51F5F066ED0856365553DED1AF3B557135E7F57C935984F0C' +
        '70E0E68B77E2A689DAF3EFE8721DF158A136ADE73530ACCA4F483A797ABC0AB182' +
        'B324FB61D108A94BB2C8E3FBB96ADAB760D7F4681D4F42A3DE394DF4AE56EDE763' +
        '72BB190B07A7C8EE0A6D709E02FCE1CDF7E2ECC03404CD28342F619172FE9CE985' +
        '83FF8E4F1232EEF28183C3FE3B1B4C6FAD733BB5FCBC2EC22005C58EF1837D1683' +
        'B2C6F34A26C1B2EFFA886B4238611FCFDCDE355B3B6519035BBC34F4DEF99C0238' +
        '61B46FC9D6E6C9077AD91D2691F7F7EE598CB0FAC186D91CAEFE130985139270B4' +
        '130C93BC437944F4FD4452E2D74DD364F2E21E71F54BFF5CAE82AB9C9DF69EE86D' +
        '2BC522363A0DABC521979B0DEADA1DBF9A42D5C4484E0ABCD06BFA53DDEF3C1B20' +
        'EE3FD59D7C25E41D2B669E1EF16E6F52C3164DF4FB7930E9E4E58857B6AC7D5F42' +
        'D69F6D187763CF1D5503400487F55BA57E31CC7A7135C886EFB4318AED6A1E012D' +
        '9E6832A907600A918130C46DC778F971AD0038092999A333CB8B7A1A1DB93D7140' +
        '003C2A4ECEA9F98D0ACC0A8291CDCEC97DCF8EC9B55A7F88A46B4DB5A851F44182' +
        'E1C68A007E5E655F6AFFFFFFFFFFFFFFFF';
    6144: // 6144 bit
      s := 'FFFFFFFFFFFFFFFFADF85458A2BB4A9AAFDC5620273D3CF1D8B9C583CE2D3695A9'
        + 'E13641146433FBCC939DCE249B3EF97D2FE363630C75D8F681B202AEC4617AD3DF' +
        '1ED5D5FD65612433F51F5F066ED0856365553DED1AF3B557135E7F57C935984F0C' +
        '70E0E68B77E2A689DAF3EFE8721DF158A136ADE73530ACCA4F483A797ABC0AB182' +
        'B324FB61D108A94BB2C8E3FBB96ADAB760D7F4681D4F42A3DE394DF4AE56EDE763' +
        '72BB190B07A7C8EE0A6D709E02FCE1CDF7E2ECC03404CD28342F619172FE9CE985' +
        '83FF8E4F1232EEF28183C3FE3B1B4C6FAD733BB5FCBC2EC22005C58EF1837D1683' +
        'B2C6F34A26C1B2EFFA886B4238611FCFDCDE355B3B6519035BBC34F4DEF99C0238' +
        '61B46FC9D6E6C9077AD91D2691F7F7EE598CB0FAC186D91CAEFE130985139270B4' +
        '130C93BC437944F4FD4452E2D74DD364F2E21E71F54BFF5CAE82AB9C9DF69EE86D' +
        '2BC522363A0DABC521979B0DEADA1DBF9A42D5C4484E0ABCD06BFA53DDEF3C1B20' +
        'EE3FD59D7C25E41D2B669E1EF16E6F52C3164DF4FB7930E9E4E58857B6AC7D5F42' +
        'D69F6D187763CF1D5503400487F55BA57E31CC7A7135C886EFB4318AED6A1E012D' +
        '9E6832A907600A918130C46DC778F971AD0038092999A333CB8B7A1A1DB93D7140' +
        '003C2A4ECEA9F98D0ACC0A8291CDCEC97DCF8EC9B55A7F88A46B4DB5A851F44182' +
        'E1C68A007E5E0DD9020BFD64B645036C7A4E677D2C38532A3A23BA4442CAF53EA6' +
        '3BB454329B7624C8917BDD64B1C0FD4CB38E8C334C701C3ACDAD0657FCCFEC719B' +
        '1F5C3E4E46041F388147FB4CFDB477A52471F7A9A96910B855322EDB6340D8A00E' +
        'F092350511E30ABEC1FFF9E3A26E7FB29F8C183023C3587E38DA0077D9B4763E4E' +
        '4B94B2BBC194C6651E77CAF992EEAAC0232A281BF6B3A739C1226116820AE8DB58' +
        '47A67CBEF9C9091B462D538CD72B03746AE77F5E62292C311562A846505DC82DB8' +
        '54338AE49F5235C95B91178CCF2DD5CACEF403EC9D1810C6272B045B3B71F9DC6B' +
        '80D63FDD4A8E9ADB1E6962A69526D43161C1A41D570D7938DAD4A40E329CD0E40E' +
        '65FFFFFFFFFFFFFFFF';
    8192: // 8192 bit
      s := 'FFFFFFFFFFFFFFFFADF85458A2BB4A9AAFDC5620273D3CF1D8B9C583CE2D3695A9'
        + 'E13641146433FBCC939DCE249B3EF97D2FE363630C75D8F681B202AEC4617AD3DF' +
        '1ED5D5FD65612433F51F5F066ED0856365553DED1AF3B557135E7F57C935984F0C' +
        '70E0E68B77E2A689DAF3EFE8721DF158A136ADE73530ACCA4F483A797ABC0AB182' +
        'B324FB61D108A94BB2C8E3FBB96ADAB760D7F4681D4F42A3DE394DF4AE56EDE763' +
        '72BB190B07A7C8EE0A6D709E02FCE1CDF7E2ECC03404CD28342F619172FE9CE985' +
        '83FF8E4F1232EEF28183C3FE3B1B4C6FAD733BB5FCBC2EC22005C58EF1837D1683' +
        'B2C6F34A26C1B2EFFA886B4238611FCFDCDE355B3B6519035BBC34F4DEF99C0238' +
        '61B46FC9D6E6C9077AD91D2691F7F7EE598CB0FAC186D91CAEFE130985139270B4' +
        '130C93BC437944F4FD4452E2D74DD364F2E21E71F54BFF5CAE82AB9C9DF69EE86D' +
        '2BC522363A0DABC521979B0DEADA1DBF9A42D5C4484E0ABCD06BFA53DDEF3C1B20' +
        'EE3FD59D7C25E41D2B669E1EF16E6F52C3164DF4FB7930E9E4E58857B6AC7D5F42' +
        'D69F6D187763CF1D5503400487F55BA57E31CC7A7135C886EFB4318AED6A1E012D' +
        '9E6832A907600A918130C46DC778F971AD0038092999A333CB8B7A1A1DB93D7140' +
        '003C2A4ECEA9F98D0ACC0A8291CDCEC97DCF8EC9B55A7F88A46B4DB5A851F44182' +
        'E1C68A007E5E0DD9020BFD64B645036C7A4E677D2C38532A3A23BA4442CAF53EA6' +
        '3BB454329B7624C8917BDD64B1C0FD4CB38E8C334C701C3ACDAD0657FCCFEC719B' +
        '1F5C3E4E46041F388147FB4CFDB477A52471F7A9A96910B855322EDB6340D8A00E' +
        'F092350511E30ABEC1FFF9E3A26E7FB29F8C183023C3587E38DA0077D9B4763E4E' +
        '4B94B2BBC194C6651E77CAF992EEAAC0232A281BF6B3A739C1226116820AE8DB58' +
        '47A67CBEF9C9091B462D538CD72B03746AE77F5E62292C311562A846505DC82DB8' +
        '54338AE49F5235C95B91178CCF2DD5CACEF403EC9D1810C6272B045B3B71F9DC6B' +
        '80D63FDD4A8E9ADB1E6962A69526D43161C1A41D570D7938DAD4A40E329CCFF46A' +
        'AA36AD004CF600C8381E425A31D951AE64FDB23FCEC9509D43687FEB69EDD1CC5E' +
        '0B8CC3BDF64B10EF86B63142A3AB8829555B2F747C932665CB2C0F1CC01BD70229' +
        '388839D2AF05E454504AC78B7582822846C0BA35C35F5C59160CC046FD8251541F' +
        'C68C9C86B022BB7099876A460E7451A8A93109703FEE1C217E6C3826E52C51AA69' +
        '1E0E423CFC99E9E31650C1217B624816CDAD9A95F9D5B8019488D9C0A0A1FE3075' +
        'A577E23183F81D4A3F2FA4571EFC8CE0BA8A4FE8B6855DFE72B0A66EDED2FBABFB' +
        'E58A30FAFABE1C5D71A87E2F741EF8C1FE86FEA6BBFDE530677F0D97D11D49F7A8' +
        '443D0822E506A9F4614E011E2A94838FF88CD68C8BB7C5C6424CFFFFFFFFFFFFFF' +
        'FF';
  end;
  if s <> '' then
    SetParams(s, '2');
end;

procedure TDiffieHellman.SetSecret(HexSecret: string);
var
  s: string;
begin
  Base2stringToFGInt(HexToBitStr(HexSecret), FSecretKey);
  FGIntModExp(FGenerator, FSecretKey, FPrime, FPublicKey);
  FHexSecretKey := HexSecret;
  FGIntToBase2string(FPublicKey, s);
  FHexPublicKey := BitStrToHex(s);
end;

{ TPRNGenerator }

constructor TPRNGenerator.Create;
begin
  Init(DateTimeToMilliseconds(GetTime));
end;

procedure TPRNGenerator.Fill(Buffer: Pointer; Count: Integer);
var
  i, k: Integer;
begin
  i := 0;
  k := Count div 4;
  while i < k do
  begin
    TLongWordBuffer(Buffer)[i] := NextLongWord;
    Inc(i);
  end;
  i := i * 4;
  while i < Count do
  begin
    TByteBuffer(Buffer)[i] := NextByte;
    Inc(i);
  end;
end;

procedure TPRNGenerator.Init(Seed: Int64);
var
  m: LongWord;
begin
  m := Modulo(Seed, m1 + 1);
  x1[0] := m;
  x2[0] := m;
  x1[1] := 0;
  x2[1] := 0;
  x1[2] := 0;
  x2[2] := 0;
end;

function TPRNGenerator.Modulo(x: Int64; Y: LongWord): LongWord;
var
  m: Int64;
begin
  m := x mod Y;
  if (m < 0) then
  begin
    if (Y < 0) then
      Result := m - Y
    else
      Result := m + Y;
  end
  else
    Result := m;
end;

function TPRNGenerator.Next: LongWord;
var
  x1i, x2i, z: Int64;
begin
  x1i := Modulo(a1[0] * x1[0] + a1[1] * x1[1] + a1[2] * x1[2], m1);
  x2i := Modulo(a2[0] * x2[0] + a2[1] * x2[1] + a2[2] * x2[2], m2);
  z := Modulo(x1i - x2i, m1);
  x1[2] := x1[1];
  x2[2] := x2[1];
  x1[1] := x1[0];
  x2[1] := x2[0];
  x1[0] := x1i;
  x2[0] := x2i;
  Result := z;
end;

function TPRNGenerator.NextLongWord: LongWord;
var
  LW: LongWord;
begin
  LW := 0;
  LW := NextWord;
  LW := (LW shl 16) xor NextWord;
  Result := LW;
end;

function TPRNGenerator.NextWord: Word;
begin
  Result := (Next and $00FFFF00) shr 8;
end;

function TPRNGenerator.Next(Range: Int64): Int64;
begin
  Result := Trunc(NextFloat * Range);
end;

function TPRNGenerator.NextByte: Byte;
begin
  Result := (Next and $0000FF00) shr 8;
end;

function TPRNGenerator.NextFloat: Extended;
var
  F: Int64;
begin
  TWordBuffer(@F)[3] := NextWord and $7FFF;
  TWordBuffer(@F)[2] := NextWord;
  TWordBuffer(@F)[1] := NextWord;
  TWordBuffer(@F)[0] := NextWord;
  Result := F / High(Int64);
end;

initialization

var
  s: string;

var
  i: Integer;

var
  ByteIndex, BitIndex: Byte;

var
  i64: Int64;

begin
  s := '';
  for i := 1 to 1024 - 1 do
    s := s + '0';
  s[1] := '1';
  s[1024 - 1] := '1';
  Base2stringToFGInt(s, m);
  Base10stringToFGInt('1', one);

  for ByteIndex := 0 to 255 do
  begin
    ByteToInt64[ByteIndex] := 0;
    for BitIndex := 0 to 7 do
    begin
      i64 := (ByteIndex shr BitIndex) and $00000001;
      ByteToInt64[ByteIndex] := ByteToInt64[ByteIndex]
        xor (i64 shl (BitIndex * 8));
    end;
  end;
end;

end.
