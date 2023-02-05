enum 50200 "EmbeddedMapProvider" implements EmbeddedMap
{
    Extensible = true;
    Caption = 'Embedded Map Provider';
    DefaultImplementation = EmbeddedMap = OpenStreetMap;
    UnknownValueImplementation = EmbeddedMap = OpenStreetMap;

    value(1; OpenStreetMap)
    {
        Caption = 'Open Street Map';
        Implementation = EmbeddedMap = OpenStreetMap;
    }
}