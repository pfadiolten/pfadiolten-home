map_box = OpenStruct.new(
  access_token: ENV['PFADIOLTEN_OSM_ACCESS_TOKEN'],
  id: 'mapbox.streets'
)

Leaflet.tile_layer = "https://api.tiles.mapbox.com/v4/#{map_box.id}/{z}/{x}/{y}.png?access_token=#{map_box.access_token}"
Leaflet.attribution = %w[
    map data &copy;
    <a href="http://openstreetmap.org">
      OpenStreetMap
    </a>
    contributors,
    <a href="http://creativecommons.org/licenses/by-sa/2.0/">
      CC-BY-SA
    </a>
    , imagery ©
    <a href="http://mapbox.com">
      Mapbox
    </a>
].join(' ')

Leaflet.max_zoom = 18