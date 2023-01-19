codeunit 50105 "BogoSort" implements ISort
{

    procedure Sort(IntegerList: List of [Integer])
    begin
        Length := IntegerList.Count;
        Shuffle(IntegerList);
    end;

    local procedure Shuffle(IntegerList: List of [Integer])
    var
        Index, RandomIndex : Integer;
    begin
        if IsSorted(IntegerList) then
            exit;

        for Index := 1 to Length do begin
            RandomIndex := Random(Length);
            Swap(IntegerList, Index, RandomIndex);
        end;

        Shuffle(IntegerList);
    end;

    local procedure IsSorted(IntegerList: List of [Integer]): Boolean
    var
        i: Integer;
    begin
        for i := 1 to IntegerList.Count - 1 do
            if IntegerList.Get(i) > IntegerList.Get(i + 1) then
                exit(false);
        exit(true);
    end;

    local procedure Swap(IntegerList: List of [Integer]; First: Integer; Second: Integer)
    var
        FirstValue: Integer;
    begin
        FirstValue := IntegerList.Get(First);
        IntegerList.Set(First, IntegerList.Get(Second));
        IntegerList.Set(Second, FirstValue);
    end;

    var
        Length: Integer;
}
