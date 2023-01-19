codeunit 50106 "GnomeSort" implements ISort
{
    procedure Sort(IntegerList: List of [Integer])
    var
        Index, Length : Integer;
    begin
        Index := 1;
        Length := IntegerList.Count;
        while Index <= Length do begin
            if Index = 1 then
                Index += 1;
            if IntegerList.Get(Index) >= IntegerList.Get(Index - 1) then
                Index += 1
            else begin
                Swap(IntegerList, Index, Index - 1);
                Index -= 1;
            end;
        end;
    end;

    local procedure Swap(IntegerList: List of [Integer]; First: Integer; Second: Integer)
    var
        FirstValue: Integer;
    begin
        FirstValue := IntegerList.Get(First);
        IntegerList.Set(First, IntegerList.Get(Second));
        IntegerList.Set(Second, FirstValue);
    end;
}
