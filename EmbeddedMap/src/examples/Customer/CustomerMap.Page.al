page 50200 "Customer Map"
{
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            usercontrol(MapCtrl; MapAddin)
            {
                ApplicationArea = All;

                trigger OnControlReady()
                begin
                    EmbeddedMapSetup.Initialize();
                    EmbeddedMap := EmbeddedMapSetup.EmbeddedMapProvider;
                    CurrPage.MapCtrl.init();
                end;

                trigger OnAfterInit()
                begin
                    MapReady := true;
                    CurrCustomer := Rec;
                    EmbedMap();
                end;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        if true in [
            Rec.Address <> xRec.Address,
            Rec.City <> xRec.City,
            Rec."Country/Region Code" <> xRec."Country/Region Code"
        ] then
            EmbedMap();
    end;

    trigger OnAfterGetRecord()
    begin
        if MapReady then
            if format(Rec) <> Format(CurrCustomer) then begin //Event is triggered multiple times whereas control addin should only update once
                CurrCustomer := Rec;
                EmbedMap();
            end;
    end;

    local procedure Clear()
    begin
        CurrPage.MapCtrl.clear(); //Implementation detail (refactor)
    end;

    local procedure EmbedMap()
    var
        OpenStreetMap: Codeunit OpenStreetMap; //Implementation detail (remove)
        Address: JsonObject;
        SettingsAsJson: JsonObject;
    begin
        Clear();
        GenerateAddressJson(Address);

        //Implementation details below (refactor)
        SettingsAsJson.Add('positionStackApiKey', EmbeddedMapSetup.PositionStackApiKey);
        SettingsAsJson.Add('mapTilerKey', EmbeddedMapSetup.MapTilerKey);
        SettingsAsJson.Add('zoom', OpenStreetMap.GetZoomLevel(EmbeddedMapSetup.Zoom));
        CurrPage.MapCtrl.embedMap(Address, SettingsAsJson);
    end;

    local procedure GenerateAddressJson(var Address: JsonObject)
    begin
        Address.Add('address', Rec.Address);
        Address.Add('region', Rec.City);
        Address.Add('country', Rec."Country/Region Code");
    end;

    var
        EmbeddedMapSetup: Record EmbeddedMapSetup;
        CurrCustomer: Record Customer;
        EmbeddedMap: Interface EmbeddedMap;
        MapReady: Boolean;
}