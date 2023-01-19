codeunit 50104 "BubbleSort" implements ISort
{

    procedure Sort(IntegerList: List of [Integer])
    var
        Length, i, j : Integer;
    begin
        Length := IntegerList.Count;
        for i := 1 to Length do
            for j := 1 to Length - i do
                if IntegerList.Get(j) > IntegerList.Get(j + 1) then
                    Swap(IntegerList, j, j + 1);
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
