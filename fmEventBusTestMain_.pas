unit fmEventBusTestMain_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.Threading,
  fmChild1_, fmChild2_
  ;

type
  TfmEventBusTestMain = class(TForm)
    btShowSubForm: TButton;
    btPostDefault: TButton;
    btPostContext: TButton;
    btPostThread: TButton;
    Label1: TLabel;
    btPostClear: TButton;
    procedure btShowSubFormClick(Sender: TObject);
    procedure btPostDefaultClick(Sender: TObject);
    procedure btPostContextClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btPostThreadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btPostClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEventBusTestMain: TfmEventBusTestMain;

implementation

{$R *.dfm}

uses
  EventBus, EventPacket;



procedure TfmEventBusTestMain.btShowSubFormClick(Sender: TObject);
var
  x, y: integer;
  procedure setLocation(x,y:integer; fm:TCustomform);
  begin
    fm.Left := x;
    fm.Top  := y;
  end;
begin
  if not Assigned(fmChild1) then
    fmChild1 := TfmChild1.Create(self);

  if not Assigned(fmChild2) then
    fmChild2 := TfmChild2.Create(self);


  x := self.Left + self.Width + 10;
  y := self.Top;

  fmChild1.Show;
  setLocation(x,y, fmChild1);

  y := y + fmchild1.Height + 10;

  fmChild2.Show;
  setLocation(x,y, fmChild2);
end;

procedure TfmEventBusTestMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(fmChild1) then fmChild1.Close;
  if Assigned(fmChild2) then fmChild2.Close;
  
  Action := caFree;
end;

procedure TfmEventBusTestMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TfmEventBusTestMain.btPostDefaultClick(Sender: TObject);
var
  LMsg:String;
  Packet: TEventPacket;
begin
  LMsg := format('%s - %s', [ System.SysUtils.FormatDateTime('hh:nn:ss:zzz',now), 'new data' ]);

  Packet := TEventPacket.Create(LMsg, Pointer(Sender));
  GlobalEventBus.Post( Packet );
end;

procedure TfmEventBusTestMain.btPostThreadClick(Sender: TObject);
begin
  TTask.Run(
    procedure
    var
      LMsg:String;
      Packet: TEventPacket;
      LCount: integer;
    begin
      LCount := 0;
      while LCount <= 3 do
      begin
        LMsg := format('%s - %s', [ System.SysUtils.FormatDateTime('hh:nn:ss:zzz',now), ' Thread Posting.. ' ]);

        Packet := TEventPacket.Create(LMsg, Pointer(Sender));
        GlobalEventBus.Post( Packet );
        TThread.Sleep(500);
        inc(LCount);
      end;

    end);
end;

procedure TfmEventBusTestMain.btPostClearClick(Sender: TObject);
begin
  GlobalEventBus.Post( TClearPacket.Create );
end;

procedure TfmEventBusTestMain.btPostContextClick(Sender: TObject);
var
  LMsg:String;
  Packet: TEventPacket;
begin
  LMsg := format('%s - %s', [ System.SysUtils.FormatDateTime('hh:nn:ss:zzz',now), 'new data' ]);

  Packet := TEventPacket.Create(LMsg, Pointer(Sender));
  GlobalEventBus.Post( Packet, 'TestContext' );

end;

end.
