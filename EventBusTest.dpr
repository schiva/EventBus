program EventBusTest;

uses
  Vcl.Forms,
  fmEventBusTestMain_ in 'fmEventBusTestMain_.pas' {fmEventBusTestMain},
  fmChild1_ in 'fmChild1_.pas' {fmChild1},
  fmChild2_ in 'fmChild2_.pas' {fmChild2},
  EventPacket in 'EventPacket.pas',
  PacketListen in 'PacketListen.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmEventBusTestMain, fmEventBusTestMain);
  Application.Run;
end.
