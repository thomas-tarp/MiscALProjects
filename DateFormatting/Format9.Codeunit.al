codeunit 50258 "Format 9" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, 9));
    end;
}