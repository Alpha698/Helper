unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Tabs, Vcl.Grids;

type
  TMainForm = class(TForm)
    edtHost: TEdit;
    edtPort: TEdit;
    edtMessage: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    IdTCPClient1: TIdTCPClient;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    memRcvMessage: TMemo;
    TabSheet2: TTabSheet;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edtMessageKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    OKDone: Boolean;
    FirstRowDone: Boolean;
    procedure ParseDataAndShowInGrid(Data: string);
  public
    { Public declarations }
  end;

    TRecvThread = class(TThread)
  private
    Msg : string;

    procedure ReceivedLine;

  protected
    procedure Execute; override;
  end;

var
  MainForm: TMainForm;
  RecvThread : TRecvThread;


implementation

procedure TRecvThread.Execute;
begin
  while not Terminated do begin
    try
      Msg := MainForm.IdTCPClient1.Socket.ReadLn;
      Synchronize(ReceivedLine);
    except
      Terminate;
    end;
  end;
end;

 procedure TMainForm.ParseDataAndShowInGrid(Data: string);
var
  DelimiterPos: Integer;
  FieldList: TStringList;
  i: Integer;
begin
  if not MainForm.OKDone then
  begin
    if Data = '+OK' then
    begin
      MainForm.OKDone := True;
      MainForm.StringGrid1.ColCount := 0;
      MainForm.StringGrid1.RowCount := 0;
      Exit;
    end;
  end
  else if MainForm.OKDone and not MainForm.FirstRowDone then
  begin
    FieldList := TStringList.Create;
    try
      with MainForm.StringGrid1 do
      begin
        DelimiterPos := Pos(#0183, Data);
        { Получить список имен полей таблицы БД }
        while DelimiterPos > 0 do
        begin
          FieldList.Add(Copy(Data, 1, DelimiterPos -1));
          Delete(Data, 1, DelimiterPos);
          DelimiterPos := Pos(#0183, Data);
        end;
        FieldList.Add(Data);
        { Записать имена полей в StringGrid }
        ColCount := FieldList.Count;
        RowCount := 2;
        FixedRows := 1;
        for i := 0 to FieldList.Count -1 do
          Cells[i, 0] := FieldList[i];
      end;
    finally
      FieldList.Free;
    end;
    MainForm.FirstRowDone := True;
  end
  else
  begin
    i := 0;
    with MainForm.StringGrid1 do
    begin
      DelimiterPos := Pos(#0183, Data);
      while DelimiterPos > 0 do
      begin
        Cells[i, RowCount -1] := Copy(Data, 1, DelimiterPos -1);
        Delete(Data, 1, DelimiterPos);
        DelimiterPos := Pos(#0183, Data);
        inc(i);
      end;
      Cells[i, RowCount -1] := Data;
      RowCount := RowCount + 1;
    end;
  end;
end;

procedure TRecvThread.ReceivedLine;
begin
  if Copy(Msg,1,4) = '-Err' then
    MessageDlg(Copy(Msg,5,Length(Msg)), mtError, [mbOk],0)
  else
   begin
        if AnsiCompareText(Copy(MainForm.edtMessage.Text, 1, 4), 'SQL:') = 0 then
      MainForm.ParseDataAndShowInGrid(Msg)
    else
      MainForm.memRcvMessage.Lines.Add(Msg)

   end;
end;


{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
begin
   { Задать значения для свойств Host и Port и соединиться }
  with IdTCPClient1 do
  begin
    Host := edtHost.Text;
    Port := StrToInt(edtPort.Text);
    Connect;
  end;
  { Создать поток и заблокировать кнопки }
  RecvThread := TRecvThread.Create(False);
  Button1.Enabled := False;
  Button2.Enabled := True;

end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
   { Перевести поток в terminate и ожидать, пока он не будет остановлен } RecvThread.Terminate;
  repeat
    Application.ProcessMessages;
  until RecvThread.Terminated;
{ Разорвать соединение }
  IdTCPClient1.Disconnect;
  Button1.Enabled := True;
  Button2.Enabled := False;
end;

procedure TMainForm.edtMessageKeyPress(Sender: TObject; var Key: Char);
begin
  { Если нажата клавиша ENTER, послать текст из edtMessage серверу }
  OKDone := False;
  FirstRowDone := False;
  if Key = #13 then
  begin
    IdTCPClient1.Socket.WriteLn(edtMessage.Text);
  end;
end;

end.
