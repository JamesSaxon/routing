ALTER TABLE configuration ADD COLUMN maxspeed_urban FLOAT DEFAULT 25;
ALTER TABLE configuration ADD COLUMN maxspeed_rural FLOAT DEFAULT 25;

UPDATE configuration SET maxspeed_urban = CASE
    WHEN tag_value = 'road'              THEN 15 -- Rare -- basically unclassified.
    WHEN tag_value = 'motorway'          THEN 50 -- Interstates
    WHEN tag_value = 'motorway_link'     THEN 30
    WHEN tag_value = 'motorway_junction' THEN 30 -- empty 
    WHEN tag_value = 'trunk'             THEN 35 -- Lake Shore Drive, major highways
    WHEN tag_value = 'trunk_link'        THEN 25 -- 
    WHEN tag_value = 'primary'           THEN 25 -- Commerical strips w/ stoplights.
    WHEN tag_value = 'primary_link'      THEN 20 -- 
    WHEN tag_value = 'secondary'         THEN 20
    WHEN tag_value = 'secondary_link'    THEN 20
    WHEN tag_value = 'tertiary'          THEN 20
    WHEN tag_value = 'tertiary_link'     THEN 15
    WHEN tag_value = 'residential'       THEN 12
    WHEN tag_value = 'living_street'     THEN 10
    WHEN tag_value = 'service'           THEN 7
    WHEN tag_value = 'track'             THEN 7
    WHEN tag_value = 'pedestrian'        THEN 2
    WHEN tag_value = 'services'          THEN 2
    WHEN tag_value = 'bus_guideway'      THEN 2
    WHEN tag_value = 'path'              THEN 5
    WHEN tag_value = 'cycleway'          THEN 10
    WHEN tag_value = 'footway'           THEN 2
    WHEN tag_value = 'bridleway'         THEN 2
    WHEN tag_value = 'byway'             THEN 2
    WHEN tag_value = 'steps'             THEN 0.1
    WHEN tag_value = 'unclassified'      THEN 15
    WHEN tag_value = 'lane'              THEN 10 -- Bikes 
    WHEN tag_value = 'track'             THEN 20
    WHEN tag_value = 'opposite_lane'     THEN 10
    WHEN tag_value = 'opposite'          THEN 10
    WHEN tag_value = 'grade1'            THEN 10
    WHEN tag_value = 'grade2'            THEN 10
    WHEN tag_value = 'grade3'            THEN 10
    WHEN tag_value = 'grade4'            THEN 10
    WHEN tag_value = 'grade5'            THEN 10
    WHEN tag_value = 'roundabout'        THEN 25 -- Almost none.
    ELSE 25
  END;

UPDATE configuration SET maxspeed_rural = CASE
    WHEN tag_value = 'motorway'          THEN 75 -- Interstates
    WHEN tag_value = 'motorway_link'     THEN 35
    WHEN tag_value = 'motorway_junction' THEN 35 -- empty 
    WHEN tag_value = 'trunk'             THEN 70 -- Lake Shore Driver, major highways
    WHEN tag_value = 'trunk_link'        THEN 35 -- 
    WHEN tag_value = 'primary'           THEN 60 -- Commerical strips w/ stoplights.
    WHEN tag_value = 'primary_link'      THEN 25 -- 
    WHEN tag_value = 'secondary'         THEN 35
    WHEN tag_value = 'secondary_link'    THEN 20
    WHEN tag_value = 'tertiary'          THEN 25
    WHEN tag_value = 'tertiary_link'     THEN 20
    WHEN tag_value = 'residential'       THEN 20
    WHEN tag_value = 'living_street'     THEN 15
    WHEN tag_value = 'service'           THEN 15
    WHEN tag_value = 'track'             THEN 15
    WHEN tag_value = 'pedestrian'        THEN 2
    WHEN tag_value = 'services'          THEN 2
    WHEN tag_value = 'bus_guideway'      THEN 2
    WHEN tag_value = 'path'              THEN 5
    WHEN tag_value = 'cycleway'          THEN 10
    WHEN tag_value = 'footway'           THEN 2
    WHEN tag_value = 'bridleway'         THEN 2
    WHEN tag_value = 'byway'             THEN 2
    WHEN tag_value = 'steps'             THEN 0.1
    WHEN tag_value = 'lane'              THEN 10 -- Bikes 
    WHEN tag_value = 'track'             THEN 20
    WHEN tag_value = 'opposite_lane'     THEN 10
    WHEN tag_value = 'opposite'          THEN 10
    WHEN tag_value = 'grade1'            THEN 10
    WHEN tag_value = 'grade2'            THEN 10
    WHEN tag_value = 'grade3'            THEN 10
    WHEN tag_value = 'grade4'            THEN 10
    WHEN tag_value = 'grade5'            THEN 10
    WHEN tag_value = 'roundabout'        THEN 25 -- Almost none.
    WHEN tag_value = 'unclassified'      THEN 25
    WHEN tag_value = 'road'              THEN 20 -- Rare -- basically unclassified.
    ELSE 25
  END;


ALTER TABLE ways_vertices_pgr ADD COLUMN hway BOOLEAN DEFAULT(FALSE);

UPDATE ways_vertices_pgr
SET hway = TRUE
FROM ways 
JOIN configuration ON 
  configuration.tag_id = ways.tag_id
WHERE
  (ways.source_osm = ways_vertices_pgr.osm_id OR
   ways.target_osm = ways_vertices_pgr.osm_id) AND
  configuration.tag_value IN ('motorway', 'motorway_junction', 'motorway_link', 'trunk', 'trunk_link')
;



