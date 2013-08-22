
drop table if exists analysis.working;
create table analysis.working as
  select substr(block_fips,1,5) as cty_fips, count(*) as num_blocks,
  sum(round(no_high_cost_locations)) as tot_high_cost_locations,
  sum(round(no_med_cost_locations)) as tot_med_cost_locations
  from analysis.caf1_round2_block
  group by cty_fips
  order by cty_fips;

CREATE INDEX analysis_working_cty_btree
  ON analysis.working
  USING btree
  (cty_fips);
--select count(*) from analysis.working;

drop table if exists analysis.caf1_round2_cty_poly;
create table analysis.caf1_round2_cty_poly as
  select gid, cty as cty_fips, num_blocks, tot_high_cost_locations, tot_med_cost_locations, 
  geom
  from carto.county, analysis.working
  where county.cty=working.cty_fips;

ALTER TABLE analysis.caf1_round2_cty_poly OWNER TO postgres;
ALTER TABLE analysis.caf1_round2_cty_poly
  ADD CONSTRAINT analysis_caf1_round2_cty_poly_pkey PRIMARY KEY (gid),
  ADD CONSTRAINT enforce_dims_geom CHECK (st_ndims(geom) = 2),
  ADD CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 900913),
  ADD CONSTRAINT enforce_geotype_geom CHECK (geometrytype(geom) = 'POLYGON'::text OR geometrytype(geom) = 'MULTIPOLYGON'::text OR geom IS NULL);

CREATE INDEX analysis_caf1_round2_cty_poly_cty_fips_btree
  ON analysis.caf1_round2_cty_poly
  USING btree
  (cty_fips);
CREATE INDEX analysis_caf1_round2_cty_poly_gid_btree
  ON analysis.caf1_round2_cty_poly
  USING btree
  (gid);
CREATE INDEX analysis_caf1_round2_cty_poly_geom_gist
  ON analysis.caf1_round2_cty_poly
  USING gist
  (geom);