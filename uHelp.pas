unit uHelp;

interface

uses
  Vcl.Forms,
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Imaging.jpeg,
  SysUtils,
  ShellApi,
  Windows,
  WinInet,
  Vcl.FileCtrl;

type
  TFormHelp = class(TForm)
    Image1: TImage;
    LabelGitHub: TLabel;
    ButtonClose: TButton;
    MemoAbout: TMemo;
    ButtonUpdate: TButton;
    procedure ButtonCloseClick(Sender: TObject);
    procedure LabelGitHubClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonUpdateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHelp: TFormHelp;

implementation

{$R *.dfm}

uses uOkey;

procedure TFormHelp.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormHelp.ButtonUpdateClick(Sender: TObject);
const
  BufferSize = 64;
var
  hSession, hURL: HInternet;
  Buffer: array [1 .. BufferSize] of Byte;
  BufferLen: DWORD;
  sAppName: string;
  OkeyFile: File;
  OkeyFileName: string;
  DownloadDir: string;
  s: string;
begin
  if Pos(sDownload, ButtonUpdate.Caption) > 0 then
  begin
    if SelectDirectory('Выберите папку для загрузки ' + sName +' ' + OkeyLastVersionStr,
      '', DownloadDir) then
    begin
      ButtonUpdate.Caption := 'Загрузка...';
      Application.ProcessMessages;
      OkeyFileName := DownloadDir + '\' + sName + ' ' + OkeyLastVersionStr + '.exe';
      sAppName := ExtractFileName(Application.ExeName);
      hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG,
        nil, nil, 0);
      hURL := InternetOpenURL(hSession, PChar(sExeURL), nil, 0, 0, 0);
      AssignFile(OkeyFile, OkeyFileName);
      Rewrite(OkeyFile, 1);
      repeat
        InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
        BlockWrite(OkeyFile, Buffer, BufferLen);
      until BufferLen = 0;
      CloseFile(OkeyFile);
      InternetCloseHandle(hURL);
      InternetCloseHandle(hSession);
      ButtonUpdate.Caption := sCheckUpdate;
    end;
    Exit;
  end;
  if (ButtonUpdate.Caption = sCheckUpdate) or (ButtonUpdate.Caption = sError)
  then
  begin
    ButtonUpdate.Caption := 'Проверка...';
    Application.ProcessMessages;
    Sleep(500);
    sAppName := ExtractFileName(Application.ExeName);
    hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG,
      nil, nil, 0);
    hURL := InternetOpenURL(hSession, PChar(sReadMeURL), nil, 0, 0, 0);
    InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
    s := UTF8ToString(Buffer);
    InternetCloseHandle(hURL);
    InternetCloseHandle(hSession);
    OkeyLastVersionStr := FormOkey.GetVersionStr(s);
    OkeyLastVersion := 0;
    if OkeyLastVersionStr <> '' then
    begin
      OkeyLastVersion := StrToFloat(OkeyLastVersionStr.Replace('.', ','));
      if OkeyVersion < OkeyLastVersion then
        ButtonUpdate.Caption := sDownload + ' ' + OkeyLastVersionStr
      else
        ButtonUpdate.Caption := sLastVersion;
    end
    else
      ButtonUpdate.Caption := sError;
  end;
end;

procedure TFormHelp.FormCreate(Sender: TObject);
begin
  MemoAbout.Text := OkeyReadMe.Text;
  ButtonUpdate.Visible := OkeyVersion > 0;
end;

procedure TFormHelp.LabelGitHubClick(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'https://github.com/kobprog/Okey.git', nil,
    nil, SW_SHOW);
end;

end.
