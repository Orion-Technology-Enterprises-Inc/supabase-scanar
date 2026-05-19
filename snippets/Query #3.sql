ALTER TABLE shops
ADD CONSTRAINT shops_snap_location_id_unique
UNIQUE (snap_location_id);