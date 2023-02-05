page 50202 "Vendor Map"
{
    PageType = CardPart;
    SourceTable = Vendor;

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
                    CurrVendor := Rec;
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
            if format(Rec) <> Format(CurrVendor) then begin //Event is triggered multiple times whereas control addin should only update once
                CurrVendor := Rec;
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
        CurrVendor: Record Vendor;
        MapReady: Boolean;
}