with import <nixpkgs> {};
let 
    customRPackages = with rPackages; [
        # For geolocating IP addresses 
        rgeolocate

        # For string interpolation
        glue

        # Geolocated IP data frame manipulation
        dplyr

        # For plotting maps
        leaflet
    ];

    customR = rWrapper.override {
        packages = customRPackages; 
    };

    customRStudio = rstudioWrapper.override {
        packages = customRPackages;
    };
in stdenv.mkDerivation rec {
    name = "kshaa-landing-access";

    buildInputs = [
        customR
        customRStudio

        # For parsing a geo-location database i.e. `/src/geodb.mmdb`
        libmaxminddb
    ];
}

