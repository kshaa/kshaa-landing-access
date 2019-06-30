library('rgeolocate')
library('leaflet')
library('dplyr')
library('glue')

# Parse IPs
ips <- scan("./data/ips.txt", what = c(""))
geoIps <- maxmind(ips, "./data/geodb.mmdb", c("country_name", "city_name", "latitude", "longitude")) %>%
  mutate("popup" = glue("
    <dl>
      <dt>Country</dt><dd>{country_name}</dd>
      <dt>City</dt><dd>{city_name}</dd>
    </dl>
  "))

# Render map
m <- leaflet(data = geoIps) %>%
  addTiles() %>%
  addMarkers(popup = ~popup)
m
