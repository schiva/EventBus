unit EventPacket;

interface

Type
  TClearPacket = class(TObject)

  end;

  TEventPacket = class(TObject)
    private
      FData: Pointer;
      FMsg: String;
      function GetData: Pointer;
      procedure SetData(const Value: Pointer);
    public
      constructor Create(AMsg:String; AData:Pointer);  reintroduce; overload;
      constructor Create(AMsg:String);  reintroduce; overload;

      property Msg:String read FMsg Write FMsg;
      property Data: Pointer read GetData Write SetData;
  end;

implementation

{ TEvnetPacket }

constructor TEventPacket.Create(AMsg: String; AData: Pointer);
begin
  Self.Msg := AMsg;
  Self.Data := AData;
end;

constructor TEventPacket.Create(AMsg: String);
begin
  self.Msg := AMsg;
end;

function TEventPacket.GetData: Pointer;
begin
  Result := FData;
end;

procedure TEventPacket.SetData(const Value: Pointer);
begin
  FData := Value;
end;

end.
