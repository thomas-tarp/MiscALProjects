enum 50100 "SortingAlgorithm" implements ISort
{
    Extensible = true;
    UnknownValueImplementation = ISort = ErrorSort;
    DefaultImplementation = ISort = MergeSort;

    value(0; InsertionSort)
    {
        Caption = 'Insertion Sort';
        Implementation = ISort = InsertionSort;
    }
    value(1; MergeSort)
    {
        Caption = 'Merge Sort';
        Implementation = ISort = MergeSort;
    }
    value(2; QuickSort)
    {
        Caption = 'Quick Sort';
        Implementation = ISort = QuickSort;
    }
    value(3; BubbleSort)
    {
        Caption = 'Bubble Sort';
        Implementation = ISort = BubbleSort;
    }
    value(4; BogoSort)
    {
        Caption = 'Bogo Sort';
        Implementation = ISort = BogoSort;
    }
    value(5; GnomeSort)
    {
        Caption = 'Gnome Sort';
        Implementation = ISort = GnomeSort;
    }
}