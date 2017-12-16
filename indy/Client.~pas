unit Client;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdAntiFreezeBase, IdAntiFreeze, ExtCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TForm1 = class(TForm)
    Client: TIdTCPClient;
    Panel1: TPanel;
    Panel2: TPanel;
    IdAntiFreeze1: TIdAntiFreeze;
    Memo1: TMemo;

    Button1: TButton;
    Button2: TButton;
    Panel3: TPanel;
    Label1: TLabel;
    lboxResults: TListBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
memo1.Clear;
lboxResults.Clear;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
  s: string;
begin
 button1.Enabled := true;
  try
    lboxResults.Clear;
    with Client do begin
      Connect; try
        lboxResults.Items.Add(ReadLn);
        for i := 0 to memo1.Lines.Count - 1 do begin
          WriteLn('PostIndex ' + memo1.Lines[i]);
          lboxResults.Items.Add(memo1.Lines[i]);
 
          s := ReadLn;
          if s = '' then begin
            s := '-- No entry found for this Post Index.';
          end;
          lboxResults.Items.Add(s);
 
          lboxResults.Items.Add('');
        end;
        WriteLn('Quit');
      finally Disconnect; end;
    end;
  finally button1.Enabled := true; end;
end;

end.
