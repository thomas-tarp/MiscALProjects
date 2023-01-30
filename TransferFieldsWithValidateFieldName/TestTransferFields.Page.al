page 50150 "TestTransferFields"
{
    Caption = 'Test TransferFields';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Results)
            {
                field(SourceRec; SourceRecAsText)
                {
                    ApplicationArea = All;
                    Caption = 'Source Record';
                    ToolTip = 'Shows the source record as text';
                    MultiLine = true;
                }
                field(TargetRec; TargetRecAsText)
                {
                    ApplicationArea = All;
                    Caption = 'Target Record';
                    ToolTip = 'Shows the target record as text';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Transfer)
            {
                ApplicationArea = All;
                Image = TransferOrder;
                Caption = 'Transfer';
                ToolTip = 'Tests the TransferFields procedure';

                trigger OnAction()
                var
                    SourceRec: Record Customer;
                    TargetRec: Record Vendor;
                    Field: Record Field;
                    TempFieldNameBuffer: Record "Field Name Buffer" temporary;
                    DataTypeManagement: Codeunit "Data Type Management";
                    TransferFields: Codeunit TransferFields;
                    SourceRecordRef: RecordRef;
                    TargetRecordRef: RecordRef;
                    RecRefRetrievalErr: Label 'Could not retrieve record refs from input variants.';
                begin
                    SourceRec.FindFirst();
                    SourceRecAsText := Format(SourceRec);
                    TargetRec.Get('30000');
                    TargetRecordRef.GetTable(TargetRec);

                    if false in [DataTypeManagement.GetRecordRef(SourceRec, SourceRecordRef),
                                 DataTypeManagement.GetRecordRef(TargetRec, TargetRecordRef)] then
                        Error(RecRefRetrievalErr);

                    Field.SetRange(TableNo, SourceRecordRef.Number);
                    Field.SetFilter("No.", '2..5048|5050..1999999');
                    Field.SetFilter(ObsoleteState, '<>%1', Field.ObsoleteState::Removed);
                    if Field.FindSet() then
                        repeat
                            TempFieldNameBuffer.Init();
                            TempFieldNameBuffer.Validate("Field Name", SourceRecordRef.Field(Field."No.").Name);
                            TempFieldNameBuffer.Insert();
                        until Field.Next() < 1;

                    TransferFields.TransferFieldsWithValidate(TempFieldNameBuffer, SourceRec, TargetRecordRef);
                    TargetRecordRef.Modify();
                    TargetRec.Get(TargetRecordRef.RecordId);
                    TargetRecAsText := Format(TargetRec);
                end;
            }
            action(TransferAlt)
            {
                ApplicationArea = All;
                Image = TransferOrder;
                Caption = 'Transfer Alt';
                ToolTip = 'Tests an alternate transferfields procedure';

                trigger OnAction()
                var
                    SourceRec: Record Customer;
                    TargetRec: Record Vendor;
                    Field: Record Field;
                    DataTypeManagement: Codeunit "Data Type Management";
                    SourceRecordRef: RecordRef;
                    TargetRecVariant: Variant;
                    RecRefRetrievalErr: Label 'Could not retrieve record refs from input variants.';
                begin
                    SourceRec.FindFirst();
                    SourceRecAsText := Format(SourceRec);
                    TargetRec.Get('40000');
                    TargetRecVariant := TargetRec;

                    if not DataTypeManagement.GetRecordRef(SourceRec, SourceRecordRef) then
                        Error(RecRefRetrievalErr);

                    Field.SetRange(TableNo, SourceRecordRef.Number);
                    Field.SetFilter("No.", '2..5048|5050..1999999');
                    Field.SetFilter(ObsoleteState, '<>%1', Field.ObsoleteState::Removed);
                    Field.SetRange(Class, Field.Class::Normal);
                    if Field.FindSet() then
                        repeat
                            DataTypeManagement.ValidateFieldValue(TargetRecVariant, Field.FieldName, SourceRecordRef.Field(Field."No.").Value);
                        until Field.Next() < 1;

                    TargetRec := TargetRecVariant;
                    TargetRecAsText := Format(TargetRec);
                end;
            }
        }
    }

    var
        SourceRecAsText: Text[2048];
        TargetRecAsText: Text[2048];
}