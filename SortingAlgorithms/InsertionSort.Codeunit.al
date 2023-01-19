codeunit 50100 "InsertionSort" implements ISort
{
    procedure Sort(IntegerList: List of [Integer])
    var
        ListLength, CurrentElement, Index, AlreadySortedIndex : Integer;
    begin
        ListLength := IntegerList.Count;
        for Index := 2 to ListLength do begin
            CurrentElement := IntegerList.Get(Index);
            AlreadySortedIndex := Index - 1;

            while IntegerList.Get(AlreadySortedIndex) > CurrentElement do begin
                IntegerList.Set(AlreadySortedIndex + 1, IntegerList.get(AlreadySortedIndex));
                AlreadySortedIndex -= 1;
                if AlreadySortedIndex = 0 then
                    break;
            end;
            IntegerList.Set(AlreadySortedIndex + 1, CurrentElement);
        end;
    end;
}