page 50250 "DateFormatter"
{
    Caption = 'Date Formatter';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Setup)
            {
                Caption = 'Setup';

                field(FormatProviderFld; FormatProvider)
                {
                    ApplicationArea = All;
                    Caption = 'Formatter';
                    ToolTip = 'Defines the format to use for formatting the date.';

                    trigger OnValidate()
                    begin
                        Update();
                    end;
                }

                field(InputDateFld; InputDate)
                {
                    ApplicationArea = All;
                    Caption = 'Input Date';
                    ToolTip = 'Sets the date to format. If you leave it blank, it will use the null-date (0D).';

                    trigger OnValidate()
                    begin
                        Update();
                    end;
                }
            }
            group(Results)
            {
                Caption = 'Results';
                Editable = false;

                field(DateAsTextFld; DateAsText)
                {
                    ApplicationArea = All;
                    Caption = 'Date as Text';
                    ToolTip = 'Shows the input date as text.';
                }
                field(OutputDate; OutputDate)
                {
                    ApplicationArea = All;
                    Caption = 'Result Date';
                    ToolTip = 'Shows the date as text converted back to a date. If it cannot be converted, it will be blank.';
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(UpdateDatePmtd; UpdateDate) { }
        }
        area(Processing)
        {
            action(UpdateDate)
            {
                ApplicationArea = All;
                Image = Process;
                Caption = 'Update date';
                ToolTip = 'Updates the result date and text';

                trigger OnAction()
                begin
                    Update();
                end;
            }
        }
    }

    local procedure Update()
    var
        Formatter: Interface Formatter;
    begin
        Formatter := FormatProvider;
        DateAsText := Formatter.FormatDate(InputDate);
        TextToDate();
    end;

    local procedure TextToDate()
    begin
        if not Evaluate(OutputDate, DateAsText) then
            OutputDate := 0D;
    end;

    var
        FormatProvider: Enum FormatProvider;
        InputDate: Date;
        OutputDate: Date;
        DateAsText: Text;
}