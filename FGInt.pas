{ License, info, etc
  ------------------
  This implementation is made by me, Walied Othman, to contact me
  mail to rainwolf@submanifold.be or triade@submanifold.be ,
  always mention wether it 's about the FGInt or about the 6xs,
  preferably in the subject line.
  This source code is free, but only to other free software,
  it's a two-way street, if you use this code in an application from which
  you won't make any money of (e.g. software for the good of mankind)
  then go right ahead, I won't stop you, I do demand acknowledgement for
  my work.  However, if you're using this code in a commercial application,
  an application from which you'll make money, then yes, I charge a
  license-fee, as described in the license agreement for commercial use, see
  the textfile in this zip-file.
  if you 're going to use these implementations, let me know, so I ca, put a link
  on my page if desired, I 'm always curious as to see where the spawn of my
  mind ends up in.  if any algorithm is patented in your country, you should
  acquire a license before using this software.  Modified versions of this
  software must contain an acknowledgement of the original author (=me).

  This implementation is available at
  http://www.submanifold.be

  copyright 2000, Walied Othman
  This header may not be removed. }

unit FGInt;

{$H+}

interface

uses

  System.SysUtils, Math;

type

  TCompare = (Lt, St, Eq, Er);
  TSign = (Negative, Positive);

  TFGInt = record
    Sign: TSign;
    Number: array of LongWord;
  end;

procedure ZeroneToChar8(var g: Char; const x: string);
procedure ZeroneToChar6(var g: Integer; const x: string);
procedure Initialize8(var Trans: array of string);
procedure Initialize6(var Trans: array of string);
procedure Initialize6PGP(var Trans: array of string);
procedure ConvertBase256to64(const Str256: string; var Str64: string);
procedure ConvertBase64to256(const Str64: string; var Str256: string);
procedure ConvertBase256to2(const Str256: string; var Str2: string);
procedure ConvertBase64to2(const Str64: string; var Str2: string);
procedure ConvertBase2to256(Str2: string; var Str256: string);
procedure ConvertBase2to64(Str2: string; var Str64: string);
procedure ConvertBase256stringToHexstring(Str256: string; var HexStr: string);
procedure ConvertHexstringToBase256string(HexStr: string; var Str256: string);
procedure PGPConvertBase256to64(var Str256, Str64: string);
procedure PGPConvertBase64to256(Str64: string; var Str256: string);
procedure PGPConvertBase64to2(Str64: string; var Str2: string);
procedure FGIntToBase2string(const FGInt: TFGInt; var S: string);
procedure Base2stringToFGInt(S: string; var FGInt: TFGInt);
procedure FGIntToBase256string(const FGInt: TFGInt; var Str256: string);
procedure Base256stringToFGInt(Str256: string; var FGInt: TFGInt);
procedure PGPMPIToFGInt(PGPMPI: string; var FGInt: TFGInt);
procedure FGIntToPGPMPI(FGInt: TFGInt; var PGPMPI: string);
procedure Base10stringToFGInt(Base10: string; var FGInt: TFGInt);
procedure FGIntToBase10string(const FGInt: TFGInt; var Base10: string);
procedure FGIntDestroy(var FGInt: TFGInt);
Function FGIntCompareAbs(const FGInt1, FGInt2: TFGInt): TCompare;
procedure FGIntAdd(const FGInt1, FGInt2: TFGInt; var Sum: TFGInt);
procedure FGIntChangeSign(var FGInt: TFGInt);
procedure FGIntSub(var FGInt1, FGInt2, dif: TFGInt);
procedure FGIntMulByInt(const FGInt: TFGInt; var Res: TFGInt; by: LongWord);
procedure FGIntMulByIntbis(var FGInt: TFGInt; by: LongWord);
procedure FGIntDivByInt(const FGInt: TFGInt; var Res: TFGInt; by: LongWord;
  var ModRes: LongWord);
procedure FGIntDivByIntBis(var FGInt: TFGInt; by: LongWord;
  var ModRes: LongWord);
procedure FGIntModByInt(const FGInt: TFGInt; by: LongWord;
  var ModRes: LongWord);
procedure FGIntAbs(var FGInt: TFGInt);
procedure FGIntCopy(const FGInt1: TFGInt; var FGInt2: TFGInt);
procedure FGIntShiftLeft(var FGInt: TFGInt);
procedure FGIntShiftRight(var FGInt: TFGInt);
procedure FGIntShiftRightBy31(var FGInt: TFGInt);
procedure FGIntShiftLeftBy31Times(var FGInt: TFGInt; times: LongWord);
procedure FGIntAddBis(var FGInt1: TFGInt; const FGInt2: TFGInt);
procedure FGIntSubBis(var FGInt1: TFGInt; const FGInt2: TFGInt);
procedure FGIntMul(const FGInt1, FGInt2: TFGInt; var Prod: TFGInt);
procedure FGIntSquare(const FGInt: TFGInt; var Square: TFGInt);
procedure FGIntExp(const FGInt, exp: TFGInt; var Res: TFGInt);
procedure FGIntFac(const FGInt: TFGInt; var Res: TFGInt);
procedure FGIntShiftLeftBy31(var FGInt: TFGInt);
procedure FGIntDivMod(var FGInt1, FGInt2, QFGInt, MFGInt: TFGInt);
procedure FGIntDiv(var FGInt1, FGInt2, QFGInt: TFGInt);
procedure FGIntMulByIntSubBis(var FGInt1: TFGInt; const FGInt2: TFGInt;
  divInt: LongWord);
procedure FGIntMod(var FGInt1, FGInt2, MFGInt: TFGInt);
procedure FGIntSquareMod(var FGInt, Modb, FGIntSM: TFGInt);
procedure FGIntAddMod(var FGInt1, FGInt2, base, FGIntRes: TFGInt);
procedure FGIntMulMod(var FGInt1, FGInt2, base, FGIntRes: TFGInt);
procedure FGIntModExp(var FGInt, exp, Modb, Res: TFGInt);
procedure FGIntModBis(const FGInt: TFGInt; var FGIntOut: TFGInt;
  b, head: LongWord);
procedure FGIntMulModBis(const FGInt1, FGInt2: TFGInt; var Prod: TFGInt;
  b, head: LongWord);
procedure FGIntMontgomeryMod(const GInt, base, baseInv: TFGInt;
  var MGInt: TFGInt; b: LongWord; head: LongWord);
procedure FGIntMontgomeryModExp(var FGInt, exp, Modb, Res: TFGInt);
procedure FGIntGCD(const FGInt1, FGInt2: TFGInt; var GCD: TFGInt);
procedure FGIntLCM(const FGInt1, FGInt2: TFGInt; var LCM: TFGInt);
procedure FGIntTrialDiv9999(const FGInt: TFGInt; var Ok: Boolean);
procedure FGIntRandom1(var Seed, RandomFGInt: TFGInt);
procedure FGIntRabinMiller(var FGIntp: TFGInt; nrtest: LongWord;
  var Ok: Boolean);
procedure FGIntBezoutBachet(var FGInt1, FGInt2, a, b: TFGInt);
procedure FGIntModInv(const FGInt1, base: TFGInt; var Inverse: TFGInt);
procedure FGIntPrimetest(var FGIntp: TFGInt; nrRMtests: Integer;
  var Ok: Boolean);
procedure FGIntLegendreSymbol(var a, p: TFGInt; var L: Integer);
procedure FGIntSquareRootModP(Square, Prime: TFGInt; var SquareRoot: TFGInt);
procedure PrimeSearch(var GInt: TFGInt);

const
  Primes: array [1 .. 1228] of Integer = (3, 5, 7, 11, 13, 17, 19, 23, 29, 31,
    37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109,
    113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193,
    197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277,
    281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373,
    379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461,
    463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569,
    571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653,
    659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757,
    761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859,
    863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971,
    977, 983, 991, 997, 1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051,
    1061, 1063, 1069, 1087, 1091, 1093, 1097, 1103, 1109, 1117, 1123, 1129,
    1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229,
    1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301, 1303,
    1307, 1319, 1321, 1327, 1361, 1367, 1373, 1381, 1399, 1409, 1423, 1427,
    1429, 1433, 1439, 1447, 1451, 1453, 1459, 1471, 1481, 1483, 1487, 1489,
    1493, 1499, 1511, 1523, 1531, 1543, 1549, 1553, 1559, 1567, 1571, 1579,
    1583, 1597, 1601, 1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657, 1663,
    1667, 1669, 1693, 1697, 1699, 1709, 1721, 1723, 1733, 1741, 1747, 1753,
    1759, 1777, 1783, 1787, 1789, 1801, 1811, 1823, 1831, 1847, 1861, 1867,
    1871, 1873, 1877, 1879, 1889, 1901, 1907, 1913, 1931, 1933, 1949, 1951,
    1973, 1979, 1987, 1993, 1997, 1999, 2003, 2011, 2017, 2027, 2029, 2039,
    2053, 2063, 2069, 2081, 2083, 2087, 2089, 2099, 2111, 2113, 2129, 2131,
    2137, 2141, 2143, 2153, 2161, 2179, 2203, 2207, 2213, 2221, 2237, 2239,
    2243, 2251, 2267, 2269, 2273, 2281, 2287, 2293, 2297, 2309, 2311, 2333,
    2339, 2341, 2347, 2351, 2357, 2371, 2377, 2381, 2383, 2389, 2393, 2399,
    2411, 2417, 2423, 2437, 2441, 2447, 2459, 2467, 2473, 2477, 2503, 2521,
    2531, 2539, 2543, 2549, 2551, 2557, 2579, 2591, 2593, 2609, 2617, 2621,
    2633, 2647, 2657, 2659, 2663, 2671, 2677, 2683, 2687, 2689, 2693, 2699,
    2707, 2711, 2713, 2719, 2729, 2731, 2741, 2749, 2753, 2767, 2777, 2789,
    2791, 2797, 2801, 2803, 2819, 2833, 2837, 2843, 2851, 2857, 2861, 2879,
    2887, 2897, 2903, 2909, 2917, 2927, 2939, 2953, 2957, 2963, 2969, 2971,
    2999, 3001, 3011, 3019, 3023, 3037, 3041, 3049, 3061, 3067, 3079, 3083,
    3089, 3109, 3119, 3121, 3137, 3163, 3167, 3169, 3181, 3187, 3191, 3203,
    3209, 3217, 3221, 3229, 3251, 3253, 3257, 3259, 3271, 3299, 3301, 3307,
    3313, 3319, 3323, 3329, 3331, 3343, 3347, 3359, 3361, 3371, 3373, 3389,
    3391, 3407, 3413, 3433, 3449, 3457, 3461, 3463, 3467, 3469, 3491, 3499,
    3511, 3517, 3527, 3529, 3533, 3539, 3541, 3547, 3557, 3559, 3571, 3581,
    3583, 3593, 3607, 3613, 3617, 3623, 3631, 3637, 3643, 3659, 3671, 3673,
    3677, 3691, 3697, 3701, 3709, 3719, 3727, 3733, 3739, 3761, 3767, 3769,
    3779, 3793, 3797, 3803, 3821, 3823, 3833, 3847, 3851, 3853, 3863, 3877,
    3881, 3889, 3907, 3911, 3917, 3919, 3923, 3929, 3931, 3943, 3947, 3967,
    3989, 4001, 4003, 4007, 4013, 4019, 4021, 4027, 4049, 4051, 4057, 4073,
    4079, 4091, 4093, 4099, 4111, 4127, 4129, 4133, 4139, 4153, 4157, 4159,
    4177, 4201, 4211, 4217, 4219, 4229, 4231, 4241, 4243, 4253, 4259, 4261,
    4271, 4273, 4283, 4289, 4297, 4327, 4337, 4339, 4349, 4357, 4363, 4373,
    4391, 4397, 4409, 4421, 4423, 4441, 4447, 4451, 4457, 4463, 4481, 4483,
    4493, 4507, 4513, 4517, 4519, 4523, 4547, 4549, 4561, 4567, 4583, 4591,
    4597, 4603, 4621, 4637, 4639, 4643, 4649, 4651, 4657, 4663, 4673, 4679,
    4691, 4703, 4721, 4723, 4729, 4733, 4751, 4759, 4783, 4787, 4789, 4793,
    4799, 4801, 4813, 4817, 4831, 4861, 4871, 4877, 4889, 4903, 4909, 4919,
    4931, 4933, 4937, 4943, 4951, 4957, 4967, 4969, 4973, 4987, 4993, 4999,
    5003, 5009, 5011, 5021, 5023, 5039, 5051, 5059, 5077, 5081, 5087, 5099,
    5101, 5107, 5113, 5119, 5147, 5153, 5167, 5171, 5179, 5189, 5197, 5209,
    5227, 5231, 5233, 5237, 5261, 5273, 5279, 5281, 5297, 5303, 5309, 5323,
    5333, 5347, 5351, 5381, 5387, 5393, 5399, 5407, 5413, 5417, 5419, 5431,
    5437, 5441, 5443, 5449, 5471, 5477, 5479, 5483, 5501, 5503, 5507, 5519,
    5521, 5527, 5531, 5557, 5563, 5569, 5573, 5581, 5591, 5623, 5639, 5641,
    5647, 5651, 5653, 5657, 5659, 5669, 5683, 5689, 5693, 5701, 5711, 5717,
    5737, 5741, 5743, 5749, 5779, 5783, 5791, 5801, 5807, 5813, 5821, 5827,
    5839, 5843, 5849, 5851, 5857, 5861, 5867, 5869, 5879, 5881, 5897, 5903,
    5923, 5927, 5939, 5953, 5981, 5987, 6007, 6011, 6029, 6037, 6043, 6047,
    6053, 6067, 6073, 6079, 6089, 6091, 6101, 6113, 6121, 6131, 6133, 6143,
    6151, 6163, 6173, 6197, 6199, 6203, 6211, 6217, 6221, 6229, 6247, 6257,
    6263, 6269, 6271, 6277, 6287, 6299, 6301, 6311, 6317, 6323, 6329, 6337,
    6343, 6353, 6359, 6361, 6367, 6373, 6379, 6389, 6397, 6421, 6427, 6449,
    6451, 6469, 6473, 6481, 6491, 6521, 6529, 6547, 6551, 6553, 6563, 6569,
    6571, 6577, 6581, 6599, 6607, 6619, 6637, 6653, 6659, 6661, 6673, 6679,
    6689, 6691, 6701, 6703, 6709, 6719, 6733, 6737, 6761, 6763, 6779, 6781,
    6791, 6793, 6803, 6823, 6827, 6829, 6833, 6841, 6857, 6863, 6869, 6871,
    6883, 6899, 6907, 6911, 6917, 6947, 6949, 6959, 6961, 6967, 6971, 6977,
    6983, 6991, 6997, 7001, 7013, 7019, 7027, 7039, 7043, 7057, 7069, 7079,
    7103, 7109, 7121, 7127, 7129, 7151, 7159, 7177, 7187, 7193, 7207, 7211,
    7213, 7219, 7229, 7237, 7243, 7247, 7253, 7283, 7297, 7307, 7309, 7321,
    7331, 7333, 7349, 7351, 7369, 7393, 7411, 7417, 7433, 7451, 7457, 7459,
    7477, 7481, 7487, 7489, 7499, 7507, 7517, 7523, 7529, 7537, 7541, 7547,
    7549, 7559, 7561, 7573, 7577, 7583, 7589, 7591, 7603, 7607, 7621, 7639,
    7643, 7649, 7669, 7673, 7681, 7687, 7691, 7699, 7703, 7717, 7723, 7727,
    7741, 7753, 7757, 7759, 7789, 7793, 7817, 7823, 7829, 7841, 7853, 7867,
    7873, 7877, 7879, 7883, 7901, 7907, 7919, 7927, 7933, 7937, 7949, 7951,
    7963, 7993, 8009, 8011, 8017, 8039, 8053, 8059, 8069, 8081, 8087, 8089,
    8093, 8101, 8111, 8117, 8123, 8147, 8161, 8167, 8171, 8179, 8191, 8209,
    8219, 8221, 8231, 8233, 8237, 8243, 8263, 8269, 8273, 8287, 8291, 8293,
    8297, 8311, 8317, 8329, 8353, 8363, 8369, 8377, 8387, 8389, 8419, 8423,
    8429, 8431, 8443, 8447, 8461, 8467, 8501, 8513, 8521, 8527, 8537, 8539,
    8543, 8563, 8573, 8581, 8597, 8599, 8609, 8623, 8627, 8629, 8641, 8647,
    8663, 8669, 8677, 8681, 8689, 8693, 8699, 8707, 8713, 8719, 8731, 8737,
    8741, 8747, 8753, 8761, 8779, 8783, 8803, 8807, 8819, 8821, 8831, 8837,
    8839, 8849, 8861, 8863, 8867, 8887, 8893, 8923, 8929, 8933, 8941, 8951,
    8963, 8969, 8971, 8999, 9001, 9007, 9011, 9013, 9029, 9041, 9043, 9049,
    9059, 9067, 9091, 9103, 9109, 9127, 9133, 9137, 9151, 9157, 9161, 9173,
    9181, 9187, 9199, 9203, 9209, 9221, 9227, 9239, 9241, 9257, 9277, 9281,
    9283, 9293, 9311, 9319, 9323, 9337, 9341, 9343, 9349, 9371, 9377, 9391,
    9397, 9403, 9413, 9419, 9421, 9431, 9433, 9437, 9439, 9461, 9463, 9467,
    9473, 9479, 9491, 9497, 9511, 9521, 9533, 9539, 9547, 9551, 9587, 9601,
    9613, 9619, 9623, 9629, 9631, 9643, 9649, 9661, 9677, 9679, 9689, 9697,
    9719, 9721, 9733, 9739, 9743, 9749, 9767, 9769, 9781, 9787, 9791, 9803,
    9811, 9817, 9829, 9833, 9839, 9851, 9857, 9859, 9871, 9883, 9887, 9901,
    9907, 9923, 9929, 9931, 9941, 9949, 9967, 9973);

  Chr64: array [1 .. 64] of Char = ('a', 'A', 'b', 'B', 'c', 'C', 'd', 'D', 'e',
    'E', 'f', 'F', 'g', 'G', 'h', 'H', 'i', 'I', 'j', 'J', 'k', 'K', 'l', 'L',
    'm', 'M', 'n', 'N', 'o', 'O', 'p', 'P', 'q', 'Q', 'r', 'R', 's', 'S', 't',
    'T', 'u', 'U', 'v', 'V', 'w', 'W', 'x', 'X', 'y', 'Y', 'z', 'Z', '0', '1',
    '2', '3', '4', '5', '6', '7', '8', '9', '+', '=');

  PGPchr64: array [1 .. 64] of Char = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
    'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
    'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/');

implementation

procedure PrimeSearch(var GInt: TFGInt);
var
  two: TFGInt;
  Ok: Boolean;
begin
  if (GInt.Number[1] Mod 2) = 0 then
    GInt.Number[1] := GInt.Number[1] + 1;
  Base10stringToFGInt('2', two);
  Ok := false;
  while not Ok do
  begin
    FGIntAddBis(GInt, two);
    FGIntPrimetest(GInt, 4, Ok);
  end;
  FGIntDestroy(two);
end;

procedure ZeroneToChar8(var g: Char; const x: string);
var
  i: Integer;
  b: Byte;
begin
  b := 0;
  for i := 1 to 8 do
  begin
    if Copy(x, i, 1) = '1' then
      b := b or (1 shl (8 - i));
  end;
  g := Chr(b);
end;

procedure ZeroneToChar6(var g: Integer; const x: string);
var
  i: Integer;
begin
  g := 0;
  for i := 1 to Length(x) do
  begin
    if i > 6 then
      Break;
    if x[i] <> '0' then
      g := g Or (1 Shl (6 - i));
  end;
  Inc(g);
end;

procedure Initialize8(var Trans: array of string);
var
  c1, c2, c3, c4, c5, c6, c7, c8: Integer;
  x: string;
  g: Char;
begin
  for c1 := 0 to 1 do
    for c2 := 0 to 1 do
      for c3 := 0 to 1 do
        for c4 := 0 to 1 do
          for c5 := 0 to 1 do
            for c6 := 0 to 1 do
              for c7 := 0 to 1 do
                for c8 := 0 to 1 do
                begin
                  x := Chr(48 + c1) + Chr(48 + c2) + Chr(48 + c3) + Chr(48 + c4)
                    + Chr(48 + c5) + Chr(48 + c6) + Chr(48 + c7) + Chr(48 + c8);
                  ZeroneToChar8(g, x);
                  Trans[Ord(g)] := x;
                end;
end;

procedure Initialize6(var Trans: array of string);
var
  c1, c2, c3, c4, c5, c6: Integer;
  x: string;
  g: Integer;
begin
  for c1 := 0 to 1 do
    for c2 := 0 to 1 do
      for c3 := 0 to 1 do
        for c4 := 0 to 1 do
          for c5 := 0 to 1 do
            for c6 := 0 to 1 do
            begin
              x := Chr(48 + c1) + Chr(48 + c2) + Chr(48 + c3) + Chr(48 + c4) +
                Chr(48 + c5) + Chr(48 + c6);
              ZeroneToChar6(g, x);
              Trans[Ord(Chr64[g])] := x;
            end;
end;

procedure Initialize6PGP(var Trans: array of string);
var
  c1, c2, c3, c4, c5, c6: Integer;
  x: string;
  g: Integer;
begin
  for c1 := 0 to 1 do
    for c2 := 0 to 1 do
      for c3 := 0 to 1 do
        for c4 := 0 to 1 do
          for c5 := 0 to 1 do
            for c6 := 0 to 1 do
            begin
              x := Chr(48 + c1) + Chr(48 + c2) + Chr(48 + c3) + Chr(48 + c4) +
                Chr(48 + c5) + Chr(48 + c6);
              ZeroneToChar6(g, x);
              Trans[Ord(PGPchr64[g])] := x;
            end;
end;

// Convert base 8 strings to base 6 strings and visa versa

procedure ConvertBase256to64(const Str256: string; var Str64: string);
var
  temp: string;
  Trans: array [0 .. 255] of string;
  i, len6: LongInt;
  g: Integer;
begin
  Initialize8(Trans);
  temp := '';
  for i := 1 to Length(Str256) do
    temp := temp + Trans[Ord(Str256[i])];
  while (Length(temp) Mod 6) <> 0 do
    temp := temp + '0';
  len6 := Length(temp) div 6;
  Str64 := '';
  for i := 1 to len6 do
  begin
    ZeroneToChar6(g, Copy(temp, 1, 6));
    Str64 := Str64 + Chr64[g];
    delete(temp, 1, 6);
  end;
end;

procedure ConvertBase64to256(const Str64: string; var Str256: string);
var
  temp: string;
  Trans: array [0 .. 255] of string;
  i, len8: LongInt;
  g: Char;
begin
  Initialize6(Trans);
  temp := '';
  for i := 1 to Length(Str64) do
    temp := temp + Trans[Ord(Str64[i])];
  Str256 := '';
  len8 := Length(temp) div 8;
  for i := 1 to len8 do
  begin
    ZeroneToChar8(g, Copy(temp, 1, 8));
    Str256 := Str256 + g;
    delete(temp, 1, 8);
  end;
end;

// Convert base 8 & 6 bit strings to base 2 strings and visa versa

procedure ConvertBase256to2(const Str256: string; var Str2: string);
var
  Trans: array [0 .. 255] of string;
  i: LongInt;
begin
  Str2 := '';
  Initialize8(Trans);
  for i := 1 to Length(Str256) do
    Str2 := Str2 + Trans[Ord(Str256[i])];
end;

procedure ConvertBase64to2(const Str64: string; var Str2: string);
var
  Trans: array [0 .. 255] of string;
  i: LongInt;
begin
  Str2 := '';
  Initialize6(Trans);
  for i := 1 to Length(Str64) do
    Str2 := Str2 + Trans[Ord(Str64[i])];
end;

procedure ConvertBase2to256(Str2: string; var Str256: string);
var
  i, len8: LongInt;
  g: Char;
begin
  Str256 := '';
  while (Length(Str2) Mod 8) <> 0 do
    Str2 := '0' + Str2;
  len8 := Length(Str2) div 8;
  for i := 1 to len8 do
  begin
    ZeroneToChar8(g, Copy(Str2, 1, 8));
    Str256 := Str256 + g;
    delete(Str2, 1, 8);
  end;
end;

procedure ConvertBase2to64(Str2: string; var Str64: string);
var
  i, len6: LongInt;
  g: Integer;
begin
  Str64 := '';
  while (Length(Str2) Mod 6) <> 0 do
    Str2 := '0' + Str2;
  len6 := Length(Str2) div 6;
  for i := 1 to len6 do
  begin
    ZeroneToChar6(g, Copy(Str2, 1, 6));
    Str64 := Str64 + Chr64[g];
    delete(Str2, 1, 6);
  end;
end;

// Convert base 256 strings to base 16 (HexaDecimal) strings and visa versa

procedure ConvertBase256stringToHexstring(Str256: string; var HexStr: string);
var
  i: LongInt;
  b: Byte;
begin
  HexStr := '';
  for i := 1 to Length(Str256) do
  begin
    b := Ord(Str256[i]);
    if (b shr 4) < 10 then
      HexStr := HexStr + Chr(48 + (b shr 4))
    else
      HexStr := HexStr + Chr(55 + (b shr 4));
    if (b and 15) < 10 then
      HexStr := HexStr + Chr(48 + (b and 15))
    else
      HexStr := HexStr + Chr(55 + (b and 15));
  end;
end;

procedure ConvertHexstringToBase256string(HexStr: string; var Str256: string);
var
  i: LongInt;
  b, h1, h2: Byte;
  temp: string;
begin
  Str256 := '';
  if (Length(HexStr) mod 2) = 1 then
    temp := '0' + HexStr
  else
    temp := HexStr;
  for i := 1 to (Length(temp) div 2) do
  begin
    h2 := Ord(temp[2 * i]);
    h1 := Ord(temp[2 * i - 1]);
    if h1 < 58 then
      b := ((h1 - 48) Shl 4)
    else
      b := ((h1 - 55) Shl 4);
    if h2 < 58 then
      b := (b Or (h2 - 48))
    else
      b := (b Or ((h2 - 55) and 15));
    Str256 := Str256 + Chr(b);
  end;
end;

// Convert base 256 strings to base 64 strings and visa versa, PGP style

procedure PGPConvertBase256to64(var Str256, Str64: string);
var
  temp, x, a: string;
  i, len6: LongInt;
  g: Integer;
  Trans: array [0 .. 255] of string;
begin
  Initialize8(Trans);
  temp := '';
  for i := 1 to Length(Str256) do
    temp := temp + Trans[Ord(Str256[i])];
  if (Length(temp) Mod 6) = 0 then
    a := ''
  else if (Length(temp) Mod 6) = 4 then
  begin
    temp := temp + '00';
    a := '='
  End
  else
  begin
    temp := temp + '0000';
    a := '=='
  end;
  Str64 := '';
  len6 := Length(temp) div 6;
  for i := 1 to len6 do
  begin
    x := Copy(temp, 1, 6);
    ZeroneToChar6(g, x);
    Str64 := Str64 + PGPchr64[g];
    delete(temp, 1, 6);
  end;
  Str64 := Str64 + a;
end;

procedure PGPConvertBase64to256(Str64: string; var Str256: string);
var
  temp, x: string;
  i, j, len8: LongInt;
  g: Char;
  Trans: array [0 .. 255] of string;
begin
  Initialize6PGP(Trans);
  temp := '';
  Str256 := '';
  if Str64[Length(Str64) - 1] = '=' then
    j := 2
  else if Str64[Length(Str64)] = '=' then
    j := 1
  else
    j := 0;
  for i := 1 to (Length(Str64) - j) do
    temp := temp + Trans[Ord(Str64[i])];
  if j <> 0 then
    delete(temp, Length(temp) - 2 * j + 1, 2 * j);
  len8 := Length(temp) div 8;
  for i := 1 to len8 do
  begin
    x := Copy(temp, 1, 8);
    ZeroneToChar8(g, x);
    Str256 := Str256 + g;
    delete(temp, 1, 8);
  end;
end;

// Convert base 64 strings to base 2 strings, PGP style

procedure PGPConvertBase64to2(Str64: string; var Str2: string);
var
  i, j: LongInt;
  Trans: array [0 .. 255] of string;
begin
  Str2 := '';
  Initialize6(Trans);
  if Str64[Length(Str64) - 1] = '=' then
    j := 2
  else if Str64[Length(Str64)] = '=' then
    j := 1
  else
    j := 0;
  for i := 1 to (Length(Str64) - j) do
    Str2 := Str2 + Trans[Ord(Str64[i])];
  delete(Str2, Length(Str2) - 2 * j + 1, 2 * j);
end;

// Convert a FGInt to a binary string (base 2) & visa versa

procedure FGIntToBase2string(const FGInt: TFGInt; var S: string);
var
  i: LongWord;
  j: Integer;
begin
  S := '';
  for i := 1 to FGInt.Number[0] do
  begin
    for j := 0 to 30 do
      if (1 and (FGInt.Number[i] shr j)) = 1 then
        S := '1' + S
      else
        S := '0' + S;
  end;
  while (Length(S) > 1) and (S[1] = '0') do
    delete(S, 1, 1);
  if S = '' then
    S := '0';
end;

procedure Base2stringToFGInt(S: string; var FGInt: TFGInt);
var
  i, j, size: LongWord;
begin
  while (S[1] = '0') and (Length(S) > 1) do
    delete(S, 1, 1);
  size := Length(S) div 31;
  if (Length(S) Mod 31) <> 0 then
    size := size + 1;
  SetLength(FGInt.Number, (size + 1));
  FGInt.Number[0] := size;
  j := 1;
  FGInt.Number[j] := 0;
  i := 0;
  while Length(S) > 0 do
  begin
    if S[Length(S)] = '1' then
      FGInt.Number[j] := FGInt.Number[j] Or (1 shl i);
    i := i + 1;
    if i = 31 then
    begin
      i := 0;
      j := j + 1;
      if j <= size then
        FGInt.Number[j] := 0;
    end;
    delete(S, Length(S), 1);
  end;
  FGInt.Sign := Positive;
end;

// Convert a FGInt to an base 256 string & visa versa

procedure FGIntToBase256string(const FGInt: TFGInt; var Str256: string);
var
  temp1: string;
  i, len8: LongWord;
  g: Char;
begin
  FGIntToBase2string(FGInt, temp1);
  while (Length(temp1) Mod 8) <> 0 do
    temp1 := '0' + temp1;
  len8 := Length(temp1) div 8;
  Str256 := '';
  for i := 1 to len8 do
  begin
    ZeroneToChar8(g, Copy(temp1, 1, 8));
    Str256 := Str256 + g;
    delete(temp1, 1, 8);
  end;
end;

procedure Base256stringToFGInt(Str256: string; var FGInt: TFGInt);
var
  temp1: string;
  i: LongInt;
  Trans: array [0 .. 255] of string;
begin
  temp1 := '';
  Initialize8(Trans);
  for i := 1 to Length(Str256) do
    temp1 := temp1 + Trans[Ord(Str256[i])];
  while (temp1[1] = '0') and (temp1 <> '0') do
    delete(temp1, 1, 1);
  Base2stringToFGInt(temp1, FGInt);
end;

// Convert an MPI (Multiple Precision Integer, PGP style) to an FGInt &
// visa versa

procedure PGPMPIToFGInt(PGPMPI: string; var FGInt: TFGInt);
var
  temp: string;
begin
  temp := PGPMPI;
  delete(temp, 1, 2);
  Base256stringToFGInt(temp, FGInt);
end;

procedure FGIntToPGPMPI(FGInt: TFGInt; var PGPMPI: string);
var
  len, i: word;
  c: Char;
  b: Byte;
begin
  FGIntToBase256string(FGInt, PGPMPI);
  len := Length(PGPMPI) * 8;
  c := PGPMPI[1];
  for i := 7 downto 0 do
    if (Ord(c) shr i) = 0 then
      len := len - 1
    else
      Break;
  b := len Mod 256;
  PGPMPI := Chr(b) + PGPMPI;
  b := len div 256;
  PGPMPI := Chr(b) + PGPMPI;
end;

// Convert a base 10 string to a FGInt

procedure Base10stringToFGInt(Base10: string; var FGInt: TFGInt);
var
  i, size: LongWord;
  j: word;
  S, x: string;
  Sign: TSign;

  procedure GIntDivByIntBis1(var GInt: TFGInt; by: LongWord; var ModRes: word);
  var
    i, size, rest, temp: LongWord;
  begin
    size := GInt.Number[0];
    temp := 0;
    for i := size downto 1 do
    begin
      temp := temp * 10000;
      rest := temp + GInt.Number[i];
      GInt.Number[i] := rest div by;
      temp := rest Mod by;
    end;
    ModRes := temp;
    while (GInt.Number[size] = 0) and (size > 1) do
      size := size - 1;
    if size <> GInt.Number[0] then
    begin
      SetLength(GInt.Number, size + 1);
      GInt.Number[0] := size;
    end;
  end;

begin
  while (Not (Base10[1] In ['-', '0' .. '9'])) and (Length(Base10) > 1) do
    delete(Base10, 1, 1);
  if Copy(Base10, 1, 1) = '-' then
  begin
    Sign := Negative;
    delete(Base10, 1, 1);
  End
  else
    Sign := Positive;
  while (Length(Base10) > 1) and (Copy(Base10, 1, 1) = '0') do
    delete(Base10, 1, 1);
  size := Length(Base10) div 4;
  if (Length(Base10) Mod 4) <> 0 then
    size := size + 1;
  SetLength(FGInt.Number, size + 1);
  FGInt.Number[0] := size;
  for i := 1 to (size - 1) do
  begin
    x := Copy(Base10, Length(Base10) - 3, 4);
    FGInt.Number[i] := StrToInt(x);
    delete(Base10, Length(Base10) - 3, 4);
  end;
  FGInt.Number[size] := StrToInt(Base10);

  S := '';
  while (FGInt.Number[0] <> 1) Or (FGInt.Number[1] <> 0) do
  begin
    GIntDivByIntBis1(FGInt, 2, j);
    S := IntToStr(j) + S;
  end;
  if S = '' then
    S := '0';
  FGIntDestroy(FGInt);
  Base2stringToFGInt(S, FGInt);
  FGInt.Sign := Sign;
end;

// Convert a FGInt to a base 10 string

procedure FGIntToBase10string(const FGInt: TFGInt; var Base10: string);
var
  S: string;
  j: LongWord;
  temp: TFGInt;
begin
  FGIntCopy(FGInt, temp);
  Base10 := '';
  while (temp.Number[0] > 1) Or (temp.Number[1] > 0) do
  begin
    FGIntDivByIntBis(temp, 10000, j);
    S := IntToStr(j);
    while Length(S) < 4 do
      S := '0' + S;
    Base10 := S + Base10;
  end;
  Base10 := '0' + Base10;
  while (Length(Base10) > 1) and (Base10[1] = '0') do
    delete(Base10, 1, 1);
  if FGInt.Sign = Negative then
    Base10 := '-' + Base10;
end;


// Destroy a FGInt to free memory

procedure FGIntDestroy(var FGInt: TFGInt);
begin
  FGInt.Number := Nil;
end;

// Compare 2 FGInts in absolute value, returns
// Lt if FGInt1 > FGInt2, St if FGInt1 < FGInt2, Eq if FGInt1 = FGInt2,
// Er otherwise

Function FGIntCompareAbs(const FGInt1, FGInt2: TFGInt): TCompare;
var
  size1, size2, i: LongWord;
begin
  FGIntCompareAbs := Er;
  size1 := FGInt1.Number[0];
  size2 := FGInt2.Number[0];
  if size1 > size2 then
    FGIntCompareAbs := Lt
  else if size1 < size2 then
    FGIntCompareAbs := St
  else
  begin
    i := size2;
    while (FGInt1.Number[i] = FGInt2.Number[i]) and (i > 1) do
      i := i - 1;
    if FGInt1.Number[i] = FGInt2.Number[i] then
      FGIntCompareAbs := Eq
    else if FGInt1.Number[i] < FGInt2.Number[i] then
      FGIntCompareAbs := St
    else if FGInt1.Number[i] > FGInt2.Number[i] then
      FGIntCompareAbs := Lt;
  end;
end;

// Add 2 FGInts, FGInt1 + FGInt2 = Sum

procedure FGIntAdd(const FGInt1, FGInt2: TFGInt; var Sum: TFGInt);
var
  i, size1, size2, size, rest, Trest: LongWord;
begin
  size1 := FGInt1.Number[0];
  size2 := FGInt2.Number[0];
  if size1 < size2 then
    FGIntAdd(FGInt2, FGInt1, Sum)
  else
  begin
    if FGInt1.Sign = FGInt2.Sign then
    begin
      Sum.Sign := FGInt1.Sign;
      SetLength(Sum.Number, (size1 + 2));
      rest := 0;
      for i := 1 to size2 do
      begin
        Trest := FGInt1.Number[i];
        Trest := Trest + FGInt2.Number[i];
        Trest := Trest + rest;
        Sum.Number[i] := Trest and 2147483647;
        rest := Trest shr 31;
      end;
      for i := (size2 + 1) to size1 do
      begin
        Trest := FGInt1.Number[i] + rest;
        Sum.Number[i] := Trest and 2147483647;
        rest := Trest shr 31;
      end;
      size := size1 + 1;
      Sum.Number[0] := size;
      Sum.Number[size] := rest;
      while (Sum.Number[size] = 0) and (size > 1) do
        size := size - 1;
      if Sum.Number[0] <> size then
        SetLength(Sum.Number, size + 1);
      Sum.Number[0] := size;
    End
    else
    begin
      if FGIntCompareAbs(FGInt2, FGInt1) = Lt then
        FGIntAdd(FGInt2, FGInt1, Sum)
      else
      begin
        SetLength(Sum.Number, (size1 + 1));
        rest := 0;
        for i := 1 to size2 do
        begin
          Trest := 2147483648;
          Trest := Trest + FGInt1.Number[i];
          Trest := Trest - FGInt2.Number[i];
          Trest := Trest - rest;
          Sum.Number[i] := Trest and 2147483647;
          if (Trest > 2147483647) then
            rest := 0
          else
            rest := 1;
        end;
        for i := (size2 + 1) to size1 do
        begin
          Trest := 2147483648;
          Trest := Trest + FGInt1.Number[i];
          Trest := Trest - rest;
          Sum.Number[i] := Trest and 2147483647;
          if (Trest > 2147483647) then
            rest := 0
          else
            rest := 1;
        end;
        size := size1;
        while (Sum.Number[size] = 0) and (size > 1) do
          size := size - 1;
        if size <> size1 then
          SetLength(Sum.Number, size + 1);
        Sum.Number[0] := size;
        Sum.Sign := FGInt1.Sign;
      end;
    end;
  end;
end;

procedure FGIntChangeSign(var FGInt: TFGInt);
begin
  if FGInt.Sign = Negative then
    FGInt.Sign := Positive
  else
    FGInt.Sign := Negative;
end;

// Substract 2 FGInts, FGInt1 - FGInt2 = dif

procedure FGIntSub(var FGInt1, FGInt2, dif: TFGInt);
begin
  FGIntChangeSign(FGInt2);
  FGIntAdd(FGInt1, FGInt2, dif);
  FGIntChangeSign(FGInt2);
end;

// multiply a FGInt by an Integer, FGInt * by = res, by < 2147483648

procedure FGIntMulByInt(const FGInt: TFGInt; var Res: TFGInt; by: LongWord);
var
  i, size, rest: LongWord;
  Trest: int64;
begin
  size := FGInt.Number[0];
  SetLength(Res.Number, (size + 2));
  rest := 0;
  for i := 1 to size do
  begin
    Trest := FGInt.Number[i];
    Trest := Trest * by;
    Trest := Trest + rest;
    Res.Number[i] := Trest and 2147483647;
    rest := Trest shr 31;
  end;
  if rest <> 0 then
  begin
    size := size + 1;
    Res.Number[size] := rest;
  End
  else
    SetLength(Res.Number, size + 1);
  Res.Number[0] := size;
  Res.Sign := FGInt.Sign;
end;

// multiply a FGInt by an Integer, FGInt * by = res, by < 1000000000

procedure FGIntMulByIntbis(var FGInt: TFGInt; by: LongWord);
var
  i, size, rest: LongWord;
  Trest: int64;
begin
  size := FGInt.Number[0];
  SetLength(FGInt.Number, size + 2);
  rest := 0;
  for i := 1 to size do
  begin
    Trest := FGInt.Number[i];
    Trest := Trest * by;
    Trest := Trest + rest;
    FGInt.Number[i] := Trest and 2147483647;
    rest := Trest shr 31;
  end;
  if rest <> 0 then
  begin
    size := size + 1;
    FGInt.Number[size] := rest;
  End
  else
    SetLength(FGInt.Number, size + 1);
  FGInt.Number[0] := size;
end;

// divide a FGInt by an Integer, FGInt = res * by + modres

procedure FGIntDivByInt(const FGInt: TFGInt; var Res: TFGInt; by: LongWord;
  var ModRes: LongWord);
var
  i, size: LongWord;
  rest: int64;
begin
  size := FGInt.Number[0];
  SetLength(Res.Number, (size + 1));
  ModRes := 0;
  for i := size downto 1 do
  begin
    rest := ModRes;
    rest := rest Shl 31;
    rest := rest Or FGInt.Number[i];
    Res.Number[i] := rest div by;
    ModRes := rest Mod by;
  end;
  while (Res.Number[size] = 0) and (size > 1) do
    size := size - 1;
  if size <> FGInt.Number[0] then
    SetLength(Res.Number, size + 1);
  Res.Number[0] := size;
  Res.Sign := FGInt.Sign;
  if FGInt.Sign = Negative then
    ModRes := by - ModRes;
end;

// divide a FGInt by an Integer, FGInt = FGInt * by + modres

procedure FGIntDivByIntBis(var FGInt: TFGInt; by: LongWord;
  var ModRes: LongWord);
var
  i, size: LongWord;
  temp, rest: int64;
begin
  size := FGInt.Number[0];
  temp := 0;
  for i := size downto 1 do
  begin
    temp := temp Shl 31;
    rest := temp Or FGInt.Number[i];
    FGInt.Number[i] := rest div by;
    temp := rest Mod by;
  end;
  ModRes := temp;
  while (FGInt.Number[size] = 0) and (size > 1) do
    size := size - 1;
  if size <> FGInt.Number[0] then
  begin
    SetLength(FGInt.Number, size + 1);
    FGInt.Number[0] := size;
  end;
end;

// Reduce a FGInt modulo by (=an Integer), FGInt mod by = modres

procedure FGIntModByInt(const FGInt: TFGInt; by: LongWord;
  var ModRes: LongWord);
var
  i, size: LongWord;
  temp, rest: int64;
begin
  size := FGInt.Number[0];
  temp := 0;
  for i := size downto 1 do
  begin
    temp := temp Shl 31;
    rest := temp Or FGInt.Number[i];
    temp := rest Mod by;
  end;
  ModRes := temp;
  if FGInt.Sign = Negative then
    ModRes := by - ModRes;
end;

// Returns the FGInt in absolute value

procedure FGIntAbs(var FGInt: TFGInt);
begin
  FGInt.Sign := Positive;
end;

// Copy a FGInt1 into FGInt2

procedure FGIntCopy(const FGInt1: TFGInt; var FGInt2: TFGInt);
begin
  FGInt2.Sign := FGInt1.Sign;
  FGInt2.Number := Nil;
  FGInt2.Number := Copy(FGInt1.Number, 0, FGInt1.Number[0] + 1);
end;

// Shift the FGInt to the left in base 2 notation, ie FGInt = FGInt * 2

procedure FGIntShiftLeft(var FGInt: TFGInt);
var
  L, m, i, size: LongWord;
begin
  size := FGInt.Number[0];
  L := 0;
  for i := 1 to size do
  begin
    m := FGInt.Number[i] shr 30;
    FGInt.Number[i] := ((FGInt.Number[i] Shl 1) Or L) and 2147483647;
    L := m;
  end;
  if L <> 0 then
  begin
    SetLength(FGInt.Number, size + 2);
    FGInt.Number[size + 1] := L;
    FGInt.Number[0] := size + 1;
  end;
end;

// Shift the FGInt to the right in base 2 notation, ie FGInt = FGInt div 2

procedure FGIntShiftRight(var FGInt: TFGInt);
var
  L, m, i, size: LongWord;
begin
  size := FGInt.Number[0];
  L := 0;
  for i := size downto 1 do
  begin
    m := FGInt.Number[i] and 1;
    FGInt.Number[i] := (FGInt.Number[i] shr 1) Or L;
    L := m Shl 30;
  end;
  if (FGInt.Number[size] = 0) and (size > 1) then
  begin
    SetLength(FGInt.Number, size);
    FGInt.Number[0] := size - 1;
  end;
end;

// FGInt = FGInt / 2147483648

procedure FGIntShiftRightBy31(var FGInt: TFGInt);
var
  size, i: LongWord;
begin
  size := FGInt.Number[0];
  if size > 1 then
  begin
    for i := 1 to size - 1 do
    begin
      FGInt.Number[i] := FGInt.Number[i + 1];
    end;
    SetLength(FGInt.Number, size);
    FGInt.Number[0] := size - 1;
  End
  else
    FGInt.Number[1] := 0;
end;

// FGInt1 = FGInt1 + FGInt2, FGInt1 > FGInt2

procedure FGIntAddBis(var FGInt1: TFGInt; const FGInt2: TFGInt);
var
  i, size1, size2, Trest, rest: LongWord;
begin
  size1 := FGInt1.Number[0];
  size2 := FGInt2.Number[0];
  rest := 0;
  for i := 1 to size2 do
  begin
    Trest := FGInt1.Number[i] + FGInt2.Number[i] + rest;
    rest := Trest shr 31;
    FGInt1.Number[i] := Trest and 2147483647;
  end;
  for i := size2 + 1 to size1 do
  begin
    Trest := FGInt1.Number[i] + rest;
    rest := Trest shr 31;
    FGInt1.Number[i] := Trest and 2147483647;
  end;
  if rest <> 0 then
  begin
    SetLength(FGInt1.Number, size1 + 2);
    FGInt1.Number[0] := size1 + 1;
    FGInt1.Number[size1 + 1] := rest;
  end;
end;

// FGInt1 = FGInt1 - FGInt2, use only when 0 < FGInt2 < FGInt1

procedure FGIntSubBis(var FGInt1: TFGInt; const FGInt2: TFGInt);
var
  i, size1, size2, rest, Trest: LongWord;
begin
  size1 := FGInt1.Number[0];
  size2 := FGInt2.Number[0];
  rest := 0;
  for i := 1 to size2 do
  begin
    Trest := (2147483648 Or FGInt1.Number[i]) - FGInt2.Number[i] - rest;
    if (Trest > 2147483647) then
      rest := 0
    else
      rest := 1;
    FGInt1.Number[i] := Trest and 2147483647;
  end;
  for i := size2 + 1 to size1 do
  begin
    Trest := (2147483648 Or FGInt1.Number[i]) - rest;
    if (Trest > 2147483647) then
      rest := 0
    else
      rest := 1;
    FGInt1.Number[i] := Trest and 2147483647;
  end;
  i := size1;
  while (FGInt1.Number[i] = 0) and (i > 1) do
    i := i - 1;
  if i <> size1 then
  begin
    SetLength(FGInt1.Number, i + 1);
    FGInt1.Number[0] := i;
  end;
end;

// Multiply 2 FGInts, FGInt1 * FGInt2 = Prod

procedure FGIntMul(const FGInt1, FGInt2: TFGInt; var Prod: TFGInt);
var
  i, j, size, size1, size2, rest: LongWord;
  Trest: int64;
begin
  size1 := FGInt1.Number[0];
  size2 := FGInt2.Number[0];
  size := size1 + size2;
  SetLength(Prod.Number, (size + 1));
  for i := 1 to size do
    Prod.Number[i] := 0;

  for i := 1 to size2 do
  begin
    rest := 0;
    for j := 1 to size1 do
    begin
      Trest := FGInt1.Number[j];
      Trest := Trest * FGInt2.Number[i];
      Trest := Trest + Prod.Number[j + i - 1];
      Trest := Trest + rest;
      Prod.Number[j + i - 1] := Trest and 2147483647;
      rest := Trest shr 31;
    end;
    Prod.Number[i + size1] := rest;
  end;

  Prod.Number[0] := size;
  while (Prod.Number[size] = 0) and (size > 1) do
    size := size - 1;
  if size <> Prod.Number[0] then
  begin
    SetLength(Prod.Number, size + 1);
    Prod.Number[0] := size;
  end;
  if FGInt1.Sign = FGInt2.Sign then
    Prod.Sign := Positive
  else
    Prod.Sign := Negative;
end;

// Square a FGInt, FGInt² = Square

procedure FGIntSquare(const FGInt: TFGInt; var Square: TFGInt);
var
  size, size1, i, j, rest: LongWord;
  Trest: int64;
begin
  size1 := FGInt.Number[0];
  size := 2 * size1;
  SetLength(Square.Number, (size + 1));
  Square.Number[0] := size;
  for i := 1 to size do
    Square.Number[i] := 0;
  for i := 1 to size1 do
  begin
    Trest := FGInt.Number[i];
    Trest := Trest * FGInt.Number[i];
    Trest := Trest + Square.Number[2 * i - 1];
    Square.Number[2 * i - 1] := Trest and 2147483647;
    rest := Trest shr 31;
    for j := i + 1 to size1 do
    begin
      Trest := FGInt.Number[i] Shl 1;
      Trest := Trest * FGInt.Number[j];
      Trest := Trest + Square.Number[i + j - 1];
      Trest := Trest + rest;
      Square.Number[i + j - 1] := Trest and 2147483647;
      rest := Trest shr 31;
    end;
    Square.Number[i + size1] := rest;
  end;
  Square.Sign := Positive;
  while (Square.Number[size] = 0) and (size > 1) do
    size := size - 1;
  if size <> (2 * size1) then
  begin
    SetLength(Square.Number, size + 1);
    Square.Number[0] := size;
  end;
end;

// Exponentiate a FGInt, FGInt^exp = res

procedure FGIntExp(const FGInt, exp: TFGInt; var Res: TFGInt);
var
  temp2, temp3: TFGInt;
  S: string;
  i: LongWord;
begin
  FGIntToBase2string(exp, S);
  if S[Length(S)] = '0' then
    Base10stringToFGInt('1', Res)
  else
    FGIntCopy(FGInt, Res);
  FGIntCopy(FGInt, temp2);
  if Length(S) > 1 then
    for i := (Length(S) - 1) downto 1 do
    begin
      FGIntSquare(temp2, temp3);
      FGIntCopy(temp3, temp2);
      if S[i] = '1' then
      begin
        FGIntMul(Res, temp2, temp3);
        FGIntCopy(temp3, Res);
      end;
    end;
end;

// Compute FGInt! = FGInt * (FGInt - 1) * (FGInt - 2) * ... * 3 * 2 * 1

procedure FGIntFac(const FGInt: TFGInt; var Res: TFGInt);
var
  one, temp, temp1: TFGInt;
begin
  FGIntCopy(FGInt, temp);
  Base10stringToFGInt('1', Res);
  Base10stringToFGInt('1', one);

  while not (FGIntCompareAbs(temp, one) = Eq) do
  begin
    FGIntMul(temp, Res, temp1);
    FGIntCopy(temp1, Res);
    FGIntSubBis(temp, one);
  end;

  FGIntDestroy(one);
  FGIntDestroy(temp);
end;

// FGInt = FGInt * 2147483648

procedure FGIntShiftLeftBy31(var FGInt: TFGInt);
var
  f1, f2: LongWord;
  i, size: LongInt;
begin
  size := FGInt.Number[0];
  SetLength(FGInt.Number, size + 2);
  f1 := 0;
  for i := 1 to (size + 1) do
  begin
    f2 := FGInt.Number[i];
    FGInt.Number[i] := f1;
    f1 := f2;
  end;
  FGInt.Number[0] := size + 1;
end;

procedure FGIntShiftLeftBy31Times(var FGInt: TFGInt; times: LongWord);
var
  i, size: LongInt;
begin
  size := FGInt.Number[0];
  SetLength(FGInt.Number, size + 1 + times);
  for i := size downto 1 do
  begin
    FGInt.Number[i + times] := FGInt.Number[i];
  end;
  for i := 1 to times do
  begin
    FGInt.Number[i] := 0;
  end;
  FGInt.Number[0] := size + times;
end;

// Divide 2 FGInts, FGInt1 = FGInt2 * QFGInt + MFGInt, MFGInt is always positive

procedure FGIntDivMod(var FGInt1, FGInt2, QFGInt, MFGInt: TFGInt);
var
  one, zero, temp1: TFGInt;
  s1, s2: TSign;
  j, S, t: LongWord;
  i, k: int64;
begin
  s1 := FGInt1.Sign;
  s2 := FGInt2.Sign;
  FGIntAbs(FGInt1);
  FGIntAbs(FGInt2);
  FGIntCopy(FGInt1, MFGInt);
  FGIntCopy(FGInt2, temp1);

  if FGIntCompareAbs(FGInt1, FGInt2) <> St then
  begin
    S := FGInt1.Number[0] - FGInt2.Number[0];
    SetLength(QFGInt.Number, (S + 2));
    QFGInt.Number[0] := S + 1;
    for t := 1 to S do
    begin
      FGIntShiftLeftBy31(temp1);
      QFGInt.Number[t] := 0;
    end;
    j := S + 1;
    QFGInt.Number[j] := 0;
    while FGIntCompareAbs(MFGInt, FGInt2) <> St do
    begin
      while FGIntCompareAbs(MFGInt, temp1) <> St do
      begin
        if MFGInt.Number[0] > temp1.Number[0] then
        begin
          i := MFGInt.Number[MFGInt.Number[0]];
          i := i Shl 31;
          i := i + MFGInt.Number[MFGInt.Number[0] - 1];
          i := i div (temp1.Number[temp1.Number[0]] + 1);
        End
        else
        // i := MFGInt.Number[MFGInt.Number[0]] div (temp1.Number[temp1.Number[0]] + 1);
        begin
          if (MFGInt.Number[0] > 1) and (FGInt2.Number[0] > 1) then
          begin
            i := MFGInt.Number[MFGInt.Number[0]];
            i := i Shl 31;
            i := i + MFGInt.Number[MFGInt.Number[0] - 1];
            k := temp1.Number[temp1.Number[0]];
            k := k shl 31;
            k := k + temp1.Number[temp1.Number[0] - 1] + 1;
            i := i div k;
          End
          else
            i := MFGInt.Number[MFGInt.Number[0]]
              div (temp1.Number[temp1.Number[0]] + 1);
        end;
        if (i <> 0) then
        begin
          FGIntMulByIntSubBis(MFGInt, temp1, i);
          QFGInt.Number[j] := QFGInt.Number[j] + i;
        End
        else
        begin
          QFGInt.Number[j] := QFGInt.Number[j] + 1;
          FGIntSubBis(MFGInt, temp1);
        end;
      end;
      if MFGInt.Number[0] <= temp1.Number[0] then
        if FGIntCompareAbs(temp1, FGInt2) <> Eq then
        begin
          FGIntShiftRightBy31(temp1);
          j := j - 1;
        end;
    end;
  End
  else
    Base10stringToFGInt('0', QFGInt);
  S := QFGInt.Number[0];
  while (S > 1) and (QFGInt.Number[S] = 0) do
    S := S - 1;
  if S < QFGInt.Number[0] then
  begin
    SetLength(QFGInt.Number, S + 1);
    QFGInt.Number[0] := S;
  end;
  QFGInt.Sign := Positive;

  FGIntDestroy(temp1);
  Base10stringToFGInt('0', zero);
  Base10stringToFGInt('1', one);
  if s1 = Negative then
  begin
    if FGIntCompareAbs(MFGInt, zero) <> Eq then
    begin
      FGIntAdd(QFGInt, one, temp1);
      FGIntDestroy(QFGInt);
      FGIntCopy(temp1, QFGInt);
      FGIntDestroy(temp1);
      FGIntSub(FGInt2, MFGInt, temp1);
      FGIntDestroy(MFGInt);
      FGIntCopy(temp1, MFGInt);
      FGIntDestroy(temp1);
    end;
    if s2 = Positive then
      QFGInt.Sign := Negative;
  End
  else
    QFGInt.Sign := s2;
  FGIntDestroy(one);
  FGIntDestroy(zero);

  FGInt1.Sign := s1;
  FGInt2.Sign := s2;
end;

// Same as above but doesn 't compute MFGInt

procedure FGIntDiv(var FGInt1, FGInt2, QFGInt: TFGInt);
var
  one, zero, temp1, MFGInt: TFGInt;
  s1, s2: TSign;
  j, S, t: LongWord;
  i, k: int64;
begin
  s1 := FGInt1.Sign;
  s2 := FGInt2.Sign;
  FGIntAbs(FGInt1);
  FGIntAbs(FGInt2);
  FGIntCopy(FGInt1, MFGInt);
  FGIntCopy(FGInt2, temp1);

  if FGIntCompareAbs(FGInt1, FGInt2) <> St then
  begin
    S := FGInt1.Number[0] - FGInt2.Number[0];
    SetLength(QFGInt.Number, (S + 2));
    QFGInt.Number[0] := S + 1;
    for t := 1 to S do
    begin
      FGIntShiftLeftBy31(temp1);
      QFGInt.Number[t] := 0;
    end;
    j := S + 1;
    QFGInt.Number[j] := 0;
    while FGIntCompareAbs(MFGInt, FGInt2) <> St do
    begin
      while FGIntCompareAbs(MFGInt, temp1) <> St do
      begin
        if MFGInt.Number[0] > temp1.Number[0] then
        begin
          i := MFGInt.Number[MFGInt.Number[0]];
          i := i Shl 31;
          i := i + MFGInt.Number[MFGInt.Number[0] - 1];
          i := i div (temp1.Number[temp1.Number[0]] + 1);
        End
        else
        // i := MFGInt.Number[MFGInt.Number[0]] div (temp1.Number[temp1.Number[0]] + 1);
        begin
          if (MFGInt.Number[0] > 1) and (FGInt2.Number[0] > 1) then
          begin
            i := MFGInt.Number[MFGInt.Number[0]];
            i := i Shl 31;
            i := i + MFGInt.Number[MFGInt.Number[0] - 1];
            k := temp1.Number[temp1.Number[0]];
            k := k shl 31;
            k := k + temp1.Number[temp1.Number[0] - 1] + 1;
            i := i div k;
          End
          else
            i := MFGInt.Number[MFGInt.Number[0]]
              div (temp1.Number[temp1.Number[0]] + 1);
        end;
        if (i <> 0) then
        begin
          FGIntMulByIntSubBis(MFGInt, temp1, i);
          QFGInt.Number[j] := QFGInt.Number[j] + i;
        End
        else
        begin
          QFGInt.Number[j] := QFGInt.Number[j] + 1;
          FGIntSubBis(MFGInt, temp1);
        end;
      end;
      if MFGInt.Number[0] <= temp1.Number[0] then
        if FGIntCompareAbs(temp1, FGInt2) <> Eq then
        begin
          FGIntShiftRightBy31(temp1);
          j := j - 1;
        end;
    end;
  End
  else
    Base10stringToFGInt('0', QFGInt);
  S := QFGInt.Number[0];
  while (S > 1) and (QFGInt.Number[S] = 0) do
    S := S - 1;
  if S < QFGInt.Number[0] then
  begin
    SetLength(QFGInt.Number, S + 1);
    QFGInt.Number[0] := S;
  end;
  QFGInt.Sign := Positive;

  FGIntDestroy(temp1);
  Base10stringToFGInt('0', zero);
  Base10stringToFGInt('1', one);
  if s1 = Negative then
  begin
    if FGIntCompareAbs(MFGInt, zero) <> Eq then
    begin
      FGIntAdd(QFGInt, one, temp1);
      FGIntDestroy(QFGInt);
      FGIntCopy(temp1, QFGInt);
      FGIntDestroy(temp1);
      FGIntSub(FGInt2, MFGInt, temp1);
      FGIntDestroy(MFGInt);
      FGIntCopy(temp1, MFGInt);
      FGIntDestroy(temp1);
    end;
    if s2 = Positive then
      QFGInt.Sign := Negative;
  End
  else
    QFGInt.Sign := s2;
  FGIntDestroy(one);
  FGIntDestroy(zero);
  FGIntDestroy(MFGInt);

  FGInt1.Sign := s1;
  FGInt2.Sign := s2;
end;

// FGInt1 = FGInt1 - divInt * FGInt2, use only when 0 < FGInt2 < FGInt1

procedure FGIntMulByIntSubBis(var FGInt1: TFGInt; const FGInt2: TFGInt;
  divInt: LongWord);
var
  i, size1, size2, rest, Trest, mRest: LongWord;
  mTmpRest: int64;
begin
  size1 := FGInt1.Number[0];
  size2 := FGInt2.Number[0];
  rest := 0;
  mRest := 0;
  for i := 1 to size2 do
  begin
    mTmpRest := FGInt2.Number[i];
    mTmpRest := mTmpRest * divInt;
    mTmpRest := mTmpRest + mRest;
    Trest := (2147483648 Or FGInt1.Number[i]) -
      (mTmpRest and 2147483647) - rest;
    if (Trest > 2147483647) then
      rest := 0
    else
      rest := 1;
    mRest := mTmpRest shr 31;
    FGInt1.Number[i] := Trest and 2147483647;
  end;
  for i := size2 + 1 to size1 do
  begin
    Trest := (2147483648 Or FGInt1.Number[i]) - mRest - rest;
    if (Trest > 2147483647) then
      rest := 0
    else
      rest := 1;
    mRest := mRest shr 31;
    FGInt1.Number[i] := Trest and 2147483647;
  end;
  i := size1;
  while (FGInt1.Number[i] = 0) and (i > 1) do
    i := i - 1;
  if i <> size1 then
  begin
    SetLength(FGInt1.Number, i + 1);
    FGInt1.Number[0] := i;
  end;
end;

procedure FGIntMod(var FGInt1, FGInt2, MFGInt: TFGInt);
var
  zero, temp1: TFGInt;
  s1, s2: TSign;
  S, t: LongWord;
  i, j: int64;
begin
  s1 := FGInt1.Sign;
  s2 := FGInt2.Sign;
  FGIntAbs(FGInt1);
  FGIntAbs(FGInt2);
  FGIntCopy(FGInt1, MFGInt);
  FGIntCopy(FGInt2, temp1);

  if FGIntCompareAbs(FGInt1, FGInt2) <> St then
  begin
    S := FGInt1.Number[0] - FGInt2.Number[0];
    // for t := 1 to s do
    FGIntShiftLeftBy31Times(temp1, S);
    while FGIntCompareAbs(MFGInt, FGInt2) <> St do
    begin
      while FGIntCompareAbs(MFGInt, temp1) <> St do
      begin
        if MFGInt.Number[0] > temp1.Number[0] then
        begin
          i := MFGInt.Number[MFGInt.Number[0]];
          i := i Shl 31;
          i := i + MFGInt.Number[MFGInt.Number[0] - 1];
          i := i div (temp1.Number[temp1.Number[0]] + 1);
        End
        else
        // i := MFGInt.Number[MFGInt.Number[0]] div (temp1.Number[temp1.Number[0]] + 1);
        begin
          if (MFGInt.Number[0] > 1) and (FGInt2.Number[0] > 1) then
          begin
            i := MFGInt.Number[MFGInt.Number[0]];
            i := i Shl 31;
            i := i + MFGInt.Number[MFGInt.Number[0] - 1];
            j := temp1.Number[temp1.Number[0]];
            j := j shl 31;
            j := j + temp1.Number[temp1.Number[0] - 1] + 1;
            i := i div j;
          End
          else
            i := MFGInt.Number[MFGInt.Number[0]]
              div (temp1.Number[temp1.Number[0]] + 1);
        end;
        if (i <> 0) then
        begin
          FGIntMulByIntSubBis(MFGInt, temp1, i);
        End
        else
          FGIntSubBis(MFGInt, temp1);
      end;
      if MFGInt.Number[0] <= temp1.Number[0] then
        if FGIntCompareAbs(temp1, FGInt2) <> Eq then
          FGIntShiftRightBy31(temp1);
    end;
  end;

  FGIntDestroy(temp1);
  Base10stringToFGInt('0', zero);
  if s1 = Negative then
  begin
    if FGIntCompareAbs(MFGInt, zero) <> Eq then
    begin
      FGIntSub(FGInt2, MFGInt, temp1);
      FGIntDestroy(MFGInt);
      FGIntCopy(temp1, MFGInt);
      FGIntDestroy(temp1);
    end;
  end;
  FGIntDestroy(zero);

  FGInt1.Sign := s1;
  FGInt2.Sign := s2;
end;

// Square a FGInt modulo Modb, FGInt^2 mod Modb = FGIntSM

procedure FGIntSquareMod(var FGInt, Modb, FGIntSM: TFGInt);
var
  temp: TFGInt;
begin
  FGIntSquare(FGInt, temp);
  FGIntMod(temp, Modb, FGIntSM);
  FGIntDestroy(temp);
end;

// Add 2 FGInts modulo base, (FGInt1 + FGInt2) mod base = FGIntres

procedure FGIntAddMod(var FGInt1, FGInt2, base, FGIntRes: TFGInt);
var
  temp: TFGInt;
begin
  FGIntAdd(FGInt1, FGInt2, temp);
  FGIntMod(temp, base, FGIntRes);
  FGIntDestroy(temp);
end;

// Multiply 2 FGInts modulo base, (FGInt1 * FGInt2) mod base = FGIntres

procedure FGIntMulMod(var FGInt1, FGInt2, base, FGIntRes: TFGInt);
var
  temp: TFGInt;
begin
  FGIntMul(FGInt1, FGInt2, temp);
  FGIntMod(temp, base, FGIntRes);
  FGIntDestroy(temp);
end;

// Exponentiate 2 FGInts modulo base, (FGInt1 ^ FGInt2) mod modb = res

procedure FGIntModExp(var FGInt, exp, Modb, Res: TFGInt);
var
  temp2, temp3: TFGInt;
  i: LongWord;
  S: string;
begin
  if (Modb.Number[1] Mod 2) = 1 then
  begin
    FGIntMontgomeryModExp(FGInt, exp, Modb, Res);
    exit;
  end;
  FGIntToBase2string(exp, S);
  Base10stringToFGInt('1', Res);
  FGIntCopy(FGInt, temp2);

  for i := Length(S) downto 1 do
  begin
    if S[i] = '1' then
    begin
      FGIntMulMod(Res, temp2, Modb, temp3);
      FGIntCopy(temp3, Res);
    end;
    FGIntSquareMod(temp2, Modb, temp3);
    FGIntCopy(temp3, temp2);
  end;
  FGIntDestroy(temp2);
end;

// procedures for Montgomery Exponentiation

procedure FGIntModBis(const FGInt: TFGInt; var FGIntOut: TFGInt;
  b, head: LongWord);
var
  i: LongWord;
begin
  if b <= FGInt.Number[0] then
  begin
    SetLength(FGIntOut.Number, (b + 1));
    for i := 0 to b do
      FGIntOut.Number[i] := FGInt.Number[i];
    FGIntOut.Number[b] := FGIntOut.Number[b] and head;
    i := b;
    while (FGIntOut.Number[i] = 0) and (i > 1) do
      i := i - 1;
    if i < b then
      SetLength(FGIntOut.Number, i + 1);
    FGIntOut.Number[0] := i;
    FGIntOut.Sign := Positive;
  End
  else
    FGIntCopy(FGInt, FGIntOut);
end;

procedure FGIntMulModBis(const FGInt1, FGInt2: TFGInt; var Prod: TFGInt;
  b, head: LongWord);
var
  i, j, size, size1, size2, t, rest: LongWord;
  Trest: int64;
begin
  size1 := FGInt1.Number[0];
  size2 := FGInt2.Number[0];
  size := min(b, size1 + size2);
  SetLength(Prod.Number, (size + 1));
  for i := 1 to size do
    Prod.Number[i] := 0;
  for i := 1 to size2 do
  begin
    rest := 0;
    t := min(size1, b - i + 1);
    for j := 1 to t do
    begin
      Trest := FGInt1.Number[j];
      Trest := Trest * FGInt2.Number[i];
      Trest := Trest + Prod.Number[j + i - 1];
      Trest := Trest + rest;
      Prod.Number[j + i - 1] := Trest and 2147483647;
      rest := Trest shr 31;
    end;
    if (i + size1) <= b then
      Prod.Number[i + size1] := rest;
  end;
  Prod.Number[0] := size;
  if size = b then
    Prod.Number[b] := Prod.Number[b] and head;
  while (Prod.Number[size] = 0) and (size > 1) do
    size := size - 1;
  if size < Prod.Number[0] then
  begin
    SetLength(Prod.Number, size + 1);
    Prod.Number[0] := size;
  end;
  if FGInt1.Sign = FGInt2.Sign then
    Prod.Sign := Positive
  else
    Prod.Sign := Negative;
end;

procedure FGIntMontgomeryMod(const GInt, base, baseInv: TFGInt;
  var MGInt: TFGInt; b: LongWord; head: LongWord);
var
  m, temp, temp1: TFGInt;
  r: LongWord;
begin
  FGIntModBis(GInt, temp, b, head);
  FGIntMulModBis(temp, baseInv, m, b, head);
  FGIntMul(m, base, temp1);
  FGIntDestroy(temp);
  FGIntAdd(temp1, GInt, temp);
  FGIntDestroy(temp1);
  MGInt.Number := Copy(temp.Number, b - 1, temp.Number[0] - b + 2);
  MGInt.Sign := Positive;
  MGInt.Number[0] := temp.Number[0] - b + 1;
  FGIntDestroy(temp);
  if (head shr 30) = 0 then
    FGIntDivByIntBis(MGInt, head + 1, r)
  else
    FGIntShiftRightBy31(MGInt);
  if FGIntCompareAbs(MGInt, base) <> St then
    FGIntSubBis(MGInt, base);
  FGIntDestroy(temp);
  FGIntDestroy(m);
end;

procedure FGIntMontgomeryModExp(var FGInt, exp, Modb, Res: TFGInt);
var
  temp2, temp3, baseInv, r, zero: TFGInt;
  i, j, t, b, head: LongWord;
  S: string;
begin
  Base2stringToFGInt('0', zero);
  FGIntMod(FGInt, Modb, Res);
  if FGIntCompareAbs(Res, zero) = Eq then
  begin
    FGIntDestroy(zero);
    exit;
  End
  else
    FGIntDestroy(Res);
  FGIntDestroy(zero);
  FGIntToBase2string(exp, S);
  t := Modb.Number[0];
  b := t;
  if (Modb.Number[t] shr 30) = 1 then
    t := t + 1;
  SetLength(r.Number, (t + 1));
  r.Number[0] := t;
  r.Sign := Positive;
  for i := 1 to t do
    r.Number[i] := 0;
  if t = Modb.Number[0] then
  begin
    head := 2147483647;
    for j := 29 downto 0 do
    begin
      head := head shr 1;
      if (Modb.Number[t] shr j) = 1 then
      begin
        r.Number[t] := 1 Shl (j + 1);
        Break;
      end;
    end;
  End
  else
  begin
    r.Number[t] := 1;
    head := 2147483647;
  end;
  FGIntModInv(Modb, r, temp2);
  if temp2.Sign = Negative then
    FGIntCopy(temp2, baseInv)
  else
  begin
    FGIntCopy(r, baseInv);
    FGIntSubBis(baseInv, temp2);
  end;
  // FGIntBezoutBachet(r, modb, temp2, BaseInv);
  FGIntAbs(baseInv);
  FGIntDestroy(temp2);
  FGIntMod(r, Modb, Res);
  FGIntMulMod(FGInt, Res, Modb, temp2);
  FGIntDestroy(r);
  for i := Length(S) downto 1 do
  begin
    if S[i] = '1' then
    begin
      FGIntMul(Res, temp2, temp3);
      FGIntDestroy(Res);
      FGIntMontgomeryMod(temp3, Modb, baseInv, Res, b, head);
      FGIntDestroy(temp3);
    end;
    FGIntSquare(temp2, temp3);
    FGIntDestroy(temp2);
    FGIntMontgomeryMod(temp3, Modb, baseInv, temp2, b, head);
    FGIntDestroy(temp3);
  end;
  FGIntDestroy(temp2);
  FGIntMontgomeryMod(Res, Modb, baseInv, temp3, b, head);
  FGIntCopy(temp3, Res);
  FGIntDestroy(temp3);
  FGIntDestroy(baseInv);
end;

// Compute the Greatest Common Divisor of 2 FGInts

procedure FGIntGCD(const FGInt1, FGInt2: TFGInt; var GCD: TFGInt);
var
  k: TCompare;
  zero, temp1, temp2, temp3: TFGInt;
begin
  k := FGIntCompareAbs(FGInt1, FGInt2);
  if (k = Eq) then
    FGIntCopy(FGInt1, GCD)
  else if (k = St) then
    FGIntGCD(FGInt2, FGInt1, GCD)
  else
  begin
    Base10stringToFGInt('0', zero);
    FGIntCopy(FGInt1, temp1);
    FGIntCopy(FGInt2, temp2);
    while (temp2.Number[0] <> 1) Or (temp2.Number[1] <> 0) do
    begin
      FGIntMod(temp1, temp2, temp3);
      FGIntCopy(temp2, temp1);
      FGIntCopy(temp3, temp2);
      FGIntDestroy(temp3);
    end;
    FGIntCopy(temp1, GCD);
    FGIntDestroy(temp2);
    FGIntDestroy(zero);
  end;
end;

// Compute the Least Common Multiple of 2 FGInts

procedure FGIntLCM(const FGInt1, FGInt2: TFGInt; var LCM: TFGInt);
var
  temp1, temp2: TFGInt;
begin
  FGIntGCD(FGInt1, FGInt2, temp1);
  FGIntMul(FGInt1, FGInt2, temp2);
  FGIntDiv(temp2, temp1, LCM);
  FGIntDestroy(temp1);
  FGIntDestroy(temp2);
end;

// Trialdivision of a FGInt upto 9999 and stopping when a divisor is found, returning ok=false

procedure FGIntTrialDiv9999(const FGInt: TFGInt; var Ok: Boolean);
var
  j: LongWord;
  i: Integer;
  s10: string;
begin
  if ((FGInt.Number[1] Mod 2) = 0) then
    Ok := false
  else
  begin
    i := 0;
    Ok := true;
    while Ok and (i < 1228) do
    begin
      i := i + 1;
      FGIntModByInt(FGInt, Primes[i], j);
      if j = 0 then
        Ok := false;
    end;
  end;
end;

// A prng

procedure FGIntRandom1(var Seed, RandomFGInt: TFGInt);
var
  temp, base: TFGInt;
begin
  Base10stringToFGInt('281474976710656', base);
  Base10stringToFGInt('44485709377909', temp);
  FGIntMulMod(Seed, temp, base, RandomFGInt);
  FGIntDestroy(temp);
  FGIntDestroy(base);
end;

// Perform a Rabin Miller Primality Test nrtest times on FGIntp, returns ok=true when FGIntp passes the test

procedure FGIntRabinMiller(var FGIntp: TFGInt; nrtest: LongWord;
  var Ok: Boolean);
var
  j, b, i: LongWord;
  m, z, temp1, temp2, temp3, zero, one, two, pmin1: TFGInt;
  ok1, ok2: Boolean;
begin
  randomize;
  Base10stringToFGInt('0', zero);
  Base10stringToFGInt('1', one);
  Base10stringToFGInt('2', two);
  FGIntSub(FGIntp, one, temp1);
  FGIntSub(FGIntp, one, pmin1);
  b := 0;
  while (temp1.Number[1] Mod 2) = 0 do
  begin
    b := b + 1;
    FGIntShiftRight(temp1);
  end;
  m := temp1;
  i := 0;
  Ok := true;
  randomize;
  while (i < nrtest) and Ok do
  begin
    j := 0;
    i := i + 1;
    Base10stringToFGInt(IntToStr(Primes[Random(1227) + 1]), temp2);
    FGIntMontgomeryModExp(temp2, m, FGIntp, z);
    FGIntDestroy(temp2);
    ok1 := (FGIntCompareAbs(z, one) = Eq);
    ok2 := (FGIntCompareAbs(z, pmin1) = Eq);
    if not (ok1 Or ok2) then
    begin
      while (Ok and (j < b)) do
      begin
        if (j > 0) and ok1 then
          Ok := false
        else
        begin
          j := j + 1;
          if (j < b) and (Not ok2) then
          begin
            FGIntSquareMod(z, FGIntp, temp3);
            FGIntCopy(temp3, z);
            ok1 := (FGIntCompareAbs(z, one) = Eq);
            ok2 := (FGIntCompareAbs(z, pmin1) = Eq);
            if ok2 then
              j := b;
          End
          else if (Not ok2) and (j >= b) then
            Ok := false;
        end;
      end;
    end;
  end;
  FGIntDestroy(zero);
  FGIntDestroy(one);
  FGIntDestroy(two);
  FGIntDestroy(m);
  FGIntDestroy(z);
  FGIntDestroy(pmin1);
end;

// Compute the coefficients from the Bezout Bachet theorem, FGInt1 * a + FGInt2 * b = GCD(FGInt1, FGInt2)

procedure FGIntBezoutBachet(var FGInt1, FGInt2, a, b: TFGInt);
var
  zero, r1, r2, r3, ta, GCD, temp, temp1, temp2: TFGInt;
begin
  if FGIntCompareAbs(FGInt1, FGInt2) <> St then
  begin
    FGIntCopy(FGInt1, r1);
    FGIntCopy(FGInt2, r2);
    Base10stringToFGInt('0', zero);
    Base10stringToFGInt('1', a);
    Base10stringToFGInt('0', ta);
    repeat
      FGIntDivMod(r1, r2, temp, r3);
      FGIntDestroy(r1);
      r1 := r2;
      r2 := r3;
      FGIntMul(ta, temp, temp1);
      FGIntSub(a, temp1, temp2);
      FGIntCopy(ta, a);
      FGIntCopy(temp2, ta);
      FGIntDestroy(temp1);
      FGIntDestroy(temp);
    until FGIntCompareAbs(r3, zero) = Eq;
    FGIntGCD(FGInt1, FGInt2, GCD);
    FGIntMul(a, FGInt1, temp1);
    FGIntSub(GCD, temp1, temp2);
    FGIntDestroy(temp1);
    FGIntDiv(temp2, FGInt2, b);
    FGIntDestroy(temp2);
    FGIntDestroy(ta);
    FGIntDestroy(r1);
    FGIntDestroy(r2);
    FGIntDestroy(GCD);
  end
  else
    FGIntBezoutBachet(FGInt2, FGInt1, b, a);
end;

// Find the (multiplicative) Modular inverse of a FGInt in a finite ring
// of additive order base

procedure FGIntModInv(const FGInt1, base: TFGInt; var Inverse: TFGInt);
var
  zero, one, r1, r2, r3, tb, GCD, temp, temp1, temp2: TFGInt;
begin
  Base10stringToFGInt('1', one);
  FGIntGCD(FGInt1, base, GCD);
  if FGIntCompareAbs(one, GCD) = Eq then
  begin
    FGIntCopy(base, r1);
    FGIntCopy(FGInt1, r2);
    Base10stringToFGInt('0', zero);
    Base10stringToFGInt('0', Inverse);
    Base10stringToFGInt('1', tb);
    repeat
      FGIntDestroy(r3);
      FGIntDivMod(r1, r2, temp, r3);
      FGIntCopy(r2, r1);
      FGIntCopy(r3, r2);
      FGIntMul(tb, temp, temp1);
      FGIntSub(Inverse, temp1, temp2);
      FGIntDestroy(Inverse);
      FGIntDestroy(temp1);
      FGIntCopy(tb, Inverse);
      FGIntCopy(temp2, tb);
      FGIntDestroy(temp);
    until FGIntCompareAbs(r3, zero) = Eq;
    if Inverse.Sign = Negative then
    begin
      FGIntAdd(base, Inverse, temp);
      FGIntCopy(temp, Inverse);
    end;
    FGIntDestroy(tb);
    FGIntDestroy(r1);
    FGIntDestroy(r2);
  end;
  FGIntDestroy(GCD);
  FGIntDestroy(one);
end;

// Perform a (combined) primality test on FGIntp consisting of a trialdivision upto 8192,
// if the FGInt passes perform nrRMtests Rabin Miller primality tests, returns ok when a
// FGInt is probably prime

procedure FGIntPrimetest(var FGIntp: TFGInt; nrRMtests: Integer;
  var Ok: Boolean);
begin
  FGIntTrialDiv9999(FGIntp, Ok);
  if Ok then
    FGIntRabinMiller(FGIntp, nrRMtests, Ok);
end;

// Computes the Legendre symbol for a any number and
// p a prime, returns 0 if p divides a, 1 if a is a
// quadratic residu mod p, -1 if a is a quadratic
// nonresidu mod p

procedure FGIntLegendreSymbol(var a, p: TFGInt; var L: Integer);
var
  temp1, temp2, temp3, temp4, temp5, zero, one: TFGInt;
  i: LongWord;
  ok1, ok2: Boolean;
begin
  Base10stringToFGInt('0', zero);
  Base10stringToFGInt('1', one);
  FGIntMod(a, p, temp1);
  if FGIntCompareAbs(zero, temp1) = Eq then
  begin
    FGIntDestroy(temp1);
    L := 0;
  End
  else
  begin
    FGIntDestroy(temp1);
    FGIntCopy(p, temp1);
    FGIntCopy(a, temp2);
    L := 1;
    while FGIntCompareAbs(temp2, one) <> Eq do
    begin
      if (temp2.Number[1] Mod 2) = 0 then
      begin
        FGIntSquare(temp1, temp3);
        FGIntSub(temp3, one, temp4);
        FGIntDestroy(temp3);
        FGIntDivByInt(temp4, temp3, 8, i);
        if (temp3.Number[1] Mod 2) = 0 then
          ok1 := false
        else
          ok1 := true;
        FGIntDestroy(temp3);
        FGIntDestroy(temp4);
        if ok1 = true then
          L := L * ( - 1);
        FGIntDivByIntBis(temp2, 2, i);
      End
      else
      begin
        FGIntSub(temp1, one, temp3);
        FGIntSub(temp2, one, temp4);
        FGIntMul(temp3, temp4, temp5);
        FGIntDestroy(temp3);
        FGIntDestroy(temp4);
        FGIntDivByInt(temp5, temp3, 4, i);
        if (temp3.Number[1] Mod 2) = 0 then
          ok2 := false
        else
          ok2 := true;
        FGIntDestroy(temp5);
        FGIntDestroy(temp3);
        if ok2 = true then
          L := L * ( - 1);
        FGIntMod(temp1, temp2, temp3);
        FGIntCopy(temp2, temp1);
        FGIntCopy(temp3, temp2);
      end;
    end;
    FGIntDestroy(temp1);
    FGIntDestroy(temp2);
  end;
  FGIntDestroy(zero);
  FGIntDestroy(one);
end;

// Compute a square root modulo a prime number
// SquareRoot^2 mod Prime = Square

procedure FGIntSquareRootModP(Square, Prime: TFGInt; var SquareRoot: TFGInt);
var
  one, n, b, S, r, temp, temp1, temp2, temp3: TFGInt;
  a, i, j: LongInt;
  L: Integer;
begin
  Base2stringToFGInt('1', one);
  Base2stringToFGInt('10', n);
  a := 0;
  FGIntLegendreSymbol(n, Prime, L);
  while L <> - 1 do
  begin
    FGIntAddBis(n, one);
    FGIntLegendreSymbol(n, Prime, L);
  end;
  FGIntCopy(Prime, S);
  S.Number[1] := S.Number[1] - 1;
  while (S.Number[1] Mod 2) = 0 do
  begin
    FGIntShiftRight(S);
    a := a + 1;
  end;
  FGIntMontgomeryModExp(n, S, Prime, b);
  FGIntAdd(S, one, temp);
  FGIntShiftRight(temp);
  FGIntMontgomeryModExp(Square, temp, Prime, r);
  FGIntDestroy(temp);
  FGIntModInv(Square, Prime, temp1);
  for i := 0 to (a - 2) do
  begin
    FGIntSquareMod(r, Prime, temp2);
    FGIntMulMod(temp1, temp2, Prime, temp);
    FGIntDestroy(temp2);
    for j := 1 to (a - i - 2) do
    begin
      FGIntSquareMod(temp, Prime, temp2);
      FGIntDestroy(temp);
      FGIntCopy(temp2, temp);
      FGIntDestroy(temp2);
    end;
    if FGIntCompareAbs(temp, one) <> Eq then
    begin
      FGIntMulMod(r, b, Prime, temp3);
      FGIntDestroy(r);
      FGIntCopy(temp3, r);
      FGIntDestroy(temp3);
    end;
    FGIntDestroy(temp);
    FGIntDestroy(temp2);
    if i = (a - 2) then
      Break;
    FGIntSquareMod(b, Prime, temp3);
    FGIntDestroy(b);
    FGIntCopy(temp3, b);
    FGIntDestroy(temp3);
  end;
  FGIntCopy(r, SquareRoot);
  FGIntDestroy(r);
  FGIntDestroy(S);
  FGIntDestroy(b);
  FGIntDestroy(temp1);
  FGIntDestroy(one);
  FGIntDestroy(n);
end;

end.
