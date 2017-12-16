program ProjectIndy;

uses
  Forms,
  Indy2 in 'Indy2.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
