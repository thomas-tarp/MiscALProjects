table 50150 "Field Name Buffer"
{
    Caption = 'Field Buffer';
    ReplicateData = false;
    TableType = Temporary;

    fields
    {
        field(1; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Field Name")
        {
            Clustered = true;
        }
    }
}