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
                    CurrPage.MapCtrl.init();
                    EmbeddedMapSetup.Initialize();
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

    local procedure EmbedMap()
    var
        AdressAsJson: JsonObject;
        SettingsAsJson: JsonObject;
    begin
        CurrPage.MapCtrl.clear();
        AdressAsJson.Add('address', Rec.Address);
        AdressAsJson.Add('region', Rec.City);
        AdressAsJson.Add('country', Rec."Country/Region Code");
        SettingsAsJson.Add('positionStackApiKey', EmbeddedMapSetup.PositionStackApiKey);
        SettingsAsJson.Add('mapTilerKey', EmbeddedMapSetup.MapTilerKey);
        SettingsAsJson.Add('zoom', EmbeddedMapSetup.Zoom);
        CurrPage.MapCtrl.embedMap(AdressAsJson, SettingsAsJson);
    end;

    var
        EmbeddedMapSetup: Record EmbeddedMapSetup;
        CurrCustomer: Record Customer;
        MapReady: Boolean;
}