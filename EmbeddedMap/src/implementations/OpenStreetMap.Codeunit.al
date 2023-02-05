codeunit 50200 "OpenStreetMap" implements EmbeddedMap
{
    procedure EmbedMap(Address: JsonObject; EmbeddedMapSetup: Record EmbeddedMapSetup);
    begin
        //TODO: Must retrieve specific instance of control addin (cannot be passed)
    end;

    procedure Clear();
    begin
        //TODO: Must retrieve specific instance of control addin (cannot be passed)
    end;

    procedure GetZoomLevel(ZoomLevel: Enum EmbeddedMapZoomLevel): Integer //Should be local when interface is used
    begin
        case ZoomLevel of
            ZoomLevel::Close:
                exit(20);
            ZoomLevel::Medium:
                exit(12);
            ZoomLevel::Far:
                exit(5);
            else
                exit(12);
        end;
    end;
}