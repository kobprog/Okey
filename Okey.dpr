program Okey;

{$R 'Resources.res' 'Resources.rc'}

uses
  Vcl.Forms,
  Windows,
  uOkey in 'uOkey.pas' {FormOkey},
  FGInt in 'FGInt.pas',
  DH in 'DH.pas',
  uHelp in 'uHelp.pas' {FormHelp};

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_RELOCS_STRIPPED}
{$WEAKLINKRTTI ON}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormOkey, FormOkey);
  Application.CreateForm(TFormHelp, FormHelp);
  Application.Run;
end.
