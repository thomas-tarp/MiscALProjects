codeunit 50261 "AL Code Constant Format" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, '<Standard Format,2>'));
    end;
}