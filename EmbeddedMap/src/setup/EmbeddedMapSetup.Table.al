table 50200 "EmbeddedMapSetup"
{
    DataClassification = CustomerContent;
    Caption = 'Embedded Map Setup';

    fields
    {
        field(1; "PK"; Code[10])
        {
            Caption = 'PK';
            DataClassification = SystemMetadata;
        }
        field(2; "Zoom"; Enum EmbeddedMapZoomLevel)
        {
            Caption = 'Zoom';
            DataClassification = CustomerContent;
        }
        field(3; "PositionStackApiKey"; Text[50])
        {
            Caption = 'Position Stack API Key';
            DataClassification = CustomerContent;
            Description = 'Should be saved in a secure place for production systems';
        }
        field(4; "MapTilerKey"; Text[50])
        {
            Caption = 'MapTilerKey';
            DataClassification = CustomerContent;
            Description = 'Should be saved in a secure place for production systems';
        }
        field(5; "EmbeddedMapProvider"; Enum EmbeddedMapProvider)
        {
            Caption = 'EmbeddedMapProvider';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "PK")
        {
            Clustered = true;
        }
    }

    procedure Initialize()
    begin
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}