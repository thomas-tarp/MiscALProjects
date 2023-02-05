controladdin "MapAddin"
{
    RequestedHeight = 500;
    MinimumHeight = 0;
    MaximumHeight = 700;
    MinimumWidth = 0;
    MaximumWidth = 900;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts = 'src\scripts\Map.js',
              'https://cdn.jsdelivr.net/npm/ol@v7.2.2/dist/ol.js';
    StyleSheets = 'src\scripts\style.css',
                  'https://cdn.jsdelivr.net/npm/ol@v7.2.2/ol.css';
    StartupScript = 'src\scripts\start.js';
    RefreshScript = 'src\scripts\start.js';

    event OnControlReady()
    event OnAfterInit()
    procedure init()
    procedure embedMap(Address: JsonObject; Settings: JsonObject)
    procedure clear();
}