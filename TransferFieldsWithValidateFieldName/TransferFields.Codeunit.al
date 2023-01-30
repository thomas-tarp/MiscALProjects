codeunit 50150 "TransferFields"
{
    procedure TransferFieldsWithValidate(var TempFieldNameBuffer: Record "Field Name Buffer"; RecordVariant: Variant; var TargetTableRecordRef: RecordRef)
    var
        DataTypeManagement: Codeunit "Data Type Management";
        SourceRecordRef: RecordRef;
        TargetFieldRef: FieldRef;
        SourceFieldRef: FieldRef;
    begin
        DataTypeManagement.GetRecordRef(RecordVariant, SourceRecordRef);

        TempFieldNameBuffer.Reset();
        if not TempFieldNameBuffer.FindFirst() then
            exit;

        repeat
            if DataTypeManagement.FindFieldByName(SourceRecordRef, SourceFieldRef, TempFieldNameBuffer."Field Name") then
                if DataTypeManagement.FindFieldByName(TargetTableRecordRef, TargetFieldRef, TempFieldNameBuffer."Field Name") then
                    if TargetFieldRef.Class = FieldClass::Normal then
                        if TargetFieldRef.Value <> SourceFieldRef.Value then
                            TargetFieldRef.Validate(SourceFieldRef.Value);
        until TempFieldNameBuffer.Next() = 0;
    end;
}