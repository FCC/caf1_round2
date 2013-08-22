--make a state_centroids geometry table

drop table if exists analysis.caf1_round2_st_pt;

create table analysis.caf1_round2_st_pt as 
select gid, state, no_acs_locations, no_att_locations, no_centurylink_locations,
       no_fairpoint_locations,  no_frontier_locations, no_hawaiian_locations, 
       no_prtc_locations, no_windstream_locations, total_locations, total_dollar_support,
       geom
  from carto.state_centroids, analysis.caf1_round2_state
  where state_centroids.postal=caf1_round2_state.state
  order by state;

alter table analysis.caf1_round2_st_pt
  add CONSTRAINT state_centroids_pkey PRIMARY KEY (gid),
  add CONSTRAINT enforce_dims_geom CHECK (st_ndims(geom) = 2),
  add CONSTRAINT enforce_geotype_geom CHECK (geometrytype(geom) = 'POINT'::text OR geom IS NULL),
  add CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 4326);
  
CREATE INDEX analysis_caf1_round2_st_pt_gid_btree
  ON analysis.caf1_round2_st_pt
  USING btree
  (gid);
CREATE INDEX analysis_caf1_round2_st_pt_geom_gist
  ON analysis.caf1_round2_st_pt
  USING gist
  (geom);

select count(*) from analysis.caf1_round2_st_pt

