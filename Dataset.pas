unit Dataset;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLInstanceType = interface;
  IXMLInfoType = interface;
  IXMLNetworkType = interface;
  IXMLNodesType = interface;
  IXMLNodeType = interface;
  IXMLFleetType = interface;
  IXMLVehicle_profileType = interface;
  IXMLRequestsType = interface;
  IXMLRequestType = interface;
  IXMLTwType = interface;

{ IXMLInstanceType }

  IXMLInstanceType = interface(IXMLNode)
    ['{630F69E5-DC91-47B6-AB0B-2614A6FB1AAC}']
    { Property Accessors }
    function Get_Info: IXMLInfoType;
    function Get_Network: IXMLNetworkType;
    function Get_Fleet: IXMLFleetType;
    function Get_Requests: IXMLRequestsType;
    { Methods & Properties }
    property Info: IXMLInfoType read Get_Info;
    property Network: IXMLNetworkType read Get_Network;
    property Fleet: IXMLFleetType read Get_Fleet;
    property Requests: IXMLRequestsType read Get_Requests;
  end;

{ IXMLInfoType }

  IXMLInfoType = interface(IXMLNode)
    ['{D0406936-FC7A-40FE-BCF0-69D9385340BD}']
    { Property Accessors }
    function Get_Dataset: Extended;
    function Get_Name: Extended;
    procedure Set_Dataset(Value: Extended);
    procedure Set_Name(Value: Extended);
    { Methods & Properties }
    property Dataset: Extended read Get_Dataset write Set_Dataset;
    property Name: Extended read Get_Name write Set_Name;
  end;

{ IXMLNetworkType }

  IXMLNetworkType = interface(IXMLNode)
    ['{A6CC4353-46E0-4340-8D5B-A0D1CCCCD3BB}']
    { Property Accessors }
    function Get_Nodes: IXMLNodesType;
    function Get_Euclidean: Extended;
    function Get_Decimals: Integer;
    procedure Set_Euclidean(Value: Extended);
    procedure Set_Decimals(Value: Integer);
    { Methods & Properties }
    property Nodes: IXMLNodesType read Get_Nodes;
    property Euclidean: Extended read Get_Euclidean write Set_Euclidean;
    property Decimals: Integer read Get_Decimals write Set_Decimals;
  end;

{ IXMLNodesType }

  IXMLNodesType = interface(IXMLNodeCollection)
    ['{B9B126A7-B2E4-429A-896F-29021F408DF8}']
    { Property Accessors }
    function Get_Node(Index: Integer): IXMLNodeType;
    { Methods & Properties }
    function Add: IXMLNodeType;
    function Insert(const Index: Integer): IXMLNodeType;
    property Node[Index: Integer]: IXMLNodeType read Get_Node; default;
  end;

{ IXMLNodeType }

  IXMLNodeType = interface(IXMLNode)
    ['{B013DFE6-6CBF-442F-A5A2-3127BA7F7CE4}']
    { Property Accessors }
    function Get_Id: Integer;
    function Get_Type_: Integer;
    function Get_Cx: Extended;
    function Get_Cy: Extended;
    procedure Set_Id(Value: Integer);
    procedure Set_Type_(Value: Integer);
    procedure Set_Cx(Value: Extended);
    procedure Set_Cy(Value: Extended);
    { Methods & Properties }
    property Id: Integer read Get_Id write Set_Id;
    property Type_: Integer read Get_Type_ write Set_Type_;
    property Cx: Extended read Get_Cx write Set_Cx;
    property Cy: Extended read Get_Cy write Set_Cy;
  end;

{ IXMLFleetType }

  IXMLFleetType = interface(IXMLNode)
    ['{273C1D41-CCE6-4B83-A3BE-69AE0DE65AA5}']
    { Property Accessors }
    function Get_Vehicle_profile: IXMLVehicle_profileType;
    { Methods & Properties }
    property Vehicle_profile: IXMLVehicle_profileType read Get_Vehicle_profile;
  end;

{ IXMLVehicle_profileType }

  IXMLVehicle_profileType = interface(IXMLNode)
    ['{904A0C6A-C1E6-4C08-81B5-23F8547C7392}']
    { Property Accessors }
    function Get_Type_: Integer;
    function Get_Number: Integer;
    function Get_Departure_node: Integer;
    function Get_Arrival_node: Integer;
    function Get_Capacity: Extended;
    function Get_Max_travel_time: Extended;
    procedure Set_Type_(Value: Integer);
    procedure Set_Number(Value: Integer);
    procedure Set_Departure_node(Value: Integer);
    procedure Set_Arrival_node(Value: Integer);
    procedure Set_Capacity(Value: Extended);
    procedure Set_Max_travel_time(Value: Extended);
    { Methods & Properties }
    property Type_: Integer read Get_Type_ write Set_Type_;
    property Number: Integer read Get_Number write Set_Number;
    property Departure_node: Integer read Get_Departure_node write Set_Departure_node;
    property Arrival_node: Integer read Get_Arrival_node write Set_Arrival_node;
    property Capacity: Extended read Get_Capacity write Set_Capacity;
    property Max_travel_time: Extended read Get_Max_travel_time write Set_Max_travel_time;
  end;

{ IXMLRequestsType }

  IXMLRequestsType = interface(IXMLNodeCollection)
    ['{7B97EC7D-7D42-4D39-AE2C-7BDA5651796D}']
    { Property Accessors }
    function Get_Request(Index: Integer): IXMLRequestType;
    { Methods & Properties }
    function Add: IXMLRequestType;
    function Insert(const Index: Integer): IXMLRequestType;
    property Request[Index: Integer]: IXMLRequestType read Get_Request; default;
  end;

{ IXMLRequestType }

  IXMLRequestType = interface(IXMLNode)
    ['{CF9DB55B-D8F7-4681-A471-B3DBE01552E9}']
    { Property Accessors }
    function Get_Id: Integer;
    function Get_Node: Integer;
    function Get_Tw: IXMLTwType;
    function Get_Quantity: Extended;
    function Get_Service_time: Extended;
    procedure Set_Id(Value: Integer);
    procedure Set_Node(Value: Integer);
    procedure Set_Quantity(Value: Extended);
    procedure Set_Service_time(Value: Extended);
    { Methods & Properties }
    property Id: Integer read Get_Id write Set_Id;
    property Node: Integer read Get_Node write Set_Node;
    property Tw: IXMLTwType read Get_Tw;
    property Quantity: Extended read Get_Quantity write Set_Quantity;
    property Service_time: Extended read Get_Service_time write Set_Service_time;
  end;

{ IXMLTwType }

  IXMLTwType = interface(IXMLNode)
    ['{37B1550E-2A2E-4379-AF43-A3B85C7E8E54}']
    { Property Accessors }
    function Get_Start: Integer;
    function Get_End_: Integer;
    procedure Set_Start(Value: Integer);
    procedure Set_End_(Value: Integer);
    { Methods & Properties }
    property Start: Integer read Get_Start write Set_Start;
    property End_: Integer read Get_End_ write Set_End_;
  end;

{ Forward Decls }

  TXMLInstanceType = class;
  TXMLInfoType = class;
  TXMLNetworkType = class;
  TXMLNodesType = class;
  TXMLNodeType = class;
  TXMLFleetType = class;
  TXMLVehicle_profileType = class;
  TXMLRequestsType = class;
  TXMLRequestType = class;
  TXMLTwType = class;

{ TXMLInstanceType }

  TXMLInstanceType = class(TXMLNode, IXMLInstanceType)
  protected
    { IXMLInstanceType }
    function Get_Info: IXMLInfoType;
    function Get_Network: IXMLNetworkType;
    function Get_Fleet: IXMLFleetType;
    function Get_Requests: IXMLRequestsType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInfoType }

  TXMLInfoType = class(TXMLNode, IXMLInfoType)
  protected
    { IXMLInfoType }
    function Get_Dataset: Extended;
    function Get_Name: Extended;
    procedure Set_Dataset(Value: Extended);
    procedure Set_Name(Value: Extended);
  end;

{ TXMLNetworkType }

  TXMLNetworkType = class(TXMLNode, IXMLNetworkType)
  protected
    { IXMLNetworkType }
    function Get_Nodes: IXMLNodesType;
    function Get_Euclidean: Extended;
    function Get_Decimals: Integer;
    procedure Set_Euclidean(Value: Extended);
    procedure Set_Decimals(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNodesType }

  TXMLNodesType = class(TXMLNodeCollection, IXMLNodesType)
  protected
    { IXMLNodesType }
    function Get_Node(Index: Integer): IXMLNodeType;
    function Add: IXMLNodeType;
    function Insert(const Index: Integer): IXMLNodeType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNodeType }

  TXMLNodeType = class(TXMLNode, IXMLNodeType)
  protected
    { IXMLNodeType }
    function Get_Id: Integer;
    function Get_Type_: Integer;
    function Get_Cx: Extended;
    function Get_Cy: Extended;
    procedure Set_Id(Value: Integer);
    procedure Set_Type_(Value: Integer);
    procedure Set_Cx(Value: Extended);
    procedure Set_Cy(Value: Extended);
  end;

{ TXMLFleetType }

  TXMLFleetType = class(TXMLNode, IXMLFleetType)
  protected
    { IXMLFleetType }
    function Get_Vehicle_profile: IXMLVehicle_profileType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLVehicle_profileType }

  TXMLVehicle_profileType = class(TXMLNode, IXMLVehicle_profileType)
  protected
    { IXMLVehicle_profileType }
    function Get_Type_: Integer;
    function Get_Number: Integer;
    function Get_Departure_node: Integer;
    function Get_Arrival_node: Integer;
    function Get_Capacity: Extended;
    function Get_Max_travel_time: Extended;
    procedure Set_Type_(Value: Integer);
    procedure Set_Number(Value: Integer);
    procedure Set_Departure_node(Value: Integer);
    procedure Set_Arrival_node(Value: Integer);
    procedure Set_Capacity(Value: Extended);
    procedure Set_Max_travel_time(Value: Extended);
  end;

{ TXMLRequestsType }

  TXMLRequestsType = class(TXMLNodeCollection, IXMLRequestsType)
  protected
    { IXMLRequestsType }
    function Get_Request(Index: Integer): IXMLRequestType;
    function Add: IXMLRequestType;
    function Insert(const Index: Integer): IXMLRequestType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRequestType }

  TXMLRequestType = class(TXMLNode, IXMLRequestType)
  protected
    { IXMLRequestType }
    function Get_Id: Integer;
    function Get_Node: Integer;
    function Get_Tw: IXMLTwType;
    function Get_Quantity: Extended;
    function Get_Service_time: Extended;
    procedure Set_Id(Value: Integer);
    procedure Set_Node(Value: Integer);
    procedure Set_Quantity(Value: Extended);
    procedure Set_Service_time(Value: Extended);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTwType }

  TXMLTwType = class(TXMLNode, IXMLTwType)
  protected
    { IXMLTwType }
    function Get_Start: Integer;
    function Get_End_: Integer;
    procedure Set_Start(Value: Integer);
    procedure Set_End_(Value: Integer);
  end;

{ Global Functions }

function Getinstance(Doc: IXMLDocument): IXMLInstanceType;
function Loadinstance(const FileName: WideString): IXMLInstanceType;
function Newinstance: IXMLInstanceType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getinstance(Doc: IXMLDocument): IXMLInstanceType;
begin
  Result := Doc.GetDocBinding('instance', TXMLInstanceType, TargetNamespace) as IXMLInstanceType;
end;

function Loadinstance(const FileName: WideString): IXMLInstanceType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('instance', TXMLInstanceType, TargetNamespace) as IXMLInstanceType;
end;

function Newinstance: IXMLInstanceType;
begin
  Result := NewXMLDocument.GetDocBinding('instance', TXMLInstanceType, TargetNamespace) as IXMLInstanceType;
end;

{ TXMLInstanceType }

procedure TXMLInstanceType.AfterConstruction;
begin
  RegisterChildNode('info', TXMLInfoType);
  RegisterChildNode('network', TXMLNetworkType);
  RegisterChildNode('fleet', TXMLFleetType);
  RegisterChildNode('requests', TXMLRequestsType);
  inherited;
end;

function TXMLInstanceType.Get_Info: IXMLInfoType;
begin
  Result := ChildNodes['info'] as IXMLInfoType;
end;

function TXMLInstanceType.Get_Network: IXMLNetworkType;
begin
  Result := ChildNodes['network'] as IXMLNetworkType;
end;

function TXMLInstanceType.Get_Fleet: IXMLFleetType;
begin
  Result := ChildNodes['fleet'] as IXMLFleetType;
end;

function TXMLInstanceType.Get_Requests: IXMLRequestsType;
begin
  Result := ChildNodes['requests'] as IXMLRequestsType;
end;

{ TXMLInfoType }

function TXMLInfoType.Get_Dataset: Extended;
begin
  Result := ChildNodes['dataset'].NodeValue;
end;

procedure TXMLInfoType.Set_Dataset(Value: Extended);
begin
  ChildNodes['dataset'].NodeValue := Value;
end;

function TXMLInfoType.Get_Name: Extended;
begin
  Result := ChildNodes['name'].NodeValue;
end;

procedure TXMLInfoType.Set_Name(Value: Extended);
begin
  ChildNodes['name'].NodeValue := Value;
end;

{ TXMLNetworkType }

procedure TXMLNetworkType.AfterConstruction;
begin
  RegisterChildNode('nodes', TXMLNodesType);
  inherited;
end;

function TXMLNetworkType.Get_Nodes: IXMLNodesType;
begin
  Result := ChildNodes['nodes'] as IXMLNodesType;
end;

function TXMLNetworkType.Get_Euclidean: Extended;
begin
  Result := ChildNodes['euclidean'].NodeValue;
end;

procedure TXMLNetworkType.Set_Euclidean(Value: Extended);
begin
  ChildNodes['euclidean'].NodeValue := Value;
end;

function TXMLNetworkType.Get_Decimals: Integer;
begin
  Result := ChildNodes['decimals'].NodeValue;
end;

procedure TXMLNetworkType.Set_Decimals(Value: Integer);
begin
  ChildNodes['decimals'].NodeValue := Value;
end;

{ TXMLNodesType }

procedure TXMLNodesType.AfterConstruction;
begin
  RegisterChildNode('node', TXMLNodeType);
  ItemTag := 'node';
  ItemInterface := IXMLNodeType;
  inherited;
end;

function TXMLNodesType.Get_Node(Index: Integer): IXMLNodeType;
begin
  Result := List[Index] as IXMLNodeType;
end;

function TXMLNodesType.Add: IXMLNodeType;
begin
  Result := AddItem(-1) as IXMLNodeType;
end;

function TXMLNodesType.Insert(const Index: Integer): IXMLNodeType;
begin
  Result := AddItem(Index) as IXMLNodeType;
end;

{ TXMLNodeType }

function TXMLNodeType.Get_Id: Integer;
begin
  Result := AttributeNodes['id'].NodeValue;
end;

procedure TXMLNodeType.Set_Id(Value: Integer);
begin
  SetAttribute('id', Value);
end;

function TXMLNodeType.Get_Type_: Integer;
begin
  Result := AttributeNodes['type'].NodeValue;
end;

procedure TXMLNodeType.Set_Type_(Value: Integer);
begin
  SetAttribute('type', Value);
end;

function TXMLNodeType.Get_Cx: Extended;
begin
  Result := ChildNodes['cx'].NodeValue;
end;

procedure TXMLNodeType.Set_Cx(Value: Extended);
begin
  ChildNodes['cx'].NodeValue := Value;
end;

function TXMLNodeType.Get_Cy: Extended;
begin
  Result := ChildNodes['cy'].NodeValue;
end;

procedure TXMLNodeType.Set_Cy(Value: Extended);
begin
  ChildNodes['cy'].NodeValue := Value;
end;

{ TXMLFleetType }

procedure TXMLFleetType.AfterConstruction;
begin
  RegisterChildNode('vehicle_profile', TXMLVehicle_profileType);
  inherited;
end;

function TXMLFleetType.Get_Vehicle_profile: IXMLVehicle_profileType;
begin
  Result := ChildNodes['vehicle_profile'] as IXMLVehicle_profileType;
end;

{ TXMLVehicle_profileType }

function TXMLVehicle_profileType.Get_Type_: Integer;
begin
  Result := AttributeNodes['type'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Type_(Value: Integer);
begin
  SetAttribute('type', Value);
end;

function TXMLVehicle_profileType.Get_Number: Integer;
begin
  Result := AttributeNodes['number'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Number(Value: Integer);
begin
  SetAttribute('number', Value);
end;

function TXMLVehicle_profileType.Get_Departure_node: Integer;
begin
  Result := ChildNodes['departure_node'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Departure_node(Value: Integer);
begin
  ChildNodes['departure_node'].NodeValue := Value;
end;

function TXMLVehicle_profileType.Get_Arrival_node: Integer;
begin
  Result := ChildNodes['arrival_node'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Arrival_node(Value: Integer);
begin
  ChildNodes['arrival_node'].NodeValue := Value;
end;

function TXMLVehicle_profileType.Get_Capacity: Extended;
begin
  Result := ChildNodes['capacity'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Capacity(Value: Extended);
begin
  ChildNodes['capacity'].NodeValue := Value;
end;

function TXMLVehicle_profileType.Get_Max_travel_time: Extended;
begin
  Result := ChildNodes['max_travel_time'].NodeValue;
end;

procedure TXMLVehicle_profileType.Set_Max_travel_time(Value: Extended);
begin
  ChildNodes['max_travel_time'].NodeValue := Value;
end;

{ TXMLRequestsType }

procedure TXMLRequestsType.AfterConstruction;
begin
  RegisterChildNode('request', TXMLRequestType);
  ItemTag := 'request';
  ItemInterface := IXMLRequestType;
  inherited;
end;

function TXMLRequestsType.Get_Request(Index: Integer): IXMLRequestType;
begin
  Result := List[Index] as IXMLRequestType;
end;

function TXMLRequestsType.Add: IXMLRequestType;
begin
  Result := AddItem(-1) as IXMLRequestType;
end;

function TXMLRequestsType.Insert(const Index: Integer): IXMLRequestType;
begin
  Result := AddItem(Index) as IXMLRequestType;
end;

{ TXMLRequestType }

procedure TXMLRequestType.AfterConstruction;
begin
  RegisterChildNode('tw', TXMLTwType);
  inherited;
end;

function TXMLRequestType.Get_Id: Integer;
begin
  Result := AttributeNodes['id'].NodeValue;
end;

procedure TXMLRequestType.Set_Id(Value: Integer);
begin
  SetAttribute('id', Value);
end;

function TXMLRequestType.Get_Node: Integer;
begin
  Result := AttributeNodes['node'].NodeValue;
end;

procedure TXMLRequestType.Set_Node(Value: Integer);
begin
  SetAttribute('node', Value);
end;

function TXMLRequestType.Get_Tw: IXMLTwType;
begin
  Result := ChildNodes['tw'] as IXMLTwType;
end;

function TXMLRequestType.Get_Quantity: Extended;
begin
  Result := ChildNodes['quantity'].NodeValue;
end;

procedure TXMLRequestType.Set_Quantity(Value: Extended);
begin
  ChildNodes['quantity'].NodeValue := Value;
end;

function TXMLRequestType.Get_Service_time: Extended;
begin
  Result := ChildNodes['service_time'].NodeValue;
end;

procedure TXMLRequestType.Set_Service_time(Value: Extended);
begin
  ChildNodes['service_time'].NodeValue := Value;
end;

{ TXMLTwType }

function TXMLTwType.Get_Start: Integer;
begin
  Result := ChildNodes['start'].NodeValue;
end;

procedure TXMLTwType.Set_Start(Value: Integer);
begin
  ChildNodes['start'].NodeValue := Value;
end;

function TXMLTwType.Get_End_: Integer;
begin
  Result := ChildNodes['end'].NodeValue;
end;

procedure TXMLTwType.Set_End_(Value: Integer);
begin
  ChildNodes['end'].NodeValue := Value;
end;

end. 