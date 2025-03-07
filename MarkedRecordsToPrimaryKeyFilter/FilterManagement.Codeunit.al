namespace ThomasTarp.FilterManagement;

using System.Text;
using System.Reflection;

codeunit 50300 "Filter Management"
{
    procedure ConvertMarkedRecordsToPrimaryKeyFilters(var MarkedRecord: Variant)
    var
        RecRef: RecordRef;
        PrimaryKeyFields: List of [Integer];
        NotRecordErr: Label 'The variant must be a record when converting marked records to primary key filters.';
    begin
        if not MarkedRecord.IsRecord() then
            Error(NotRecordErr);
        RecRef.GetTable(MarkedRecord);
        PrimaryKeyFields := this.GetPrimaryKeyFields(RecRef.Number);
        this.SetCurrentKeyToPrimaryKey(RecRef);
        this.SetMarkedRecordFiltersOnPrimaryKeyFields(RecRef, PrimaryKeyFields);
        RecRef.MarkedOnly(false);
        RecRef.ClearMarks();
        RecRef.SetTable(MarkedRecord);
    end;

    procedure SetCurrentKeyToPrimaryKey(RecRef: RecordRef)
    begin
        RecRef.CurrentKeyIndex(1);
    end;

    procedure SetMarkedRecordFiltersOnPrimaryKeyFields(var RecRef: RecordRef; PrimaryKeyFields: List of [Integer])
    var
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        FieldRef: FieldRef;
        FieldNo: Integer;
    begin
        foreach FieldNo in PrimaryKeyFields do begin
            FieldRef := RecRef.Field(FieldNo);
            FieldRef.SetFilter(SelectionFilterManagement.GetSelectionFilter(RecRef, FieldNo));
        end;
    end;

    procedure GetFieldFilters(var RecRef: RecordRef; FieldNos: List of [Integer]) FieldFilters: Dictionary of [Integer, Text]
    var
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        FieldNo: Integer;
    begin
        foreach FieldNo in FieldNos do
            FieldFilters.Add(FieldNo, SelectionFilterManagement.GetSelectionFilter(RecRef, FieldNo));
    end;

    local procedure GetPrimaryKeyFields(TableNo: Integer) PrimaryKeyFields: List of [Integer]
    var
        Field: Record Field;
        PrimaryKeyFieldsNotFoundErr: Label 'The primary key fields for table %1 could not be found.', Comment = '%1 = TableNo';
    begin
        Field.SetCurrentKey(TableNo, "No.");
        Field.SetRange(TableNo, TableNo);
        Field.SetRange(IsPartOfPrimaryKey, true);
        if not Field.FindSet() then
            Error(PrimaryKeyFieldsNotFoundErr, TableNo);
        repeat
            PrimaryKeyFields.Add(Field."No.");
        until Field.Next() = 0;
    end;
}