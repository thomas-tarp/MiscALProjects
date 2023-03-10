page 50201 "EmbeddedMapSetup"
{
    Caption = 'Embedded Map Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = EmbeddedMapSetup;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(EmbeddedMapProvider; Rec.EmbeddedMapProvider)
                {
                    ApplicationArea = All;
                    ToolTip = 'Choose the provider for embedded maps. This will affect how embedded maps are displayed.';
                }
                field(Zoom; Rec.Zoom)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default zoom level for embedded maps';
                }
            }
            group(OpenStreetMap)
            {
                Caption = 'Open Street Map';

                field(PositionStackApiKey; Rec.PositionStackApiKey)
                {
                    ApplicationArea = All;
                    ToolTip = 'Position Stack is used for converting addresses to coordinates';
                }
                field(MapTilerKey; Rec.MapTilerKey)
                {
                    ApplicationArea = All;
                    ToolTip = 'Map Tiler is used for loading custom map graphics';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Initialize();
    end;
}